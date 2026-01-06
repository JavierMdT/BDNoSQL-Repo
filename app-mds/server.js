const express = require('express');
const { MongoClient } = require('mongodb');
const neo4j = require('neo4j-driver');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const mongoUrl = 'mongodb://localhost:27017';
const mongoClient = new MongoClient(mongoUrl);

const uri = 'bolt://localhost:7687';
const user = 'neo4j';
const password = 'password123';

const neoDriver = neo4j.driver(uri, neo4j.auth.basic(user, password));
async function connectDB() {
    try {
        await mongoClient.connect();
        console.log('✅ Conectado con éxito a MongoDB');
    } catch (err) {
        console.error('❌ Error crítico conectando a MongoDB:', err);
    }
}
connectDB();

app.get('/api/map-data', async (req, res) => {
    try {
        // Asegúrate de que este nombre coincide con tu DB (metrocampus o test)
        const db = mongoClient.db('test'); 
        const estaciones = await db.collection('estaciones').find().toArray();
        const lineas = await db.collection('lineas').find().toArray();
        const campus = await db.collection('campus').find().toArray();
        res.json({ estaciones, lineas, campus });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.get('/api/ruta-detallada', async (req, res) => {
    const { origen, campusId } = req.query;
    const session = neoDriver.session();
    try {
        const result = await session.run(`
            MATCH (o:Estacion {nombre: $origen})
            MATCH (c:Campus {_id: $campusId})-[:cercana {tipo: "principal"}]->(d:Estacion)
            MATCH p = shortestPath((o)-[:siguiente*..40]-(d))
            RETURN 
                [n in nodes(p) | n._id] AS idsEstaciones,
                [r in relationships(p) | r.linea] AS lineasPorTramo,
                toInteger(length(p)) AS numeroParadas
        `, { origen, campusId });

        if (result.records.length === 0) return res.status(404).json({ error: "No hay ruta" });

        const rec = result.records[0];
        res.json({
            ids: rec.get('idsEstaciones'),
            tramos: rec.get('lineasPorTramo'),
            // Convertimos a número simple para evitar el [object Object]
            distancia: rec.get('numeroParadas').toNumber ? rec.get('numeroParadas').toNumber() : rec.get('numeroParadas')
        });
    } catch (err) { res.status(500).json({ error: err.message }); }
    finally { await session.close(); }
});

app.use(express.static('public'));
app.listen(3000, () => console.log(`🚀 Servidor MDS en http://localhost:3000`));

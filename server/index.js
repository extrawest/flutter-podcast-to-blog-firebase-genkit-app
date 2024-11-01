import express from 'express';
import cors from 'cors'; // Import the cors package
import routes from './routes/routes.js';
import 'dotenv/config'; // This will load the environment variables from .env file

const app = express();

// Enable CORS for all routes
app.use(cors());

// Middleware to parse JSON bodies
app.use(express.json());

app.use('/api', routes);

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

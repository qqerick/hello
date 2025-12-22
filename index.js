import express from "express";
import fetch from "node-fetch";
import dotenv from "dotenv";

dotenv.config(); // Loads .env file

const app = express();
app.use(express.json());
app.use(express.static("public"));

app.post("/tts", async (req, res) => {
  const { text, voice_id } = req.body;

  // 1. Basic Validation
  if (!text || !voice_id) {
    return res.status(400).json({ error: "Missing text or voice_id" });
  }

  try {
    const response = await fetch(
      `https://api.elevenlabs.io/v1/text-to-speech/${voice_id}/stream`, // Use /stream endpoint
      {
        method: "POST",
        headers: {
          "xi-api-key": process.env.ELEVENLABS_API_KEY,
          "Content-Type": "application/json",
          "accept": "audio/mpeg",
        },
        body: JSON.stringify({
          text: text,
          model_id: "eleven_multilingual_v2",
          voice_settings: {
            stability: 0.5,
            similarity_boost: 0.75,
          },
        }),
      }
    );

    if (!response.ok) {
      const errorData = await response.json();
      return res.status(response.status).json(errorData);
    }

    // 2. Pipe the stream directly to the client
    res.set("Content-Type", "audio/mpeg");
    response.body.pipe(res); 

  } catch (error) {
    console.error("TTS Server Error:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.listen(3000, () => console.log("Server running on http://localhost:3000"));

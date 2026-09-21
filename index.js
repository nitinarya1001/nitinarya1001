import express from "express";
import dotenv from "dotenv";
dotenv.config({ quiet: true });

const PORT = process.env.PORT;
const app = express();

app.use(express.static("public"));

app.get("/", async (_, res) => {
  res.sendFile("index.html");
});

app.listen(PORT, () => {
  console.log("server is running...");
});

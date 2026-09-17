import express from "express";
import dotenv from "dotenv";
import rateLimit from "express-rate-limit";
dotenv.config({ quiet: true });

const PORT = process.env.PORT;
const app = express();

const globalLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  limit: 100,
  standardHeaders: "draft-7",
  legacyHeaders: false,
  statusCode: 429,
  message: {
    error: "Too Many Requests",
    message: "You have exceeded your 100 requests per 15 minutes limit.",
    retryAfter: "Check retry headers for precise wait time.",
  },
});

app.use(globalLimiter);
app.use(express.static("public"));

app.get("/", async (_, res) => {
  res.sendFile("index.html");
});

app.listen(PORT, () => {
  console.log("server is running...");
});

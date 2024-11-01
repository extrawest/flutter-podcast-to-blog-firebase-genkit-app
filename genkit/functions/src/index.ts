import * as z from "zod";

// Import the Genkit core libraries and plugins.
import {generate} from "@genkit-ai/ai";
import {configureGenkit} from "@genkit-ai/core";
import {firebase} from "@genkit-ai/firebase";
import {vertexAI, gemini15Flash, imagen2} from "@genkit-ai/vertexai";

// Import models from the Vertex AI plugin. The Vertex AI API provides access to
// several generative models. Here, we import Gemini 1.5 Flash.

// From the Firebase plugin, import the functions needed to deploy flows using
// Cloud Functions.
import {onFlow, noAuth} from "@genkit-ai/firebase/functions";
configureGenkit({
  plugins: [
    // Load the Firebase plugin, which provides integrations with several
    // Firebase services.
    firebase(),
    // Load the Vertex AI plugin. You can optionally specify your project ID
    // by passing in a config object; if you don't, the Vertex AI plugin uses
    // the value from the GCLOUD_PROJECT environment variable.
    vertexAI({location: "us-central1"}),
  ],
  // Log debug output to tbe console.
  logLevel: "debug",
  // Perform OpenTelemetry instrumentation and enable trace collection.
  enableTracingAndMetrics: true,
});

export const summarizeFlow = onFlow(
  {
    name: "summarizeFlow",
    inputSchema: z.string(),
    outputSchema: z.string(),
    authPolicy: noAuth(),
  },
  async (url: string) => {
    const llmResponse = await generate({
      prompt: `First, fetch this link: "${url}". 
      Then, summarize the content within 20 words.`,
      model: gemini15Flash, // Specify the model to use for generation
      tools: [],
      config: {
        temperature: 1, // Set the creativity/variation of the response
      },
    });

    return llmResponse.text();
  }
);

export const imageGenerationFlow = onFlow(
  {
    name: "imageGenerationFlow",
    inputSchema: z.string(),
    outputSchema: z.object({
      imageUrl: z.string(),
    }),
    authPolicy: noAuth(),
  },
  async (imageDescription: string) => {
    try {
      const imageResult = await generate({
        model: imagen2,
        prompt: imageDescription,
        output: {format: "media"},
      });
      const generatedImage = imageResult.media();

      console.log("Image Response Type:", typeof generatedImage);

      if (
        generatedImage &&
                generatedImage.url &&
                generatedImage.contentType
      ) {
        // The image data is in the URL field as a base64 string
        const base64Data = generatedImage.url.split(",")[1];

        return {
          imageUrl: `data:${generatedImage.contentType};base64,${base64Data}`,
        };
      }

      throw new Error("Unable to extract image data from response");
    } catch (error) {
      console.error("Error in imageGenerationFlow:", error);
      throw error;
    }
  }
);

export const translationFlow = onFlow(
  {
    name: "translationFlow",
    inputSchema: z.string(),
    outputSchema: z.string(),
    authPolicy: noAuth(),
  },
  async (url: string) => {
    const llmResponse = await generate({
      prompt: `Use this text "${url}". 
      translate it to French`,
      model: gemini15Flash, // Specify the model to use for generation
      tools: [],
      config: {
        temperature: 1, // Set the creativity/variation of the response
      },
    });

    return llmResponse.text();
  }
);

// Define the schema for the content array items
const ContentItem = z.object({
  text: z.string(),
});

// Define the schema for messages
const Message = z.object({
  role: z.enum(["system", "user"]),
  content: z.array(ContentItem),
});

// Define the schema for the entire input
const ChatInputSchema = z.object({
  messages: z.array(Message),
  config: z.object({
    temperature: z.number(),
    topK: z.number(),
    topP: z.number(),
  }),
  tools: z.array(z.unknown()),
});

export const chatFlow = onFlow(
  {
    name: "chatFlow",
    inputSchema: ChatInputSchema,
    outputSchema: z.string(),
    authPolicy: noAuth(),
  },
  async (input: z.infer<typeof ChatInputSchema>) => {
    // Extract system message and user message
    const systemMessage =
            input.messages.find((msg) => msg.role === "system")?.content[0]
              ?.text || "";
    const userMessage =
            input.messages
              .find((msg) => msg.role === "user")
              ?.content.map((item) => item.text)
              .join(" ") || "";

    // Construct the prompt
    const prompt = `
System: ${systemMessage}

User: ${userMessage}
    `;
    // Generate response using the modified prompt
    const llmResponse = await generate({
      prompt: prompt,
      model: gemini15Flash,

      config: {
        temperature: input.config.temperature,
        topK: input.config.topK,
        topP: input.config.topP,
      },
    });

    return llmResponse.text();
  }
);

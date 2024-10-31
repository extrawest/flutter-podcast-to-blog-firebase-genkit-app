import * as z from 'zod';

// Import the Genkit core libraries and plugins.
import { generate } from '@genkit-ai/ai';
import { configureGenkit } from '@genkit-ai/core';
import { firebase } from '@genkit-ai/firebase';
import { vertexAI, gemini15Flash, imagen2 } from '@genkit-ai/vertexai';

// Import models from the Vertex AI plugin. The Vertex AI API provides access to
// several generative models. Here, we import Gemini 1.5 Flash.

// From the Firebase plugin, import the functions needed to deploy flows using
// Cloud Functions.
import { onFlow, noAuth } from '@genkit-ai/firebase/functions';
configureGenkit({
    plugins: [
        // Load the Firebase plugin, which provides integrations with several
        // Firebase services.
        firebase(),
        // Load the Vertex AI plugin. You can optionally specify your project ID
        // by passing in a config object; if you don't, the Vertex AI plugin uses
        // the value from the GCLOUD_PROJECT environment variable.
        vertexAI({ location: 'us-central1' }),
    ],
    // Log debug output to tbe console.
    logLevel: 'debug',
    // Perform OpenTelemetry instrumentation and enable trace collection.
    enableTracingAndMetrics: true,
});

export const summarizeFlow = onFlow(
    {
        name: 'summarizeFlow',
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
        name: 'imageGenerationFlow',
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
                output: { format: 'media' },
            });
            const generatedImage = imageResult.media();

            console.log('Image Response Type:', typeof generatedImage);

            if (
                generatedImage &&
                generatedImage.url &&
                generatedImage.contentType
            ) {
                // The image data is in the URL field as a base64 string
                const base64Data = generatedImage.url.split(',')[1]; // Remove the "data:image/png;base64," part

                return {
                    imageUrl: `data:${generatedImage.contentType};base64,${base64Data}`,
                };
            }

            throw new Error('Unable to extract image data from response');
        } catch (error) {
            console.error('Error in imageGenerationFlow:', error);
            throw error;
        }
    }
);

export const translationFlow = onFlow(
    {
        name: 'translationFlow',
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

import 'dotenv/config';
import fetch from 'node-fetch';

export class ChatRepository {
    constructor() {}

    async performChat(message, context) {
        const url = 'https://chatflow-b74e5wflra-uc.a.run.app';
        const requestBody = {
            data: {
                messages: [
                    {
                        role: 'system',
                        content: [
                            {
                                text: `You are a friendly chatbot answering questions about this subject: ${context}`,
                            },
                        ],
                    },
                    {
                        role: 'user',
                        content: [
                            {
                                text: message,
                            },
                        ],
                    },
                ],
                config: {
                    temperature: 0.4,
                    topK: 32,
                    topP: 0.95,
                },
                tools: [],
            },
        };

        console.log('Request body:', JSON.stringify(requestBody, null, 2));

        try {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestBody),
            });

            if (!response.ok) {
                const errorBody = await response.text();
                console.error('Error response body:', errorBody);
                throw new Error(
                    `HTTP error! status: ${response.status}, body: ${errorBody}`
                );
            }

            const result = await response.text();
            console.log('chat result:', result);

            return result;
        } catch (error) {
            console.error('Error in performChat:', error);
            throw error;
        }
    }
}

// Create and export a default instance
export const chatRepository = new ChatRepository();

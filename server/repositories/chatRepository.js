import 'dotenv/config';
import fetch from 'node-fetch';
import constants from '../consts.js';

export class ChatRepository {
    constructor() {}

    async performChat(message, context) {
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

        try {
            const response = await fetch(constants.CHAT_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestBody),
            });

            if (!response.ok) {
                const errorBody = await response.text();
                throw new Error(
                    `HTTP error! status: ${response.status}, body: ${errorBody}`
                );
            }

            const result = await response.text();

            return result;
        } catch (error) {
            throw error;
        }
    }
}

// Create and export a default instance
export const chatRepository = new ChatRepository();

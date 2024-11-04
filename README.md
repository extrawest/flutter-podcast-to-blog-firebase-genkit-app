#  Firebase Genkit AI flutter app for PodcastIndex.org
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()
[![Maintaner](https://img.shields.io/static/v1?label=Oleksandr%20Samoilenko&message=Maintainer&color=red)](mailto:oleksandr.samoilenko@extrawest.com)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)]()
![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)
![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)

## PROJECT INFO
- **Flutter app with Firebase Genkit AI for PodcastIndex.org**
- **This app is designed to provide a way to cooperate with PodcastIndex.org. You can listen to podcasts, get text version, short summary, audio file based on summary, and AI chat on the subject of podcast**

## Features
- Flutter podcast_search package
- Elevenlabs text to speech
- Firebase Genkit Ai summarize with gemini15Flash model
- PodcastIndex with podcastdx-client npm package
- Firebase Genkit Ai text-to-image with imagen2 model
- Huggingface speech-to-text with openai/whisper-large-v3-turbo model
- Firebase Genkit Ai chat completion with gemini15Flash

## Preview

1. Podcast Index Search demo
  <img src="https://github.com/extrawest/flutter-podcast-to-blog-ai-app/blob/main/demo/search.gif" alt="Preview" width="400"/>
  
2. Speech to text and image generation with imagen2 and gemini15Flash models
  <img src="https://github.com/extrawest/flutter-podcast-to-blog-ai-app/blob/main/demo/image_&_text.gif" alt="Preview" width="400"/>
  
3. Text to speech and image generation with elevenlabs model 
  <img src="https://github.com/extrawest/flutter-podcast-to-blog-ai-app/blob/main/demo/summry&audio.gif" alt="Preview" width="400"/>
  
4. Chat with gemini15Flash model 
  <img src="https://github.com/extrawest/flutter-podcast-to-blog-ai-app/blob/main/demo/chat.gif" alt="Preview" width="400"/>
  
## Installing:
**1. Clone this repo to your folder:**

```
git clone https://gitlab.extrawest.com/i-training/flutter/podcast-to-blog-firebase-genkit-app
```

**2. Change current directory to the cloned folder:**

```
cd podcast-to-blog-firebase-genkit-app/mobile
```

**3. Get packages**

```
flutter pub get
```

## Upload Firebase Genkit AI flows to Firebase cloud functions
**2. Go to genkit/functions folder:**
**1. Login to firebase and connect to your project**
**2. Deploy functions**
```
firebase deploy --only functions
```
**Once the deployment is done, you can run local server**

## Setup Server
**1. Open server folder:**

```
cd podcast-to-blog-firebase-genkit-app/server
```

**2. In the root of server file create .env file and add the following variables:**

```
HF_KEY='YOUR_HUGGINGFACE_KEY'
ELEVANLABS_KEY='YOUR_ELEVENLABS_KEY'
PODCAST_INDEX_API_KEY = 'YOUR_PODCAST_INDEX_API_KEY'
PODCAST_INDEX_API_SECRET = 'YOUR_PODCAST_INDEX_API_SECRET'
PORT = YOUR_PORT_NUMBER
```


**2. Change server path in flutter project:**
Go to app/lib/services/api_service.dart and change the baseUrl to your server path

Now you can use the app

## Preview
![Preview](https://gitlab.extrawest.com/i-training/flutter/podcast-to-blog-ai-app/-/blob/flutter_ui/demo/search.gif)
![Preview](https://gitlab.extrawest.com/i-training/flutter/podcast-to-blog-ai-app/-/blob/flutter_ui/demo/image_&_text.gif)
![Preview](https://gitlab.extrawest.com/i-training/flutter/podcast-to-blog-ai-app/-/blob/flutter_ui/demo/summry&audio.gif)
![Preview](https://gitlab.extrawest.com/i-training/flutter/podcast-to-blog-ai-app/-/blob/flutter_ui/demo/chat.gif)


Created by Oleksandr Samoilenko

[Extrawest.com](https://www.extrawest.com), 2024


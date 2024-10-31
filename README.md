gcloud auth application-default login --project podcast-to-blog-genkit-app

curl -X POST http://localhost:4001/run/summarizeFlow -H "Content-Type: application/json" -d '{"data": "WoltModalSheet is designed to revolutionize the use of modal sheets in Flutter apps. Built with Wolt-grade design quality and used extensively in Wolt products, this UI component offers a visually appealing and highly customizable modal sheets with multiple pages, motion for page transitions, and scrollable content within each page."}'

curl -X POST http://localhost:3100/travelRecommendationFlow -H "Content-Type: application/json" -d '{"data": "New York City"}'
curl -X POST http://localhost:4001/api/flows/travelRecommendationFlow -H "Content-Type: application/json" -d '{"data": "New York City"}'



curl -X POST https://travelrecommendationflow-b74e5wflra-uc.a.run.app -H "Content-Type: application/json" \ -H "Authorization: Bearer token1234" \-d '{"data": "New York City"}'
curl -X POST https://summarizeflow-b74e5wflra-uc.a.run.app -H "Content-Type: application/json" -d '{"data": "WoltModalSheet is designed to revolutionize the use of modal sheets in Flutter apps. Built with Wolt-grade design quality and used extensively in Wolt products, this UI component offers a visually appealing and highly customizable modal sheets with multiple pages, motion for page transitions, and scrollable content within each page."}'

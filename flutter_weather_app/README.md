#I2WEATHER APP
##Description
This is a test task for the company. I tried to maintain a clean application architecture, and used BLoC(Cubit) for the presentation architecture. I did not refactor the code (will be updated), and also did not try hard on the UI. It turned out pretty good ;).
Due to the workload, I spent 2 hours a day working on the project, only at night. Average project time ~ 20 hours.
##How to start
1. Get repository on your computer.
2. Run flutter pub get
>equatable: ^2.0.5
>either_dart: ^0.3.0>http: ^0.13.5
>shared_preferences: ^2.0.15
>get_it: ^7.2.0
>flutter_bloc: ^8.1.1
3. Get your api key from [OpenWeatherForecast](https://openweathermap.org)
4. Open terminal and write: - flutter run --dart-define API_KEY={YOU API KEY}, or change launch.json
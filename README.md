# NTUST QS Survey
## HOW TO Deploy
- `git clone https://github.com/jhang-jhe-wei/ntust-qs-survey.git`
- `cd NTUST-QS-SURVEY`
- `mv .env.example .env`
- Fill out `.env`
- `docker-compose build --build-arg RAILS_MASTER_KEY=<MASTER_KEY>`
- `docker-compose up`

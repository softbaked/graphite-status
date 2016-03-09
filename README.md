### Setup with docker

```
docker build -t graphite-noti .
docker run --rm -p 9292:9292 -v [YOUR_PATH/config.json]:/app/config.json graphite-noti
```


### Exmaple Config

```
{
  "graphite_url": "YOUR_GRAPHITE_URL",
  "alerts": [
    {
      "target": "jobs.message_1",
      "check_type": "is_more_than",
      "threshold_value": 100
    },
    {
      "target": "jobs.mailer",
      "check_type": "is_less_than",
      "threshold_value": 100
    },
    {
      "target": "jobs.event*",
      "check_type": "is_dead"
    }
  ]
}
```

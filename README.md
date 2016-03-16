### Setup with docker

```
docker build -t graphite-noti .
docker run softbaked/graphite-status:init --rm -p 9292:9292 -v [YOUR_PATH/config.json]:/app/config.json graphite-status
```


### Exmaple Config

9 .. 21 = morning

22 .. 24 = before_midnight

1 .. 8 = midnight


```
{
  "graphite_url": "YOUR_GRAPHITE_URL",
  "alerts": [
    {
      "target": "jobs.message_1",
      "check_type": "is_more_than",
      "threshold_value": 100,
      "time_ranges" : {
        "morning": 5,
        "before_midnight": 15,
        "midnight": 60
      }
    },
    {
      "target": "jobs.mailer",
      "check_type": "is_less_than",
      "threshold_value": 100,
      "time_ranges" : {
        "morning": 10,
        "before_midnight": 15,
        "midnight": 90
      }
    },
    {
      "target": "jobs.event*",
      "check_type": "is_dead",
      "time_ranges" : {
        "morning": 15,
        "before_midnight": 35,
        "midnight": 90
      }
    }
  ]
}
```

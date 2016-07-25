### Setup with docker

```
docker build -t graphite-noti .
docker run --rm -d -p 9393:9393 -v [YOUR_PATH/config.json]:/app/config.json softbaked/graphite-status
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
      "target": "jobs.message_1", // คือชื่อของ queue ที่อยู่ใน statsd ที่เราต้องการ m
      "check_type": "is_more_than", // เงื่อนไขในการเชคต้อง มากกว่าหรือน้อยกว่า ค่า threshold_value ถ้าถูกต้องตามเงื่อนไขจะหมายถึง ระบบมีปัญหา
      "threshold_value": 100, // ค่าที่ใช้ชี้
      "time_ranges" : {
        "morning": 5, // จะเอาข้อมูลมา 5 นาทีก่อนหน้าแล้วประมวลผล ว่าระบบี้มีปัญหาไหม
        "before_midnight": 15, // ในช่วงเวลา กลางดึก จะเอาข้อมูล 10 นาทีก่อนหน้าแล้วมาประมวลผล
        "midnight": 60 // ในช่วงเวลา กลางคืน - เช้า จะเอาข้อมูล 60 นาทีก่อนหน้ามาประมวลผล
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
      "check_type": "is_dead", // is_dead คือถ้าค่าเป็น 0 จะหมายถึง service ตาย
      "time_ranges" : {
        "morning": 15,
        "before_midnight": 35,
        "midnight": 90
      }
    }
  ]
}
```


#### Tips เมื่อนำ project ไปรันที่ใหม่
- ถ้าเอาไปรันที่ใหม่อย่าลืมดูเรื่อง Docker EXPOSE อะไรให้ได้ดีแล้วก็ Security Group ที่ AWS
- ตั้งค่า Endpoint ที่ PINGDOM ใหม่ด้วยนะ

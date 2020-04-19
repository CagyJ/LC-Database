select w1.Id from weather w1, weather w2
where w1.RecordDate - 1 = w2.RecordDate and w1.temperature > w2.temperature;
Part 1:

See Snapshots directory for snapshot configuration. Initially, I erroneously used the timestamp and then ran the changes, so I had to noodle around with the delivery-update.sql file to see the changes once I had reconfigured to the status column as a check.

Part 2:

|daydate|step|session_count|lag|drop_off|
|-----|-----|-----|-----|-----|
|2021-02-09 00:00:00|Step 1|2|||
|2021-02-09 00:00:00|Step 2|2|2|0.00|
|2021-02-09 00:00:00|Step 3|2|2|0.00|
|2021-02-10 00:00:00|Step 1|177|||
|2021-02-10 00:00:00|Step 2|177|177|0.00|
|2021-02-10 00:00:00|Step 3|177|177|0.00|
|2021-02-11 00:00:00|Step 1|442|||
|2021-02-11 00:00:00|Step 2|331|442|0.25|
|2021-02-11 00:00:00|Step 3|225|331|0.32|
|2021-02-12 00:00:00|Step 1|46|||
|2021-02-12 00:00:00|Step 2|46|46|0.00|
|2021-02-12 00:00:00|Step 3|46|46|0.00|


I grouped the counts and drop offs by day so that the funnel could be trended over time as a visualization and/or tracked as a KPI.

   see exposures.yml for second part

Part 3:

Answers in slack post.

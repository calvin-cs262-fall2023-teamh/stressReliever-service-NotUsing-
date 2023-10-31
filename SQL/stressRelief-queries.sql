SELECT * FROM users;

SELECT * FROM fidget_toys;

SELECT * FROM fidget_toys WHERE toy_type = 'Fidget Spinner';

SELECT registration_date FROM users WHERE username = 'john_doe';


-- Calculate the total time spent on each fidget toy by a specific user
SELECT
    toy_id,
    SUM(TIMESTAMPDIFF(SECOND, start_time, end_time)) AS total_time_seconds
FROM user_activity
WHERE user_id = 1
GROUP BY toy_id;


-- Retrieve the user's most recent activity on a fidget toy
SELECT * FROM user_activity
WHERE user_id = 2
ORDER BY start_time DESC
LIMIT 1;

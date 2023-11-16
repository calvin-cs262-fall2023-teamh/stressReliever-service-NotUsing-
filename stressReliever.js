const pgp = require('pg-promise')();

const db = pgp({
  host: process.env.DB_SERVER,
  port: process.env.DB_PORT,
  database: process.env.DB_USER,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// Configure the server and its routes.

const express = require('express');

const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

router.get('/', readHelloMessage);
router.get('/users', readUsers);
router.get('/fidget_toys', readFidgetToys);
router.get('/user_activity', readUserActivity);
router.get('/user_activity/:id', readUserActivityById);
router.post('/user_activity', createUserActivity);
router.put('/user_activity/:id', updateUserActivity);
router.delete('/user_activity/:id', deleteUserActivity);

app.use(router);
app.listen(port, () => console.log(`Listening on port ${port}`));

// Implement the CRUD operations.

function returnDataOr404(res, data) {
  if (data == null) {
    res.sendStatus(404);
  } else {
    res.send(data);
  }
}

function readHelloMessage(req, res) {
  res.send('Hello, CS 262 Monopoly service!');
}

function readUsers(req, res, next) {
  db.many('SELECT * FROM users')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readFidgetToys(req, res, next) {
  db.many('SELECT * FROM fidget_toys')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readUserActivity(req, res, next) {
  db.many('SELECT * FROM user_activity')
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function readUserActivityById(req, res, next) {
  db.oneOrNone('SELECT * FROM user_activity WHERE activity_id=${id}', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function createUserActivity(req, res, next) {
  db.one('INSERT INTO user_activity(user_id, toy_id, start_time, end_time) VALUES (${user_id}, ${toy_id}, ${start_time}, ${end_time}) RETURNING activity_id', req.body)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      next(err);
    });
}

function updateUserActivity(req, res, next) {
  db.oneOrNone('UPDATE user_activity SET user_id=${user_id}, toy_id=${toy_id}, start_time=${start_time}, end_time=${end_time} WHERE activity_id=${params.id} RETURNING activity_id', req)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

function deleteUserActivity(req, res, next) {
  db.oneOrNone('DELETE FROM user_activity WHERE activity_id=${id} RETURNING activity_id', req.params)
    .then((data) => {
      returnDataOr404(res, data);
    })
    .catch((err) => {
      next(err);
    });
}

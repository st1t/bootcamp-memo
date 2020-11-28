create table memos
(
    id SERIAL NOT NULL,
    memo_id  TEXT UNIQUE NOT NULL,
    subject  TEXT,
    contents TEXT
);
create table memos
(
    id SERIAL NOT NULL,
    memo_id  TEXT UNIQUE NOT NULL,
    title  TEXT,
    contents TEXT
);
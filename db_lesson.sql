Q1.
CREATE TABLE departments;
ERROR 1113 (42000): A table must have at least 1 column

CREATE TABLE `departments`(
-> `id` INT,
-> `name` VARCHAR(20)
-> );
SHOW TABLES;
DESCRIBE departments;

CREATE TABLE departments (
-> department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
-> name VARCHAR(20) NOT NULL,
-> created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
-> pdated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  );

ALTER TABLE departments
-> MODIFY created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
-> MODIFY updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

Q2.
ALTER TABLE people
-> ADD COLUMN department_id INT unsigned NULL AFTER email;
DESC people;

Q3.
INSERT INTO departments (name)
VALUES
('営業'),
('開発'),
('経理'),
('人事'),
('情報システム')
;
SELECT * FROM departments;

INSERT INTO people (name, email, age, gender, department_id)
VALUES
('佐藤 翔太', 'shota.sato@example.com', 28, 1, 1),
('鈴木 結衣', 'yui.suzuki@example.com', 40, 2, 1),
('高橋 蓮', 'ren.takahashi@example.com', 25, 1, 1),

('田中 美咲', 'misaki.tanaka@example.com', 30, 2, 2),
('伊藤 大輝', 'daiki.ito@example.com', 27, 1, 2),
('渡辺 心音', 'kokone.watanabe@example.com', 22, 2, 2),
('山本 智也', 'tomoya.yamamoto@example.com', 42, 1, 2),

('中村 花', 'hana.nakamura@example.com', 24, 2, 3),
('小林 陽翔', 'haruto.kobayashi@example.com', 31, 1, 4),
('加藤 優菜', 'yuna.kato@example.com', 29, 2, 5)
;

INSERT INTO reports (person_id, content)
VALUES
(1, '本日の営業会議で新規顧客対応について議論しました。'),
(2, 'A社を訪問し、製品デモを実施しました。フィードバックは良好でした。'),
(3, '営業チーム全体で今月の目標を達成しました。来月も頑張ります。'),

(4, '新機能の設計について、チームでディスカッションしました。'),
(5, '同僚のプルリクエストを確認し、修正提案を出しました。'),
(6, 'ログイン画面の不具合を修正し、本番環境に反映しました。'),
(7, 'Reactの最新動向について社内勉強会を開催しました。'),

(8, '経理部で月次決算の資料をまとめました。特に大きな問題なし。'),
(9, '新人向けの社内研修を担当しました。参加者の理解度は高め。'),
(10, 'サーバー障害が発生し、対応および原因調査を行いました。')
;

Q4.
-- 例1: 年齢が30歳以上の人は部署1
UPDATE people
SET department_id = 1
WHERE department_id IS NULL AND age >= 30;

-- 例2: 年齢が25歳以上かつ30歳未満の人は部署2
UPDATE people
SET department_id = 2
WHERE department_id IS NULL AND age >= 25 AND age < 30;

-- 例3: 年齢が25歳未満の人は部署3
UPDATE people
SET department_id = 3
WHERE department_id IS NULL AND age < 25;

-- 例4: 年齢がNULLの人は部署4（例: 不思議沢みちこ）
UPDATE people
SET department_id = 4
WHERE department_id IS NULL AND age IS NULL;

SELECT * FROM people WHERE department_id IS NULL;

Q5.
SELECT name, age
FROM people
WHERE gender = 1
ORDER BY age DESC;

Q6.
SELECT
  `name`, `email`, `age`
FROM
  `people`
WHERE
  `department_id` = 1
ORDER BY
  `created_at`;
  
「people」という名前の表（テーブル）から、
部署ID（department_id）が「1」の人たちを探して、
名前（name）、メールアドレス（email）、年齢（age）を取得する。

Q7.
SELECT name, age
FROM people
WHERE (gender = 2 AND age BETWEEN 20 AND 29)
   OR (gender = 1 AND age BETWEEN 40 AND 49);

Q8.
SELECT name, age
FROM people
WHERE department_id = 1
ORDER BY age;

Q9.
SELECT AVG(age) AS average_age
FROM people
WHERE gender = 2 AND department_id = 2;

10.
SELECT
    p.name AS 名前,
    d.name AS 部署名,
    r.content AS 日報内容
FROM
    people p
JOIN
    departments d ON p.department_id = d.department_id
JOIN
    reports r ON p.person_id = r.person_id;

+----------------+--------+-------------------------------------------------------------------+
| 名前           | 部署名 | 日報内容                                                          |
+----------------+--------+-------------------------------------------------------------------+
| 福田だいすけ   | 営業   | 日報3                                                             |
| 豊島はなこ     | 営業   | 日報4                                                             |
| 佐藤 翔太      | 営業   | 日報5                                                             |
| 福田だいすけ   | 営業   | 日報8                                                             |
| 豊島はなこ     | 営業   | 日報9                                                             |
| 福田だいすけ   | 営業   | 営業チーム全体で今月の目標を達成しました。来月も頑張ります。      |
| 豊島はなこ     | 営業   | 新機能の設計について、チームでディスカッションしました。          |
| 佐藤 翔太      | 営業   | Reactの最新動向について社内勉強会を開催しました。                 |
| 鈴木 結衣      | 営業   | 経理部で月次決算の資料をまとめました。特に大きな問題なし。        |
| 高橋 蓮        | 営業   | 新人向けの社内研修を担当しました。参加者の理解度は高め。          |
| 田中ゆうこ     | 開発   | 日報2                                                             |
| 田中ゆうこ     | 開発   | 日報7                                                             |
| 田中ゆうこ     | 開発   | A社を訪問し、製品デモを実施しました。フィードバックは良好でした。 |
| 田中 美咲      | 開発   | サーバー障害が発生し、対応および原因調査を行いました。            |
| 鈴木たかし     | 経理   | 日報1                                                             |
| 鈴木たかし     | 経理   | 日報6                                                             |
| 鈴木たかし     | 経理   | 日報10                                                            |
| 鈴木たかし     | 経理   | 本日の営業会議で新規顧客対応について議論しました。                |
| 不思議沢みちこ | 人事   | ログイン画面の不具合を修正し、本番環境に反映しました。            |
+----------------+--------+-------------------------------------------------------------------+

Q.11
SELECT
    people.name AS 名前,
    departments.name AS 部署名,
    reports.content AS 日報内容
FROM
    people
JOIN
    departments ON people.department_id = departments.department_id
JOIN
    reports ON people.person_id = reports.person_id;

+----------------+--------+-------------------------------------------------------------------+
| 名前           | 部署名 | 日報内容                                                          |
+----------------+--------+-------------------------------------------------------------------+
| 福田だいすけ   | 営業   | 日報3                                                             |
| 豊島はなこ     | 営業   | 日報4                                                             |
| 佐藤 翔太      | 営業   | 日報5                                                             |
| 福田だいすけ   | 営業   | 日報8                                                             |
| 豊島はなこ     | 営業   | 日報9                                                             |
| 福田だいすけ   | 営業   | 営業チーム全体で今月の目標を達成しました。来月も頑張ります。      |
| 豊島はなこ     | 営業   | 新機能の設計について、チームでディスカッションしました。          |
| 佐藤 翔太      | 営業   | Reactの最新動向について社内勉強会を開催しました。                 |
| 鈴木 結衣      | 営業   | 経理部で月次決算の資料をまとめました。特に大きな問題なし。        |
| 高橋 蓮        | 営業   | 新人向けの社内研修を担当しました。参加者の理解度は高め。          |
| 田中ゆうこ     | 開発   | 日報2                                                             |
| 田中ゆうこ     | 開発   | 日報7                                                             |
| 田中ゆうこ     | 開発   | A社を訪問し、製品デモを実施しました。フィードバックは良好でした。 |
| 田中 美咲      | 開発   | サーバー障害が発生し、対応および原因調査を行いました。            |
| 鈴木たかし     | 経理   | 日報1                                                             |
| 鈴木たかし     | 経理   | 日報6                                                             |
| 鈴木たかし     | 経理   | 日報10                                                            |
| 鈴木たかし     | 経理   | 本日の営業会議で新規顧客対応について議論しました。                |
| 不思議沢みちこ | 人事   | 同僚のプルリクエストを確認し、修正提案を出しました。              |
| 不思議沢みちこ | 人事   | ログイン画面の不具合を修正し、本番環境に反映しました。            |
+----------------+--------+-------------------------------------------------------------------+

Q11．
SELECT
    people.name AS 名前
FROM
    people
LEFT JOIN
    reports ON people.person_id = reports.person_id
WHERE
    reports.report_id IS NULL;

+-----------+
| 名前      |
+-----------+
| 伊藤 大輝 |
| 渡辺 心音 |
| 山本 智也 |
| 中村 花   |
| 小林 陽翔 |
| 加藤 優菜 |
+-----------+



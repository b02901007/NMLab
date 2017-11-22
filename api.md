# Semester list
Get the semester list.

### Method:
	GET /course/f03067/app/v3/ceiba_api.php

### Request parameters:
Parameter name   | Value           | Description
------- | --------------|-------
mode    | 'semester'    | 

### Request body:
None

### Response:
Format: Json


# Course data
Get the course data, including course info, teacher info, course contents, bulletins, homeworks, language, student list, and permissions.

### Method:
<code>GET /course/f03067/app/v3/ceiba_api.php</code>

### Request parameters:
Parameter name   | Value           | Description
------- | --------------|-------
mode    | 'semester'    | 
semester | String    | semester of the course (e.g. 105-1)
course_sn    | String | Course serial number (e.g. f03067)

### Request body:
None

### Response:
Format: Json

Parameter name   | Value           | Description
------- | --------------|-------
board | String | ...
teacher_info | Array of Json | see more detail on [teacher_info](#teacher_info)
homeworks | Array of Json | see more detail on [homeworks](#homeworks)
course_info | Json | see more detail on [course_info](#course_info)
lang | String | language of this course (big5 or eng)

#### <a name="teacher_info"/> teacher_info

 Parameter name   | Value           | Description
------- | --------------|-------
account | String | teacher's account
phone | String  | teacher's phone
tr_msid | String  | 是否合授
address | String | teacher's office address
cname | String | teacher's Chinese name
email | String | teacher's email
ename | String | teacher's English name

#### <a name="homeworks"/> homeworks

 Parameter name   | Value           | Description
------- | --------------|-------
hw_scores | Array | ...
pub_date | String | HW published date
file_path | String | HW file path 
end_hour | String | HW deadline time (hour)
is_subm | Bool | is HW submission
sn | String | HW serial number
pub_hour | String | HW published time (hour)
description | String | HW description
end_date | String | HW deadline date
name | String | HW name
url | String | HW url

#### <a name="course_info"/> course_info

 Parameter name   | Value           | Description
------- | --------------|-------
place | String | 上課地點
dpt_cou | String | 課程號
mark | String | ...
day1 | String | 禮拜一第幾節課，如果禮拜一沒有課則沒有此參數(e.g. 67表示禮拜一第六第七節上課)
day2 | String | 禮拜二第幾節課，如果禮拜二沒有課則沒有此參數
day3 | String | 禮拜三第幾節課，如果禮拜三沒有課則沒有此參數
day4 | String | 禮拜四第幾節課，如果禮拜四沒有課則沒有此參數
day5 | String | 禮拜五第幾節課，如果禮拜五沒有課則沒有此參數
day6 | String | 禮拜六第幾節課，如果禮拜六沒有課則沒有此參數
day7 | String | 禮拜日第幾節課，如果禮拜日沒有課則沒有此參數
course_req | String | ...

SET check_function_bodies = false;
INSERT INTO "stories" ("title", "hashid", "user_id", "status", "preview_image", "preview_content", "contents", "published_at", "created_at", "updated_at") VALUES
	('React Query Series - Bài 2 - Một số khái niệm cơ bản trong React Query', 'yZjJYzv0LOE', '1', 'unlisted', 'https://images.viblo.asia/733891bd-c101-45df-b751-574099070322.png', 'Một số khái niệm cơ bản trong React Query

Chào các bạn đã trở lại bài 2 của mình về React Query. Ở bài này mình sẽ nói sơ qua về một số khái niệm cơ bản có trong React Query. Mình tin sau khi đọc hết bài viết này, các bạn sẽ hiểu rõ hơn về các khái niệm cơ bản về React Query và cách sử dụng nó để quản lý dữ liệu trong React.

React Query là một thư viện tập hợp cho việc quản lý trạng thái và d...', '# Một số khái niệm cơ bản trong React Query

Chào các bạn đã trở lại bài 2 của mình về React Query. Ở bài này mình sẽ nói sơ qua về một số khái niệm cơ bản có trong React Query. Mình tin sau khi đọc hết bài viết này, các bạn sẽ hiểu rõ hơn về các khái niệm cơ bản về React Query và cách sử dụng nó để quản lý dữ liệu trong React.

![image.png](https://images.viblo.asia/733891bd-c101-45df-b751-574099070322.png)

**React Query** là một thư viện tập hợp cho việc quản lý trạng thái và dữ liệu trong React. Nó cung cấp các tính năng và API để giúp cho việc lấy dữ liệu từ API, lưu trữ dữ liệu và quản lý trạng thái giữa các component.

* **State Management:** React Query cung cấp một cách quản lý trạng thái cho dữ liệu trong app, bao gồm cả việc quản lý trạng thái loading, error, và kết quả trả về.
* **Query:** Là một đối tượng chứa các thông tin liên quan đến việc lấy dữ liệu và trạng thái hiện tại của việc lấy dữ liệu.
* **Query Cache:** Là một kho dữ liệu để lưu trữ các Query. Nó cung cấp các tính năng để truy cập và quản lý các Query.
* **Query Hooks:** Là các hook cung cấp cho việc sử dụng Query trong React component. Các hook này giúp cho việc lấy dữ liệu, cập nhật trạng thái và quản lý lỗi.
* **Query Key:** Query Key là một chuỗi dùng để định danh mỗi yêu cầu dữ liệu. Nó giúp React Query tìm và quản lý các yêu cầu trong Query Cache.
* **Refetching:** Là việc tái lấy dữ liệu một cách tự động hoặc bằng cách gọi một function.
* **Suspense:** Là một tính năng của React Query cho phép việc hiển thị nội dung trong khi đang chờ đợi dữ liệu.
* **Revalidation:**  Revalidation là việc kiểm tra xem dữ liệu trong Query Cache còn hợp lệ hay không. Nếu dữ liệu không hợp lệ, React Query sẽ gửi yêu cầu dữ liệu mới.

### Ví Dụ

**Ví dụ 1**

 Chúng ta có một ứng dụng cần tải danh sách sản phẩm từ API. Chúng ta có thể sử dụng React Query để tải dữ liệu và quản lý cache của dữ liệu đó.

```
 import { useQuery } from ''react-query'';

function ProductList() {
  const { data, status } = useQuery(''products'', async () => {
    const response = await fetch(''https://api.example.com/products'');
    return response.json();
  });

  if (status === ''loading'') {
    return <div>Loading...</div>;
  }

  if (status === ''error'') {
    return <div>Error: {error.message}</div>;
  }

  return (
    <ul>
      {data.map((product) => (
        <li key={product.id}>{product.name}</li>
      ))}
    </ul>
  );
}
```


Trong ví dụ trên, chúng ta sử dụng hook useQuery để tải dữ liệu sản phẩm từ API. Nếu dữ liệu đã được cache, nó sẽ được trả về từ cache mà không cần tải lại. Nếu chưa, nó sẽ tải dữ liệu mới và cache dữ liệu đó.

**Ví dụ 2**

Bạn có một mảng chứa các đối tượng của nhân viên với thông tin về tên, trình độ và lương. Bạn muốn tìm tất cả những nhân viên có trình độ "senior". Bạn có thể sử dụng React Query để thực hiện việc này.


```
import { useQuery } from ''react-query'';

function getSeniorEmployees() {
  return fetch(''/api/employees'')
    .then(res => res.json())
    .then(data => data.filter(employee => employee.level === ''senior''));
}

function EmployeesList() {
  const { isLoading, error, data } = useQuery(''seniorEmployees'', getSeniorEmployees);

  if (isLoading) return ''Loading...'';
  if (error) return ''An error has occurred'';

  return (
    <ul>
      {data.map(employee => (
        <li key={employee.name}>{employee.name}</li>
      ))}
    </ul>
  );
}
```

Trong ví dụ trên, chúng ta sử dụng hàm useQuery để thực hiện truy vấn cho dữ liệu nhân viên có trình độ "senior". Chúng ta sử dụng hàm getSeniorEmployees để truy xuất dữ liệu từ API và lọc các nhân viên có trình độ "senior".

# Kết Bài

Ở bài này mình đã nói sơ qua những khái niệm cơ bản của React Query. Ở bài tới mình sẽ bắt đầu setup một project nhỏ và hướng dẫn từng hàm để giúp các bạn nắm rõ hơn về React Query. Cảm ơn đã quan tâm về Series React Query.', '2023-02-12T19:44:11.000000Z', '2023-02-27T15:28:03.000000Z', '2023-02-12T20:44:34.000000Z'),
	('Xây dựng Multi Container Spring Boot Apps với Docker Compose', '38X4E5X14N2', '2', 'unlisted', 'https://images.viblo.asia/33c0be67-ade2-4f85-9a96-e7cc25be2cbd.png', 'Khi các bạn đọc bài viết Deploy Spring Boot Application Development Docker Window 10 chắc nhiều bạn sẽ đặt câu hỏi: Nếu muốn kết nối với database thì sẽ như thế nào? Nhiều kết nối nữa thì giải quyết ra sao?... Bài viết này, mình sẽ hướng dẫn giải quyết các thắc mắc đó nhé.

1. Chuẩn bị project
Download source code
Hiển thị các thư mục project, dùng câu lệnh command "tree"

Xem qua thư mục .dock...', 'Khi các bạn đọc bài viết [Deploy Spring Boot Application Development Docker Window 10](https://viblo.asia/p/deploy-spring-boot-application-development-docker-window-10-3RlL5Aa6LbB) chắc nhiều bạn sẽ đặt câu hỏi: Nếu muốn kết nối với database thì sẽ như thế nào? Nhiều kết nối nữa thì giải quyết ra sao?... Bài viết này, mình sẽ hướng dẫn giải quyết các thắc mắc đó nhé.

### 1. Chuẩn bị project
Download [source code](https://gitlab.com/springbootdevops/spring-postgres.git)
Hiển thị các thư mục project, dùng câu lệnh command "**tree**"
![image.png](https://images.viblo.asia/7a34dabf-dd38-4444-a7d9-1e5aaf2577a6.png)

Xem qua thư mục **.docker -> docker-compose.yaml**
```
services:
  backend:
    build:
      context: backend
      target: dev-envs
    ports:
      - 8080:8080
    environment:
      - POSTGRES_DB=example
    networks:
      - spring-postgres
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
  db:
    image: postgres
    restart: always
    secrets:
      - db-password
    volumes:
      - db-data:/var/lib/postgresql/data
    networks:
      - spring-postgres
    environment:
      - POSTGRES_DB=example
      - POSTGRES_PASSWORD_FILE=/run/secrets/db-password
    expose:
      - 5432
volumes:
  db-data:
secrets:
  db-password:
    file: db/password.txt
networks:
  spring-postgres:
```
 Trong compose file có 2 service: db và backend. Sử dụng port 8080, tránh sử dụng port với các ứng dụng khác, miễn làm sao chưa ứng dụng nào dùng port 8080. Ngoài ra, định nghĩa các biến môi trường, connect backend service  với postgres database, đặt username  và  password database
### 2. Chạy  docker compose
Chạy câu lệnh docker compost command: **docker compose up -d**

![image.png](https://images.viblo.asia/33c0be67-ade2-4f85-9a96-e7cc25be2cbd.png)

Tiếp theo, vào docker desktop -> Images, hiển thị tên Spring-postgres-backend và postgress
![image.png](https://images.viblo.asia/a1fa641f-e252-42be-91a3-c6a4d2fdc003.png)

Aplication run start, kiểm tra [http://localhost:8080/](http://localhost:8080/) hiển thị thông tin "Hello from Docker!"
![image.png](https://images.viblo.asia/51ca3bb0-41a5-48f3-8228-6658af551c74.png)

Như vây, chúng ta đã xây dựng được nhiều ứng dụng chạy trên Docker Compose (backend service, postgres database ) trên 1 cổng.
### 3.  Dừng và xóa Containers
Khi có quá nhiều Containers chạy cùng 1 lúc, sẽ ảnh hưởng đến CPU, Memory, Disk, Network I/O. Do đó chúng ta nên quản lý Containers phù hợp nhất, lựa chọn các Containers hoạt động để tiết kiệm nguồn tài nguyên. Câu lệnh **docker compose down**
![image.png](https://images.viblo.asia/ee41d129-d045-49c6-8dbd-d3181c78416a.png)

Ngoài ra, chúng ta có thể action trên giao diện Docker Desktop, lựa chọn Containers -> Action phù hợp nhất thôi
![image.png](https://images.viblo.asia/5136d6f8-f532-4340-adae-48c898e23ed8.png)

### 4. Tổng kết
Bài viết này, có thể giúp các bạn xây dựng hệ thống có nhiều Container như backend service, database lên Docker Compose. Còn khó khăn gì nữa, bắt tay làm việc thôi nhỉ. Các thím có thắc mắc hãy comment bình luận bên dưới nhá.', '2023-02-12T18:34:22.000000Z', '2023-02-28T00:40:04.000000Z', '2023-02-12T18:34:19.000000Z'),
	('Deploy Spring Boot Application Development Docker Window 10', '3RlL5Aa6LbB', '3', 'unlisted', 'https://images.viblo.asia/46110dee-8438-4d27-a48e-2a1daee8cf5e.png', 'Đây có lẽ là một chủ đề không còn xa lạ gì với những bạn dev có kinh nghiệm chinh chiến lão làng lâu năm rồi "Đúng nhận sai cãi". Tuy nhiên, với những bạn Intern và Fresher thì nó lại là chủ đề rất cần thiết. Mình có tìm kiếm và đọc các bài viết chủ yếu các bài viết sử dụng Docker trên hệ điều hành Ubuntu/Centos chưa có nhiều các bài viết hướng dẫn chi tiết trên Window. Chính vì vậy, với bài vi...', 'Đây có lẽ là một chủ đề không còn xa lạ gì với những bạn dev có kinh nghiệm chinh chiến lão làng lâu năm rồi "Đúng nhận sai cãi". Tuy nhiên, với những bạn Intern và Fresher thì nó lại là chủ đề rất cần thiết. Mình có tìm kiếm và đọc các bài viết chủ yếu các bài viết sử dụng Docker trên hệ điều hành Ubuntu/Centos chưa có nhiều các bài viết hướng dẫn chi tiết trên Window. Chính vì vậy, với bài viết này, mình sẽ hướng dẫn một cách chi tiết và cụ thể nhất dành cho các dev thường xuyên dùng Window. Bài viết này, tập trung vào phần thực hành, lý thuyết các bạn tự tìm hiểu nhá.
### 1. Tóm tắt nội dung
*  Hướng dẫn tạo project Spring Boot
*  Hướng dẫn cài Docker Desktop
*  Hướng dẫn triển khai trên Docker
### 2. Hướng dẫn tạo project Spring Boot
Đầu tiên, chúng ta cần chuẩn bị môi trường: intellij, maven, jdk. (Intellij IDEA 2020.2.1, Maven 3.8.1, jdk 17).
Tiếp theo, có nhiều cách để tạo project Spring Boot như: [Spring Initializr](https://start.spring.io/) hoặc tạo Project trong Intellij IDEA. Có một cách cho các bạn lười như tôi là download [source code](https://gitlab.com/springbootdevops/springbootdocker.git)
Sau khi tạo được project, kiểm tra Project Structure (trỏ vào thư mục source code, dùng command **tree**)
![image.png](https://images.viblo.asia/a6d63976-b0d6-484c-b679-60f3155b4b2b.png)

Trong đó, file SpringBootDockerApplication.java tạo ra một API đơn giản hiển thị “Hello World!”
```
package com.example.springbootdocker;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class SpringBootDockerApplication {

    @RequestMapping("/")
    public String home() {
        return "Hello World!";
    }

    public static void main(String[] args) {
        SpringApplication.run(SpringBootDockerApplication.class, args);
    }
}

```

Dùng câu lệnh để đóng gói ra file JAR command **./mvnw package**
![image.png](https://images.viblo.asia/46110dee-8438-4d27-a48e-2a1daee8cf5e.png)

Hoặc dùng tool **Intellij IDEA -> Maven -> Lifecycle -> clearn -> install**
![image.png](https://images.viblo.asia/956d9a0c-3e71-4f80-9b81-2dac8fb9d285.png)

Sau khi build thành công file JAR, chỉ cần chạy file JAR **java -jar target/spring-boot-docker-0.0.1-SNAPSHOT.jar**. Trong đó: ***spring-boot-docker-0.0.1-SNAPSHOT.jar*** là tên file JAR build xong, target là thư mục chứa file JAR
![image.png](https://images.viblo.asia/0e2015d1-f041-40d9-a24b-f99c466fa02f.png)

### 3. Hướng dẫn cài Docker Desktop
Download [Docker Desktop](https://www.docker.com/get-started/)  lựa chọn đúng phiên bản cho hệ điều hành Windown
Để cài Docker Desktop, những thao tác rất đơn giản chỉ có "next" và "next". Không còn nhấn "next" được nữa, màn hình sẽ hiển thị Docker Destop
![image.png](https://images.viblo.asia/cab1d3c4-d1af-4b6f-8763-c83aeb6a844c.png)

Nếu mà vẫn loay hoay không biết cài như thế nào, bạn có thể tham khảo [bài viết](https://viblo.asia/p/cai-dat-docker-tren-windows-10-3Q75w6gelWb) này nhé!
### 4. Hướng dẫn triển khai trên Docker
Thực hiện các bước trên không có khó khăn gì với các thím chứ? Nếu không có vấn đề gì, chúng ta đi tiếp vào phần quan trọng nhất của bài viết này thôi nào các bạn ơiiiii
Source code project Spring Boot, trong đó có file Dockerfile
```
FROM eclipse-temurin:17-jdk-focal
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY src ./src
CMD ["./mvnw", "spring-boot:run"]
```
Trong đó,
* FROM eclipse-temurin:17-jdk-focal : dùng thư viện jdk 17,  Eclipse Temurin cung cấp code và quy trình hỗ trợ xây dựng các tệp nhị phân time runing.
* WORKDIR /app:  tạo một thư mục để chứa code ứng dụng của hình ảnh project.
* COPY .mvn/ ./mvn: Copy thư viện Maven từ máy local đến container image .
* COPY mvnw pom.xml ./  Copy file pom từ máy local đến container image.
* RUN ./mvnw dependency:go-offline  RUN kích hoạt tất cả project.
* COPY src ./src Copy thư mục src từ local lên môi trường docker
* CMD ["./mvnw", "spring-boot:run"] Chạy câu lệnh Docker biên dịch và chạy app package

Tiếp theo, cần build lên Docker Image. Câu lệnh **docker build -f Dockerfile -t spring-boot .**
![image.png](https://images.viblo.asia/a699d1e2-be12-476e-a4f4-87377fc94941.png)

Sau khi build lên Docker Image xong, kiểm tra trên Docker Desktop -> Images -> hiển thị Name "spring-boot" đúng như tên đã đặt
![image.png](https://images.viblo.asia/53ca6382-9673-4ce5-9102-c57140afc15e.png)

Ngoài ra, các thím có thể đẩy trực tiếp hình ảnh của mình lên Docker Hub để dễ dàng chia sẻ. Action -> Push to Hub
![image.png](https://images.viblo.asia/fef8fd43-b6b6-4a99-a03c-83ada7a5a2d1.png)

Đặt tên Container Name -> Nhấn button "Run". Hiển thị thông tin **Containers**
![image.png](https://images.viblo.asia/e85e50c4-0a33-4bee-9610-44ee29de0de7.png)

Các thím xem **Logs** chạy nhé
![image.png](https://images.viblo.asia/25065864-47c9-42c3-9c96-8f4a3b1e9ef6.png)

Docker Dashboard’s tab Stats, dễ dàng kiểm tra các thông tin CPU, Memory, Disk Read/Wirte, Network I/O
![image.png](https://images.viblo.asia/1bd3bd29-0450-4dba-8f7e-eb379798ab1f.png)

### 5. Tổng kết
Chúng ta đã học được cách triển khai dựng project spring boot đơn giản deploy với docker  trên hệ điều hành Window 10 một cách đơn giản, các nội dung chia sẻ chỉ liên quan đến hình ảnh rất trực quan và rõ ràng. Các thím có thắc mắc hãy comment bình luận bên dưới nhá.
[Bài tiếp theo](https://viblo.asia/p/xay-dung-multi-container-spring-boot-apps-voi-docker-compose-38X4E5X14N2), sẽ là một chủ đề nối chuỗi bài viết Spring Boot deploy Docker. Mời các bạn ghé thăm.', '2023-02-12T17:23:56.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-12T18:39:44.000000Z'),
	('Write up level 1 - PTITCTF [pwn]', 'MG24Bwn5Jz3', '4', 'unlisted', 'https://images.viblo.asia/b60fdd0f-1a48-4a12-89bd-462b24ffcbbf.png', 'Write-up PTIT CTF 2023
Level 1
<br>
Việc đầu tiên là mình sẽ check xem file của nó thuộc loại nào.<br>
<br>
Mình sẽ dùng ida64 để đọc pseudo code của bài từ file 64bit này.<br>
.<br>
Nhìn qua thấy key word của bài là ở dòng 21 xor[i] = source[i] ^ someThing[i]; ,
check source thấy được data của nó db ''>R!+Q.VEHr'',0 .<br>
Và để vào được hàm system("cat flag") ta cần xor với IamHaCer!! để có được...', '# Write-up PTIT CTF 2023
## Level 1
![image.png](https://images.viblo.asia/b60fdd0f-1a48-4a12-89bd-462b24ffcbbf.png)<br>
Việc đầu tiên là mình sẽ check xem file của nó thuộc loại nào.<br>
![image.png](https://images.viblo.asia/a28e323f-379f-4533-9acd-6a92864e4e5e.png)<br>
Mình sẽ dùng ida64 để đọc pseudo code của bài từ file 64bit này.<br>
![image.png](https://images.viblo.asia/3742f703-80f9-4359-91d4-eed4a0a5f669.png).<br>
Nhìn qua thấy key word của bài là ở dòng 21 `xor[i] = source[i] ^ someThing[i];` ,
check source thấy được data của nó *`db ''>R!+Q.VEHr'',0`* .<br>
Và để vào được hàm `system("cat flag")` ta cần xor với *`IamHaCer!!`* để có được biến `someThing` đúng..<br>
![image.png](https://images.viblo.asia/9d317d29-1bfd-4fa2-847d-5477351de706.png).<br>
![image.png](https://images.viblo.asia/2dbec3de-bc56-4300-a48e-c74365b52982.png).<br>
Và đây là những thứ chúng ta cần hoàn thiện nốt: .<br>
![image.png](https://images.viblo.asia/3c416977-4761-47db-9c7a-8c30ea7feede.png).<br>
và cuối cùng thì nó có flag là như này: ``PISCTF{My_M1nd_50_3z_RI9ht_?}``<br>
## Level 2
![image.png](https://images.viblo.asia/22c76c26-0f32-4eab-b0dc-23b077de168a.png)<br>
Việc đầu tiên là mình sẽ check xem file của nó thuộc loại nào. bủh<br>
![image.png](https://images.viblo.asia/c604ee8b-a161-4e1a-b792-4b4455c2c2f5.png)<br>
Bủh, ta thấy ngay lỗi format string ở hàm *`printf(v4)`* do nó không format đầu ra cho v4 nên có thể nghĩ ngay đến lỗi này. <br>
Mọi công đoạn thì bài này có vẻ lặp lại ở bài 1. Mình cũng hơi lú vì spam `%x` và `%p` hơi nhiều mà méo ra gì cuối cùng thì nó là `%s` <br>
Mình sẽ rút kinh nghiệm ở những lần làm bài sau 🥲<br>
Chi tiết hơn thì `%x` sẽ leak cho bạn đầu ra là hex còn `%p` sẽ leak cho bạn địa chỉ <br>
![image.png](https://images.viblo.asia/3bc0de10-f2a2-4820-b2e3-02f33d498624.png) <br>
Và kết quả cuối cùng thì nó là như này <br>
``ISCTF{W3ll_w311_Y0u_4re_4_BAD_b0y_0r_g1rL_<:}``<br>
# Giải thích về lỗi Format strings
Lỗi này khá là nguy hiểm tương đương với Buffer OverFlow.  Khi một chương trình có lỗi này, hacker có thể leak dữ liệu. <br>
Format string là string dùng để format trong các hàm: `printf, fprintf, ...`<br>
`Vd`: printf("a1", a3) thì a1 là format string <br>
Một số kiểu format đáng chú ý:
* %s: In ra xâu được trỏ bởi tham số.
* %x: In ra tham số ở dạng hex.
* %p: In ra tham số ở dạng con trỏ.
## Lỗ hổng format string
Hãy xem qua ví dụ dưới đây.<br>
Bình thường ta hay dùng hàm printf như sau:<br>
```c
printf("Hello %s", name);
```
Nhưng nếu dùng như dưới đây:<br>
```c
#include<stdio.h>
#include<string.h>

int main(){
    char input[64];
    gets(input);
    printf(input);
    return 0;
}
```
Compiler nó:
```c
gcc fmtString.c -o fmtString
```
Ta sẽ thử nó với option`%s` đầu tiên: <br>
![image.png](https://images.viblo.asia/4e8d7847-3c0a-4b11-86e3-b5d2ecab0af0.png)<br>
Lập tức nó gặp lỗi `Segmentation fault`<br>
Tiếp theo thử với option `%x`:<br>
![image.png](https://images.viblo.asia/1fb696ea-e022-4d5f-a47f-a0d94db82122.png)<br>
![image.png](https://images.viblo.asia/32186ec6-ec4b-4a8a-9184-a93237412f35.png)<br>
Cuối cùng thì thử với option `%p`:<br>
![image.png](https://images.viblo.asia/67cd99c0-e251-4826-90c9-1766c821d3ff.png)<br>
![image.png](https://images.viblo.asia/17a3286b-687b-475e-975b-a00ea7388b51.png)<br>
Thường thì %p sẽ leak cho hacker các địa chỉ trên stack<br>
Đó chính là lỗi format string. <br>

Hai bài này khá là basic để tìm hiểu về các vuln cơ bản, có thể làm bài warmup tốt :>>.<br>
Khởi đầu 1 năm mới tiếp theo. Chúc toàn thể mem viblo đạt được nhiều thành công và gặt hái được nhiều thành tựu trong năm 2023. Đây cũng là bài viết đánh dấu sự khởi đầu của mình. Cảm ơn mọi người đã đọc!!.<br>
``Mãi yêu 🫶🧨``<br>
*``wu by 0nly^y0u``*<br>', '2023-02-12T16:07:52.000000Z', '2023-02-27T10:43:06.000000Z', '2023-02-13T04:51:51.000000Z'),
	('ARC và Kỹ thuật quản lý vùng nhớ trong Swift', 'EoW4ogY74ml', '5', 'unlisted', 'https://images.viblo.asia/c125a567-3fb3-4d27-bba4-7b47b32ea424.png', 'Mừng xuân Quý Mão 2023!
Đầu năm mới, chúc toàn thể anh chị em Viblo một năm tràn đầy năng lượng,tràn đầy niềm vui và hạnh phúc: Vui trong sức khoẻ, trẻ trong tâm hồn, khôn trong lý tưởng và trưởng thành mọi lĩnh vực.

Việc quản lí bộ nhớ trong mỗi ứng dụng là rất quan trọng. Nếu ứng dụng của bạn sử dụng dữ liệu bừa bãi 1 cách không cần thiết thì sẽ làm memory của ứng dụng tăng cao, và trong trư...', '> **Mừng xuân Quý Mão 2023!**
>
> Đầu năm mới, chúc toàn thể anh chị em Viblo một năm tràn đầy năng lượng,tràn đầy niềm vui và hạnh phúc: Vui trong sức khoẻ, trẻ trong tâm hồn, khôn trong lý tưởng và trưởng thành mọi lĩnh vực.




Việc quản lí bộ nhớ trong mỗi ứng dụng là rất quan trọng. Nếu ứng dụng của bạn sử dụng dữ liệu bừa bãi 1 cách không cần thiết thì sẽ làm memory của ứng dụng tăng cao, và trong trường hợp xấu có thể dẫn đến crash.
Swift sử dụng ARC để hỗ trợ developer quản lí ứng dụng của app. Ở bài viết này mình sẽ nói về ARC trong swift.

## **1. ARC là gì**
##

* ARC là viết tắt của Automatic Reference Counting. Swift sử dụng ARC để giúp bạn việc quản lý bộ nhớ của app.
* ARC sẽ tự động giải phóng bộ nhớ được sử dụng bởi 1 biến khi biến đó không còn được sử dung nữa.
* Tuy nhiên, để ARC có thể biết được khi nào biến đó không còn dc sử dụng, thì ARC phải biết về các relations giữa biến đó vs các biến khác trong code của bạn.


## **2. Cách ARC hoạt động**
* Mỗi khi bạn tạo 1 biến, ARC sẽ tự chia sẻ 1 phần bộ nhớ để lưu trữ biến đó. Khi biến đó không còn được sử dụng, ARC giải phóng biến, lấy lại bộ nhớ để dùng cho những mục đích khác
* Để xác định 1 biến không còn được sử dụng, ARC sẽ đếm số lượng strong reference hiện tại của biến đó đối với các biến khác. Chỉ khi số lượng strong reference = 0 thì biến đó mới được giải phóng bộ nhớ.

*Vậy strong reference là gì?*

## **3. Strong reference**

   *Mỗi khi bạn gán 1 biến kiểu class cho 1 property, constant hoặc variable, thì những thứ đó tạo 1 strong reference đến biến đó.*
```
class Car {
    var price: Int
    init(price: Int) {
        self.price = price
    }

    deinit {
        print("Car is being deinitialized")
    }
}

var hondaCar: Car? = Car(price: 10000)
```
Ở đây, bạn gán biến *Car(price: 10000)* cho varialbe *hondaCar*

-> **hondaCar đã tạo 1 strong reference đến Car(price: 10000)**
![](https://images.viblo.asia/59e0a88a-e850-4cfb-a295-3b2dde85ec81.png)
Thêm dòng code sau và run thử trên playground:

```
hondaCar = nil
```
Kết quả thu được ở màn hình console như sau:

```
Car is being deinitialized
```
Nếu bạn set *honedaCar = nil* -> Khi đó *Car(price:10000)* sẽ không còn strong reference nào trỏ đến -> ARC sẽ giải phóng bộ nhớ cho Car.
Tiếp tục thử chạy đoạn code sau và quan sát màn hình console:
```
class Car {
    var price: Int
    init(price: Int) {
        self.price = price
    }

    deinit {
        print(" Car is being deinitialzed")
    }
}

var car1: Car? = Car(price: 10000)
var car2 = car1
var car3 = car1

car1 = nil
car2 = nil


```
Trong ví dụ trên, sẽ tạo ra 1 sơ đồ relation giữa các instance như sau:
![](https://images.viblo.asia/c125a567-3fb3-4d27-bba4-7b47b32ea424.png)
Khi đó nếu chỉ set car1, car2 = nil, thì Car vẫn còn 1 strong reference từ car3 trỏ đến -> ARC sẽ không giải phóng bộ nhớ cho Car trong trường hợp này.

### **3.1. Strong reference giữa các class**
```
class Person {
    var department: Department?
    deinit {
        print("Person is being deinitialized")
    }
}

class Department {
    var owner: Person?
    deinit {
        print("Department is being deinitialized")
    }
}

var duy: Person? = Person()
var hadong: Department? = Department()

duy!.department = hadong
hadong!.owner = duy

duy = nil
hadong = nil
```
Trong ví dụ trên, sẽ tạo ra 1 sơ đồ relation giữa các instance như sau:

![](https://images.viblo.asia/6eecf4a2-9928-4d23-b835-04112647df77.jpg)

* Việc set property department và owner của 2 instance tuan và gotham đã tạo ra 2 strong reference trỏ đến nhau.
* Khi đó Person và Departmen, mỗi thứ sẽ có 2 strong refernce trỏ đến. Vì vậy, khi bạn chỉ set tuan = nil và gotham = nil thì Person và Departmen vẫn sẽ không được xóa khỏi bộ nhớ dù không cần dùng đến nữa.

**-> Trường hợp này gọi là retain cycle -> Tạo ra rò rỉ bộ nhớ (memory leaks).**

### **3.2. Xử lí strong reference**

Swift cung cấp 2 cách để xử lí strong reference cycle khi bạn làm việc với các biến kiểu class:

* *weak reference*
* *unowned reference*

## **4. Weak reference**

* *weak refernce*: thay vì tạo 1 strong reference, nó sẽ chỉ tạo 1 weak -> ARC sẽ không làm tăng số lượng strong reference trỏ tới biến đó.
* Sử dụng *weak reference* khi biến còn lại có thời gian tồn tại ngắn hơn(thường bị giải phóng bộ nhớ trước)
```
class Person {
    weak var department: Department?

    deinit {
        print("Person is being deinitialized")
    }
}
```
Sửa lại ví dụ trên bằng cách sửa department thành kiểu **weak**( vì department có thời gian tồn tại ngắn hơn người).
Khi đó, sơ đồ relation ship sẽ thành:
![](https://images.viblo.asia/feaf548c-0e94-4789-a584-095d2104adbb.jpg)
* set *hadong = nil* -> Departmen k còn strong reference nào trò đến -> được giải phóng khỏi bộ nhớ, khi đó strong reference của Departmen trò đến Person cũng sẽ bị mất.
* set *duy = nil* -> Person không còn strong refernce nào trỏ đến -> ARC giải phóng khỏi bộ nhớ.
Kết quả thu được:
```
Department is being deinitialized
Person is being deinitialized
```
## **5. Unowned reference**
* Tương tự như **weak refernce**, nó sẽ không tạo ra 1 **strong reference**.
* Khác **weak reference** ở chỗ, **unowned** dùng cho những biến có thời gian tồn tại lâu hơn.
Note: nếu bạn truy cập đến 1 biến **unowned** sau khi nó đã được giải phóng khỏi bộ nhớ -> app sẽ **crash**. Vì vậy hãy cẩn thận khi dùng unowned.
Sửa ví dụ trên thành như sau và sẽ vẫn thu được kết quả tương tự so với khi dùng **weak**:
```
class Department {
    unowned var owner: Person?

    deinit {
        print("Department is being deinitialized")
    }
}
```
![](https://images.viblo.asia/058ea8d9-bdd0-4bf2-958c-fc2926dc78c6.jpg)
**Tài liệu tham khảo** :
https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
> Hi vọng sau bài viết này các bạn đọc có thể hiểu một cách khái quát về cơ chế ARC. Cảm ơn các bạn đã đọc và mọi câu hỏi hay ý kiến các bạn hãy để dưới bình luận nhé !!!!
>', '2023-02-12T12:58:39.000000Z', '2023-02-23T09:02:09.000000Z', '2023-02-12T12:57:39.000000Z'),
	('Xpath cho người nông dân - Phần 1', 'GrLZDDRJZk0', '6', 'unlisted', 'https://images.viblo.asia/f1ee95f5-a657-4c99-9967-eba6ade9e36a.jpg', 'Anh Tèo là nông dân ở một trang trại rau A nọ. Dịch COVID-19 bùng phát, trang trại phải chấp hành lệnh của chính phủ, tạm dừng hoạt động.
Chả có việc gì làm ngoài lướt thiên địa cả ngày, anh Tèo chán quá nên tìm lại đống sách cũ đọc.

Nào là bí kíp xem xong xóa, học tiếng Nhật cùng idol,... cùng vô vàn các cuốn kinh thư đi cùng tuổi thơ anh. Chợt anh thấy ở góc nhà có cuốn sách lạ, lật lên và đ...', 'Anh Tèo là nông dân ở một trang trại rau A nọ. Dịch COVID-19 bùng phát, trang trại phải chấp hành lệnh của chính phủ, tạm dừng hoạt động.
Chả có việc gì làm ngoài lướt thiên địa cả ngày, anh Tèo chán quá nên tìm lại đống sách cũ đọc.


Nào là bí kíp xem xong xóa, học tiếng Nhật cùng idol,... cùng vô vàn các cuốn kinh thư đi cùng tuổi thơ anh. Chợt anh thấy ở góc nhà có cuốn sách lạ, lật lên và đọc tiêu đề: "Automation chân kinh".

Nhờ đọc cuốn sách trên, anh đã trở thành một QA thực thụ tại công ty công nghệ A. Series automation này kể lại quá trình mà anh Tèo học automation, các kiến thức cơ bản, các lỗi thường gặp mà anh học được. Đây là bài đầu tiên trong series này.

## Chém về XPath
Trước tiên, bạn cần 1 chút kiến thức về DOM. Nếu chưa biết, bạn hãy đọc qua [bài này](https://freetuts.net/dom-la-gi-cac-loai-dom-trong-javascript-366.html) để có cái nhìn tổng quan về DOM nhé.

Để việc học dễ dàng và thực hành thú vị hơn, anh Tèo đã chuẩn bị 1 chiếc DOM html ở đây. Bạn hãy mở link dưới đây ở 1 tab mới, để có thể thực hành cùng anh Tèo nghen ^^

https://minhphong306.github.io/static/teo_xpath.html

Chiếc DOM trên sẽ hiển thị như sau:
![](https://images.viblo.asia/f1ee95f5-a657-4c99-9967-eba6ade9e36a.jpg)

Lưu ý là thứ tự trong bảng danh sách ca sĩ được random, nên mỗi lần F5 refresh lại trình duyệt sẽ có thể khác nhau.

Anh Tèo mở sách, đọc những dòng đầu tiên

```
- XPath, hay XML Path là cách để tìm kiếm phần tử trên trang, sử dụng cú pháp của xml.

- XPath có hai loại: tìm kiếm tuyệt đối và tìm kiếm tương đối
Tuyệt đối: bắt đầu bằng "/" (một dấu gạch chéo)
Tương đối: bắt đầu bằng "//" (hai dấu gạch chéo)

- Cú pháp cơ bản:
<loại_xpath> <tagname>[<thuộc_tính>=<giá_trị>]
```

- Củ lạc giòn tan - anh Tèo nghĩ - cái gì mà tương đối với tuyệt đối, nghe phắc tạp vậy. Oh, có ví dụ này

```
-- Ví dụ tìm kiếm tới thẻ tiêu đề "Tèo học xpath", ta làm như sau:
**Tìm kiếm tuyệt đối:**
/html/body/div/div/div/h2
**Tìm kiếm tương đối**
//h2[@class=''header'']
```
Anh Tèo mở link thực hành phía trên, bấm F12, chọn tab elements để test thử. Anh nhập đoạn xpath tìm kiếm tuyệt đối vào ô tìm kiếm thì thấy hiển như như hình dưới:
![image.png](https://images.viblo.asia/1dd19854-6695-4698-868d-0ca6ba68ab8c.png)

-- Oh,  thì ra tuyệt đối ở đây nghĩa là cần chỉ ra chính xác tuyệt đối đường dẫn từ nhỏ tới lớn. Trong ví dụ trên thì cần chỉ ra đi từ thẻ html rồi đến body, div, div,..., giống như khi tìm đường bằng Google Map, cần nhập chính xác tọa độ (kinh độ, vĩ độ) vậy

```
/html/body/div/div/div/h2
```

-- Hơi nông dân nhỉ. Giờ mà tìm kiếm cái nào sâu sâu tí thì khéo xpath dài hơn cả ... của mình ấy chứ. Thử cái tương đối xem có tiến bộ hơn không nào

![image.png](https://images.viblo.asia/f7fab751-f948-4d29-80eb-7d4892604936.png)

-- Ahh, thú vị hơn này. Thay vì nhập đường dẫn tuyệt đối, ta chỉ cần chỉ ra những đặc tính riêng biệt của phần tử cần chọn. Trong ví dụ trên thì chỉ cần chỉ ra thẻ cần tìm là thẻ h2, có class là header là được. Cũng giống như việc tìm đường, chỉ cần chỉ ra phố Trần Duy Hưng, gốc cây số bao nhiêu, à nhầm số nhà bao nhiêu, là được. Không cần phải kinh độ hay vĩ độ gì cho khó nhớ cả. Hihi

```
//h2[@class=''header'']
```

-- Dễ nhỉ. Thử làm bài tập coi.

Bài tập:
1. Viết xpath tìm kiếm ô checkbox của Sơn Tùng M-TP

Mở tab elements lên, anh Tèo bắt đầu phân tích

-- Cái ô checkbox cần tìm có thẻ là input, id là "cbSonTung". Như vậy chỉ cần viết 1 chiếc XPath đơn giản thế này là ngon ngay

```
//input[@id=''cbSonTung'']
```

![image.png](https://images.viblo.asia/828ad5ff-000f-4ef6-8a18-f42db35043af.png)

2. Giống bài 1, nhưng không được dùng thuộc tính id

-- Không dùng id à. Vậy thì mình sẽ  tìm tất cả các input có type là checkbox. Sau nó tìm đến cái checkbox thứ 3 là được.
```
(//input[@type=''checkbox''])[3]
```
Bạn đọc lưu ý chỗ này nha. Bình thường để tìm phần tử có input có type là checkbox, chúng ta làm như sau:
```
//input[@type=''checkbox'']
```
Vì kết quả có thể có nhiều hơn 1 phần tử, nên ta có thể dùng cặp ngoặc vuông, bên trong là số thứ tự của phần tử để chọn chính xác phần tử đó
```
[3]
```
Và để search được trong ô tìm kiếm của chrome, bạn cần bao cái xpath bằng 1 cặp ngoặc tròn "()"
```
(xpath)[vị_trí]
```
Như trong ví dụ của anh Tèo:
```
(//input[@type=''checkbox''])[3]
```
-- Nggonnnn - anh Tèo cao hứng.

Bây giờ, bạn thử F5 lại trình duyệt, tìm kiếm lại với xpath vừa làm ở bài 2

-- Thử F5 coi có gì khác nào

![image.png](https://images.viblo.asia/8378c79a-161e-4507-b261-3fe0eea96500.png)

Sau khi F5, anh Tèo thấy vẫn tìm được phần tử, nhưng lần này lại là checkbox của Bích Phương, không phải Sơn Tùng M-TP.

-- Thôi toang. Hiểu rồi. Thì ra các phần tử có thể thay đổi được thứ tự, nên tìm kiếm kiểu dùng vị trí là hơi dâm, sẽ bị sai. Làm thế nào nhỉ ??

Vừa nghĩ, anh Tèo vừa lật trang sách

Lúc này bạn cần dùng tới axes method để tìm kiếm các phần tử động.

Muốn biết anh Tèo tìm checkbox của Sơn Tùng M-TP kiểu gì, bạn hãy đón đọc phần 2: Tìm kiếm XPath cho checkbox Sơn Tùng M-TP nhé ^^

## Nguồn
Bài viết được trích từ blog của mình: [Link](https://minhphong306.wordpress.com/2020/06/26/automation-test-xpath-cho-nguoi-nong-dan/)

Nếu trong bài viết có gì sai sót, bạn hãy cho mình biết nhé ^^

Đầu năm mới, chúc toàn thể anh chị em Viblo một năm tràn đầy năng lượng, đặt goal và giữ kỉ luật để đạt goal của mình nhé 🔥🔥', '2023-02-12T10:15:57.000000Z', '2023-02-28T03:00:23.000000Z', '2023-02-12T10:19:33.000000Z'),
	('Tối ưu sử dụng Hooks trong React', '018J2vawJYK', '7', 'unlisted', '', 'Xin chào các bạn, tiếp tục series về React thì hôm nay mình xin chia sẻ về cách sử dụng tối ưu các hooks trong React. Thì React hooks được release vào phiên bản v16. 8.0 cách đây cũng được 4 năm rồi, khi react hooks ra đời thì đã làm thay đổi tư duy lập trình của các lập trình viên. Và hôm nay mình muốn nói về việc chuyển đổi từ class component sang function components + hooks
Vòng đời
Class co...', 'Xin chào các bạn, tiếp tục series về React thì hôm nay mình xin chia sẻ về cách sử dụng tối ưu các hooks trong React. Thì React hooks được release vào phiên bản v16. 8.0 cách đây cũng được 4 năm rồi, khi react hooks ra đời thì đã làm thay đổi tư duy lập trình của các lập trình viên. Và hôm nay mình muốn nói về việc chuyển đổi từ class component sang function components + hooks
## Vòng đời
### Class component
```javascript
class Chart extends Component {
  componentDidMount() {
    // khi đã mount Chart
  }
  componentDidUpdate(prevProps) {
    if (prevProps.data == props.data) return
    // khi update dữ liệu
  }
  componentWillUnmount() {
    // trước khi unmount Chart
  }
  render() {
    return (
      <svg className="Chart" />
    )
  }
}
```
### Function component
```javascript
const Chart = ({ data }) => {
  useEffect(() => {
    // khi mount Chart hoặc update dữ liệu
    return () => {
      // khi update dữ liệu
      // trước khi unmount chart
    }
  }, [data])
  return (
    <svg className="Chart" />
  )
}
```
## Cập nhật dữ liệu
Sử dụng useEffect để nắm bắt vòng đời của React.
Có phải bạn đang suy nghĩ useEffect thật là vi diêu không?😃😃😃. Nhưng mà chưa đâu thật sự useEffect không phải là hook để giải quyết mọi vấn đề. Hãy cùng mình tìm hiểu tiếp nhá.
Bây giờ hãy xem một ví dụ khác biệt là muốn tính toán dữ liệu bằng hàm getDataWithinRange.
### Class component
```javascript
class Chart extends Component {
  state = {
    data: null,
  }
  componentDidMount() {
    const newData = getDataWithinRange(this.props.dateRange)
    this.setState({data: newData})
  }
  componentDidUpdate(prevProps) {
    if (prevProps.dateRange != this.props.dateRange) {
      const newData = getDataWithinRange(this.props.dateRange)
      this.setState({data: newData})
    }
  }
  render() {
    return (
      <svg className="Chart" />
    )
  }
}
```

### Function component
```javascript
const Chart = ({ dateRange }) => {
  const [data, setData] = useState()
  useEffect(() => {
    const newData = getDataWithinRange(dateRange)
    setData(newData)
  }, [dateRange])
  return (
    <svg className="Chart" />
  )
}
```
useEffect đang cập nhật data dựa vào sự thay đổi của dateRange => khi prop dateRange thay đổi thì useEffect được kích hoạt và tính toán newData bằng function getDataWithinRange sau đó cập nhật lại dữ liệu bằng hook setData.
Thay vì sử dụng 2 hook useEffect và useStatet thì ta có thể tối ưu bằng hook useMemo
```javascript
const Chart = ({ dateRange }) => {
  const data = useMemo(() => (
    getDataWithinRange(dateRange)
  ), [dateRange])
  return (
    <svg className="Chart" />
  )
}
```
Dưới đây là 1 ví dụ thấy sự tối ưu rõ rệt về code giữa class component và function component
## Ví dụ
### Class component
```javascript
class Chart extends Component {
  state = {
    data: null,
    dimensions: null,
    xScale: null,
    yScale: null,
  }
  componentDidMount() {
    const newData = getDataWithinRange(this.props.dateRange)
    this.setState({data: newData})
    this.setState({dimensions: getDimensions()})
    this.setState({xScale: getXScale()})
    this.setState({yScale: getYScale()})
  }
  componentDidUpdate(prevProps, prevState) {
    if (prevProps.dateRange != this.props.dateRange) {
      const newData = getDataWithinRange(this.props.dateRange)
      this.setState({data: newData})
    }
    if (prevProps.margins != this.props.margins) {
      this.setState({dimensions: getDimensions()})
    }
    if (prevState.data != this.state.data) {
      this.setState({xScale: getXScale()})
      this.setState({yScale: getYScale()})
    }
  }
  render() {
    return (
      <svg className="Chart" />
    )
  }
}
```

### Function component
```javascript
const Chart = ({ dateRange, margins }) => {
  const data = useMemo(() => (
    getDataWithinRange(dateRange)
  ), [dateRange])
  const dimensions = useMemo(getDimensions, [margins])
  const xScale = useMemo(getXScale, [data])
  const yScale = useMemo(getYScale, [data])
  return (
    <svg className="Chart" />
  )
}
```
Như ví dụ trên class component phải quản lý quán nhiều state, trong khi function component thì chỉ cần giá trị của biến đầu ra. Mã ngắn hơn chưa chắc là dễ đọc hơn nhưng chắc chắn việc quản lý state sẽ dễ dàng hơn. Và thường thì các đoạn mã trong function component của chúng tôi ngắn hơn trong class component là từ 46% đến 50%

### Lời kết
Như vậy là mình cùng các bạn đã đi qua vòng đời của React để biết sự khác biệt của class component và function component, cũng như tìm hiểu useMemo để quản lý state trong React. Hy vọng các bạn sẽ có thêm những kiến thức giúp tối ưu code và maintain dễ dàng hơn về sau. Chúc các bạn có 1 ngày làm việc hiệu quả.', '2023-02-12T06:47:19.000000Z', '2023-02-27T17:00:36.000000Z', '2023-02-12T06:46:38.000000Z'),
	('Wireshark Advanced Usage - Sử dụng Wireshark nâng cao', 'x7Z4DDal4nX', '8', 'unlisted', 'https://images.viblo.asia/4e77a6d7-2d82-43da-adaf-fcfa50a383e8.png', 'Đây là phần 2 về Wireshark. Trong phần này, chúng ta sẽ đề cập đến một số cách sử dụng nâng cao với Wireshark. Các nhà phát triển dự án đã bao gồm nhiều khả năng khác nhau, từ theo dõi các cuộc hội thoại TCP đến bẻ khóa thông tin xác thực không dây.
I. The Statistics and Analyze Tabs
Tab Statistics và Analyze có thể cung cấp cho chúng ta cái nhìn sâu sắc về dữ liệu mà chúng ta đang kiểm tra. Từ...', 'Đây là phần 2 về Wireshark. Trong phần này, chúng ta sẽ đề cập đến một số cách sử dụng nâng cao với Wireshark. Các nhà phát triển dự án đã bao gồm nhiều khả năng khác nhau, từ theo dõi các cuộc hội thoại TCP đến bẻ khóa thông tin xác thực không dây.
# I. The Statistics and Analyze Tabs
Tab Statistics và Analyze có thể cung cấp cho chúng ta cái nhìn sâu sắc về dữ liệu mà chúng ta đang kiểm tra. Từ những điểm này, chúng ta có thể sử dụng nhiều plugin tích hợp sẵn mà Wireshark cung cấp. Các plugin ở đây có thể cung cấp cho chúng ta các báo cáo chi tiết về lưu lượng mạng đang được sử dụng. Nó có thể hiển thị cho chúng ta mọi thứ, từ những top talkers hàng đầu trong environment đến các cuộc trò chuyện cụ thể và thậm chí phân tích theo IP và giao thức.
## A. Statistics Tab
![image.png](https://images.viblo.asia/4e77a6d7-2d82-43da-adaf-fcfa50a383e8.png)

Mỗi mục menu sẽ hiển thị một cửa sổ mới hiển thị số liệu thống kê cụ thể.

## B. Analyze Tab
Từ tab Analyze, chúng ta có thể sử dụng các plugin cho phép chúng tôi thực hiện những việc như theo dõi các luồng TCP, lọc các loại hội thoại, chuẩn bị các bộ lọc gói mới và kiểm tra thông tin mà Wireshark tạo ra về lưu lượng truy cập. Dưới đây là một vài ví dụ về cách sử dụng các plugin này.


![image.png](https://images.viblo.asia/c69ef34e-9073-4de2-bf56-58a2d836c8d8.png)

### 1. TCP Streams
Wireshark có thể ghép các gói TCP lại với nhau để tạo lại toàn bộ luồng ở định dạng có thể đọc được. Khả năng này cũng cho phép chúng ta lấy dữ liệu ( images, files, etc.) ra khỏi quá trình chụp. Điều này hoạt động với hầu hết mọi giao thức sử dụng TCP làm cơ chế vận chuyển.

![ezgif-3-c3a050e9b9.gif](https://images.viblo.asia/8e8f3b5b-79dc-4dea-842e-81b04473af56.gif)

### 2. Extract Files From The GUI
Một cách thú vị khác để lấy dữ liệu từ tệp pcap đến từ FTP. Giao thức truyền tệp di chuyển dữ liệu giữa máy chủ và máy chủ để lấy dữ liệu đó ra khỏi byte thô và tái tạo lại tệp. (hình ảnh, tài liệu văn bản, v.v.) FTP sử dụng TCP làm giao thức vận chuyển và sử dụng các cổng 20 & 21để hoạt động. Cổng TCP 20 được sử dụng để truyền dữ liệu giữa máy chủ và máy chủ, trong khi cổng 21 được sử dụng làm cổng điều khiển FTP. Bất kỳ lệnh nào như đăng nhập, liệt kê tệp và phát hành tải xuống hoặc tải lên đều diễn ra qua cổng này. Để làm như vậy, chúng ta cần xem xét các FTPbộ lọc hiển thị khác nhau trong Wireshark.


![ezgif-1-660a6958da.gif](https://images.viblo.asia/4ec2780d-f237-4036-8a08-1dc40d295c23.gif)

# II. Filter
Các bộ lọc cũng được sử dụng bởi các tính năng khác như tạo số liệu thống kê và tô màu danh sách gói (tính năng sau chỉ khả dụng cho Wireshark ). Bạn có thể tìm thấy tham chiếu toàn diện về các trường bộ lọc trong Wireshark và trong tham chiếu bộ lọc hiển thị tại https://www.wireshark.org/docs/dfref/ .

Ở đây mình có một bài ctf misc của LACTF về **RFC 3514** có liên quan đến phần này. ~~[misc/EBE](https://lactf-challs.storage.googleapis.com/uploads/a94835a27e3f85ce743e2b0f5fa87a6cd62089b1919795e08b28478d0a581a88/EBE.pcap)~~

![image.png](https://images.viblo.asia/fc86c5e6-e4cc-49a8-9ed3-6c546f90699e.png)

Khi chưa dùng filter thì chúng ta thấy ở phần Follow UDP Stream là một flag bị làm nhiễu và trong trường hợp chúng ta không biết về quy tắc làm nhiễu.

![image.png](https://images.viblo.asia/5e5936e8-a6df-4d47-8b8b-c45ee8cd3c6d.png)

Vậy bước đầu để giải được bài này thì chúng ta cần so sánh ký tự đúng với ký tự bị làm nhiễu!

Với flag mẫu chúng ta có được từ người ra đề là lactf{123456}. Vậy chúng ta sẽ so sánh **lactf** với các ký tự khác.

![image.png](https://images.viblo.asia/69cebc2c-76be-4ef7-94fc-c097b0cab0c6.png)


![image.png](https://images.viblo.asia/f1fce5ef-55b0-45b4-bbdf-067b963a991c.png)

Vậy **Header Checksum** của ký tự đúng là **0x64c1** và sai là **0xe4c0**.

=> Công thức Filter của phần này là **ip.checksum == 0x64c1**

Sau đó chúng ta sẽ lấy được flag là: **lactf{3V1L_817_3xf1l7R4710N_4_7H3_W1N_51D43c8000034d0c}**', '2023-02-11T22:02:28.000000Z', '2023-02-27T06:23:06.000000Z', '2023-02-11T22:01:42.000000Z'),
	('Luồng I/O  trong Java', 'vlZL990WLQK', '9', 'unlisted', 'https://images.viblo.asia/852d252c-308c-4761-a75d-9546ee72fac0.jpg', 'Luồng I/O trong Java

Trong project này chúng ta sẽ cùng nhau làm quen với khái niệm luồng (streams) và file.
- Khái niệm luồng (stream): Một stream có thể được định nghĩa như là một dãy liên tục dữ liệu. Java định nghĩa 2 kiểu luồng: byte và ký tự (phiên bản gốc chỉ định nghĩa kiểu luồng byte, và sau đó luồng ký tự được thêm vào trong các phiên bản về sau). Luồng ký tự được thiết kế hỗ trợ việ...', '## Luồng I/O trong Java
[![Build](https://github.com/TheAlgorithms/Java/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/hoangtien2k3qx1/Java)
[![Discord chat](https://img.shields.io/discord/808045925556682782.svg?logo=discord&colorB=7289DA&style=flat-square)](https://discord.com/channels/1016568392267866162/1016568393068986463)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/hoangtien2k3qx1/Java)

Trong project này chúng ta sẽ cùng nhau làm quen với khái niệm luồng (streams) và file.
- **Khái niệm luồng (stream)**: Một stream có thể được định nghĩa như là một dãy liên tục dữ liệu. Java định nghĩa 2 kiểu luồng: byte và ký tự (phiên bản gốc chỉ định nghĩa kiểu luồng byte, và sau đó luồng ký tự được thêm vào trong các phiên bản về sau). Luồng ký tự được thiết kế hỗ trợ việc nhập xuất dữ liệu kiểu ký tự (Unicode). Trong một vài trường hợp luồng ký tự sử dụng hiệu quả hơn luồng byte, nhưng ở mức hệ thống thì tất cả những xuất nhập đều phải qui về byte. Luồng ký tự hỗ trợ hiệu quả chỉ đối với việc quản lý, xử lý các ký tự.

### Luồng Byte:
- Các luồng byte được định nghĩa dùng hai lớp phân cấp, mức trên cùng là hai lớp trừu tượng **InputStream** và **OutputStream**, là các lớp cha của các lớp xuất nhập kiểu byte. InputStream định nghĩa những đặc điểm chung cho những luồng nhập byte. OutputStream mô tả cách xử lý của các luồng xuất byte.

<img src="http://i.imgur.com/TdlBT3Z.png">

Nhìn trong hình, bạn có thể hiểu được quan hệ giữa các class trong IO với nhau. Chúng ta cần quan tâm nhiều đến **FileInputStream** (FileOutputStream) và **BufferedInputStream** (BufferedOutputStream) khi làm việc xuất nhập với file.
- **FileInputStream**: Làm việc với file, Đọc từng byte dữ liệu bằng phương thức read(), khi kết thúc nó trả về giá trị -1. Cách này có tốc độ tương đối chậm.
Đọc theo từng byte:


```sh
FileInputStream in = new FileInputStream("data.txt");
while ((byteRead = in.read()) != -1) {
  System.out.println(byteRead);
}
```
Đọc theo từng mảng byte.
```java
//Dữ liệu đọc được lưu vào mảng byteBuf.
//byteRead là số byte đọc được
FileInputStream in = new FileInputStream("data.txt");
byte[] byteBuf = new byte[4096];
while ((byteRead = in.read()) != -1) {
  for(int i = 0; i <= byteRead; i++){
    System.out.println(byteBuf[i]);
  }
}
```

### Tuy nhiên điều này dường như không được khuyến khích. Để tăng tốc độ bằng việc sử dụng bộ đệm, hãy sử dụng [**BufferedInputStream**].
- **BufferedInputStream**: Java sử dụng cơ chế nhập/xuất có lập vùng đệm để tạm thời lập cache dữ liệu vào/ra của một dòng. Nó giúp chương trình đọc/ghi lượng dữ liệu nhỏ không ảnh hưởng lớn đến hiệu năng chung của hệ thống. Trong khi thực hiện vào có vùng đệm, một số lượng byte lớn được đọc tại một thời điểm, và lưu trữ trong một vùng đệm nhập. Khi chương trình đọc dòng nhập thì thay vì ra dòng vào để đọc nó đọc từ vùng đệm nhập. Tiến trình lập vùng đệm ra cũng thực hiện tương tự. khi dữ liệu được một chương trình ghi ra dòng ra, dữ liệu ra được lưu trữ trong một vùng đệm ra. Dữ liệu được lưu trữ đến khi vùng đệm đầy hoặc các dòng tra thực hiện xả trống (flush). Cuối cùng liệu ra trong vùng đệm được chuyển đến dòng ra.

Lớp này tự động tạo ra và duy trì vùng đệm để hỗ trợ thao tác vào. Nhờ đó chương trình có thể đọc dữ liệu từ dòng từng byte một mà không ảnh hưởng đến tốc độ thực hiện của hệ thống. Bởi lớp **BufferedInputStream** là một bộ lọc, nên có thể áp dụng nó cho một số đối tượng nhất định của lớp InputStream (không nhất thiết chỉ làm việc với file) và cũng có thể phối hợp với các tập tin đầu vào khác.
BufferedInputStream được hiểu một phương thức trung gian, tham số truyền vào của nó là một dòng inputstream (ví dụ FileInputStream). Khác với FileInputStream có tham số truyền vào 1 file.
```sh
BufferedInputStream in = new BufferedInputStream(new FileInputStream("data.txt"));
while ((byteRead = in.read()) != -1) {
  System.out.println(byteRead);
}
```
Đọc theo mảng byte:
```sh
BufferedInputStream in = new BufferedInputStream(new FileInputStream("data.txt"));
byte[] byteBuf = new byte[4096];
while ((byteRead = in.read()) != -1) {
  for(int i = 0; i <= byteRead; i++){
    System.out.println(byteBuf[i]);
  }
}
```
- **Các phương thức của lớp InputStream**

|Tên phương thức	|Mô tả|
|------------------------|-----|
|read()|	Đọc các byte dữ liệu từ một dòng. Nếu như không có byte dữ liệu nào, nó phải chờ. Khi một phương thức phải chờ, các luồng đang thực hiện phải tạm dừng cho đến khi có dữ liệu.|
|read (byte [])|	Trả về số byte đọc được hay ‘-1’ nếu như đã đọc đến cuối dòng. Nó gây ra ngoại lệ IOException nếu có lỗi xảy ra.|
|read (byte [], int, int)|	Nó cũng đọc vào một mảng byte. Nó trả về số byte thực sự đọc được cho đến khi kết thúc dòng. Nó gây ra ngoại lệ IOException nếu lỗi xảy ra.|
|available()|	Phương pháp này trả về số lượng byte có thể đọc được mà không pahỉ chờ. Nó trả về số byte hiện tại có trong dòng. Nó không phải là phương thức tin cậy để thực hiện tiến trình xử lý đầu vào.|
|close()|	Phương thức này đóng dòng. Nó dùng để giải phóng mọi tài nguyên dòng đã sử dụng. Luôn luôn đóng dòng để chắc chắn rằng dòng xử lý được kết thúc. Nó gây ra ngoại lệ IOException nếu lỗi xảy ra.|
|mark()|	Đánh dấu vị trí hiện tại của dòng.|
|markSupported()|	Trả về giá trị boolean chỉ ra rằng dòng có hỗ trợ các khả năng mark và reset hay không. Nó trả về True nếu dòng hỗ trợ ngược lại trả về False.|
|reset()|	Phương thức này định vị lại dòng theo vị trí được đánh lần cuối cùng. Nó gây ra ngoại lệ IOException nếu lỗi xảy ra.|
|skip()|	Phương thức này bỏ qua ‘n’ byte dòng vào. "-n" chỉ định số byte được bỏ qua. Nó gây ra ngoại lệ IOException nếu lỗi xảy ra. Phương thức này sử dụng để di chuyển tới vị trí đặc biệt bên trong dòng vào.|

- **Các phương thức của lớp OutputStream**

|Tên phương thức	   |Mô tả|
|--------------------|-----|
|write(int)|	Phương thức này ghi một byte|
|write(byte[])|	Phương thức này phong toả cho đến khi một byte được ghi. dòng phải chờ cho đến khi tác vụ ghi hoàn tất. Nó gây ra ngoại lệ IOException nếu lỗi xảy ra.|
|write(byte[],int,int)|	Phương thức này ghi mảng các byte. Lớp OutputStream định nghĩa ba dạng khác nhau của phương thức để có thể ghi một byte riêng lẻ, một mảng các byte, hay một đoạn của một mảng byte.|
|flush()|	Phương thức này xả sạch dòng.Đệm dữ liệu được ghi ra dòng. Nó kích hoạt IOException nếu lỗi xảy ra.|
|close()|	Phương thức đóng dòng.Nó được dùng để giải phóng mọi tài nguyên gắn với dòng. Nó kích hoạt IOException nếu lỗi xảy ra.|

### Luồng ký tự:
Trong nhiều trường hợp luồng byte không phải là cách tốt nhất để quản lý nhập xuất dữ liệu ký tự. Trong lập trình Java có kiểu luồng ký tự phục vụ riêng cho việc nhập xuất dữ liệu trên luồng. Mức trên cùng là 2 lớp trừu tường Reader và Writer. Các lớp dẫn xuất từ Reader và Writer hỗ trợ thao tác trên các luồng ký tự Unicode.

<img src="http://i.imgur.com/2Ltj8wI.png">

Để thao tác với file, bạn cần quan tâm đến các class *FileReader* và *BufferedReader*
Ví dụ chỉ sử dụng FileReader
```sh
//Đọc từng ký tự một
FileReader inputStream = new FileReader("data.txt");
int c;
while ((c = inputStream.read()) != -1) {
  System.out.print((char)c);
}
```

Nếu sử dụng BufferedReader
```sh
//Có thể đọc theo từng dòng
FileReader fin = new FileReader("data.txt");
BufferedReader in = new BufferedReader(fin);
String str;
while ((str = in.readLine()) != null) {
  System.out.println(str);
}
```
Ví dụ đọc dữ liệu từ hệ thống (Console)
```sh
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
System.out.println("Nhập chuỗi ký tự, kết thúc bằng dấu chấm .");
do {
  c = (char) br.read();
  System.out.println(c);
} while (c != ''.'');
```
Ở đây, chúng ta không có cách nào xây dựng 1 lớp BufferedReader trực tiếp từ System.in vì thế nên cần chuyển nó thành luồng ký tự bằng cách dùng InputStreamReader để chuyển byte thành ký tự.

- **Các phương thức của lớp Reader**

|Phương thức |Mô tả|
|------------|-----|
|void close | Đóng luồng|
|void mark(int numChars)| Đánh dấu vị trí hiện tại trên luồng|
|int read()| Đọc một ký tự|
|int read(char buffer[])| đọc buffer.length ký tự và ghi vào buffer|
|abstract int read(char buffer[], int offset, int numChars)| Đọc numChars ký tự cho vào vùng đệm buffer tại vị trí buffer[offset]|
|boolean ready()| Kiểm tra xem luồng có đọc được không|
|void reset()| Dời con trỏ nhập đến vị trí đánh dấu trước đó|
|long skip(long numChars| Bỏ qua numChars của luồng nhập|

- **Các phương thức của lớp Writer**

| abstract void close() | Đóng luồng xuất|
|-----------------------|----------------|
| void flush() | Dọn dẹp luồng. (Xuất buffer ra)|
| void write(int ch) | Ghi một ký tự|
| void write(byte buffer[]) | Ghi một mảng ký tự|
| void write(char buffer[], int offset, int numChars) | Ghi một phần của mảng ký tự|
| void write(String str) | Ghi một chuỗi|
| void write(String str, int offset, int numChars) | Ghi một phần của chuỗi ký tự|

### Đọc và ghi đối tượng trong Java
Trong Java, việc đọc và ghi một object do class ObjectOutputStream và ObjectInputStream đảm nhiệm. Đây là 2 lớp con của lớp java.io.OutputStream và java.io.InputStream. Để đọc ghi theo Object trong Java thì tại class Object đó ta cần đặt giao tiếp java.io.Serializable. Một ví dự đơn giản đọc ghi 1 Object MyStudent như sau:
```Java
public class ReadWriteObject {
    public static void main(String[] args){
        MyStudent myStudent = new MyStudent(); // tao doi tuong myStudent

        //Ghi Object vao file

        try {   // dat try cacth de tranh ngoai le khi tao va viet File
            FileOutputStream f = new FileOutputStream("student.dat"); // tao file f tro den student.dat
            ObjectOutputStream oStream = new ObjectOutputStream(f); // dung de ghi theo Object vao file f
            oStream.writeObject(myStudent); // ghi MyStudent theo kieu Object vao file
            oStream.close();
        } catch (IOException e) {
            System.out.println("Error Write file");
        }

        // doc Object tu file
        MyStudent ms = null;

        try {   // dat try cacth de tranh ngoai le khi tao va doc File
            FileInputStream f = new FileInputStream("student.dat"); // tao file f tro den student.dat
            ObjectInputStream inStream = new ObjectInputStream(f);  // dung de doc theo Object vao file f
            // dung inStream doc theo Object, ep kieu tra ve la MyStudent
            ms = (MyStudent) inStream.readObject();
            inStream.close();
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found");
        } catch (IOException e) {
            System.out.println("Error Read file");
        }

        // Xuat KQ
        System.out.println("My name is " + ms.name + ". I am " + ms.age + " years old");
    }
}

class MyStudent implements Serializable{
    String name = "Nguyen Cong Thanh";
    int age = 21;
}
```

### Tài liệu tham khảo:

Link project github: [**https://github.com/hoangtien2k3qx1/Java/tree/main/JavaCore/Java_Input_Output**](https://github.com/hoangtien2k3qx1/Java/tree/main/src/main/java/JavaCore/Java_Input_Output)

Github: [**https://github.com/hoangtien2k3qx1**](https://github.com/hoangtien2k3qx1)', '2023-02-11T19:57:22.000000Z', '2023-02-28T04:46:03.000000Z', '2023-02-13T18:38:43.000000Z'),
	('Chương 6: TREES - 7.Cây tìm kiếm nhị phân:Problems & Solutions(52-61)', '5pPLkPDNVRZ', '10', 'unlisted', 'https://images.viblo.asia/7a5e6819-6214-4695-985d-9b7a7ad1cda1.png', 'Lưu ý: Đối với các vấn đề liên quan đến thứ tự với cây tìm kiếm nhị phân(binary search trees) và cây tìm kiếm nhị phân cân bằng (balanced binary search trees), Inorder traversal có lợi thế hơn các loại duyệt khác vì nó đưa ra thứ tự được sắp xếp.

Problem-52
Đưa ra thuật toán tìm đường đi ngắn nhất giữa hai node trong BST.

Solution: Không gì khác ngoài việc tìm LCA của hai node trong BST. [Pro...', '**Lưu ý**: Đối với các vấn đề liên quan đến thứ tự với cây tìm kiếm nhị phân(binary search trees) và cây tìm kiếm nhị phân cân bằng (balanced binary search trees), Inorder traversal có lợi thế hơn các loại duyệt khác vì nó đưa ra thứ tự được sắp xếp.

### Problem-52
Đưa ra thuật toán tìm đường đi ngắn nhất giữa hai node trong BST.

**Solution:** Không gì khác ngoài việc tìm LCA của hai node trong BST. [Problem 54]

### Problem-53
Đưa ra thuật toán đếm số BST có thể có với n node.

**Solution:** Đây là một vấn đề của Dynamic Programming. Mình sẽ trình bày chi tiết khi viết tới chương này.

### Problem-54
Đưa ra các con trỏ tới hai node trong cây tìm kiếm nhị phân, hãy tìm tổ tiên chung thấp nhất (LCA). Giả sử rằng cả hai giá trị đã tồn tại trong cây.

**Solution:**
Ý tưởng chính của giải pháp là: trong khi duyệt BST từ gốc xuống dưới, node đầu tiên mà chúng ta gặp phải với giá trị nằm trong khoảng từ α đến β, tức là α < node → dữ liệu < β, là Tổ tiên chung nhỏ nhất (LCA) của α và β (trong đó α < β).
Vì vậy, chỉ cần duyệt qua BST theo thứ tự trước và nếu chúng ta tìm thấy một node có giá trị nằm giữa α và β, thì node đó là LCA.
Nếu giá trị của nó lớn hơn cả α và β thì LCA nằm ở phía bên trái của node và nếu giá trị của nó nhỏ hơn cả a và β thì LCA nằm ở phía bên phải.

![image.png](https://images.viblo.asia/7a5e6819-6214-4695-985d-9b7a7ad1cda1.png)

```
	public BinarySearchTreeNode LCA(BinarySearchTreeNode root,
									BinarySearchTreeNode a,
									BinarySearchTreeNode b){
		if(root == null){
			return root;
		}
		if(root == a || root == b){
			return root;
		}
		if (Math.max(a.getData(), b.getData()) < root.getData()) {
			return LCA(root.getLeft(), a, b);
		} else if (Math.min(a.getData(), b.getData()) > root.getData()) {
			return LCA(root.getRight(), a, b);
		} else {
			return root;
		}
	}
```

Time Complexity: O(n). Space Complexity: O(n), đối với cây nghiêng.

### Problem-55
Đưa ra thuật toán kiểm tra xem cây nhị phân đã cho có phải là BST hay không.

**Solution:** Hãy xem xét chương trình đơn giản dưới đây, đối với mỗi node, hãy kiểm tra xem node bên trái của nó có nhỏ hơn không và kiểm tra xem node bên phải có lớn hơn không.
```
	public boolean isBST(BinaryTreeNode root){
		if (root == null) {
			return false;
		}
		if(root.getLeft() != null && root.getLeft().getData() > root.getData()){
			return false;
		}
		if(root.getRight() != null && root.getRight().getData() < root.getData()){
			return false;
		}
		if(!isBST(root.getLeft()) || !isBST(root.getRight())){
			return false;
		}
		return true;
	}
```

**Cách tiếp cận này là sai** vì điều này sẽ trả về true cho cây nhị phân bên dưới. Chỉ kiểm tra tại node hiện tại là không đủ.

![image.png](https://images.viblo.asia/2f8da455-d176-4e5f-a25f-526c25d53573.png)

### Problem-56
Chúng ta có thể nghĩ đến việc có được thuật toán chính xác không?

**Solution:** Đối với mỗi node, hãy kiểm tra xem giá trị lớn nhất trong cây con bên trái có nhỏ hơn dữ liệu node hiện tại và giá trị nhỏ nhất trong cây con bên phải có lớn hơn dữ liệu node hay không.

```
	public boolean isBST(BinaryTreeNode root){
		if (root == null) {
			return false;
		}
		if(root.getLeft() != null && findMax(root.getLeft()) > root.getData()){
			return false;
		}
		if(root.getRight() != null && findMin(root.getRight()) < root.getData()){
			return false;
		}
		if(!isBST(root.getLeft()) || !isBST(root.getRight())){
			return false;
		}
		return true;
	}
```

Giả sử rằng chúng ta có các hàm trợ giúp FindMin() và FindMax() trả về giá trị số nguyên tối thiểu hoặc tối đa từ một cây không trống.
Time Complexity: O(n2). Space Complexity: O(n).

### Problem-57
Chúng ta có thể cải thiện độ phức tạp của Problem-56 không?

**Solution: Yes.** Một giải pháp tốt hơn là chỉ xem xét từng node một lần.
Mẹo nhỏ là viết một hàm IsBST(BinaryTreeNode root, int min, int max) đi qua cây để theo dõi các giá trị tối thiểu và tối đa được phép thu hẹp khi nó di chuyển, chỉ xem xét mỗi node một lần.
Các giá trị ban đầu cho min và max phải là INT_MIN và INT_MAX — chúng thu hẹp từ đó.

```
Initial call: isBST(root, Integer.MIN_VALUE, Integer.MAX_VALUE);
public boolean isBST(BinaryTreeNode root, int min, int max){
    if(root == null){
        return true;
    }
    return (root.getData() > min && root.getData() < max &&
            isBST(root.getLeft(), min, root.getData()) &&
            isBST(root.getRight(), root.getData(), max));
}
```

Time Complexity: O(n). Space Complexity: O(n), cho cây nghiêng.

### Problem-58
Chúng ta có thể cải thiện hơn nữa độ phức tạp của Problem-56 không?

**Solution:** Có, bằng cách sử dụng inorder traversal.
Ý tưởng đằng sau giải pháp này là việc duyệt inorder traversal của BST tạo ra các danh sách được sắp xếp.
Trong khi duyệt BST theo thứ tự, tại mỗi node, hãy kiểm tra điều kiện rằng giá trị khóa của nó phải lớn hơn giá trị khóa của node đã truy cập trước đó.
Ngoài ra, chúng ta cần khởi tạo prev với giá trị số nguyên nhỏ nhất có thể (giả sử Integer.MIN_VALUE).

```
	private int prev = Integer.MIN_VALUE;
	public boolean isBST(BinarySearchTreeNode root){
				if(root == null){
			return true;
		}
				if(!isBST(root.getLeft())){
					return true;
				}
				if(root.getData() < prev){
					return false;
				}
				prev = root.getData();
				return isBST(root.getRight());
	}
```

Time Complexity: O(n). Space Complexity: O(n), cho cây nghiêng.

### Problem-59
Đưa ra thuật toán chuyển BST sang circular DLL(Circular Doubly Link List) hình tròn với độ phức tạp không gian O(1).

**Solution:**
* Con trỏ trái và phải trong các node sẽ được sử dụng làm con trỏ trước và sau tương ứng trong Danh sách liên kết vòng được chuyển đổi.
* Thứ tự của các node trong Danh sách phải giống như trong Inorder cho Cây nhị phân đã cho.
* node đầu tiên của Inorder traversal phải là node đầu của Circular List.

![image.png](https://images.viblo.asia/c5c513a6-ec67-464c-8403-d15a1f19978c.png)

```
// Java Program to convert a Binary Tree to a
// Circular Doubly Linked List

// Node class represents a Node of a Tree
class Node {
    int val;
    Node left, right;

    public Node(int val)
    {
        this.val = val;
        left = right = null;
    }
}

// A class to represent a tree
class Tree {
    Node root;
    public Tree() { root = null; }

    // concatenate both the lists and returns the head
    // of the List
    public Node concatenate(Node leftList, Node rightList)
    {
        // If either of the list is empty, then
        // return the other list
        if (leftList == null)
            return rightList;
        if (rightList == null)
            return leftList;

        // Store the last Node of left List
        Node leftLast = leftList.left;

        // Store the last Node of right List
        Node rightLast = rightList.left;

        // Connect the last node of Left List
        // with the first Node of the right List
        leftLast.right = rightList;
        rightList.left = leftLast;

        // left of first node refers to
        // the last node in the list
        leftList.left = rightLast;

        // Right of last node refers to the first
        // node of the List
        rightLast.right = leftList;

        // Return the Head of the List
        return leftList;
    }

    // Method converts a tree to a circular
    // Link List and then returns the head
    // of the Link List
    public Node bTreeToCList(Node root)
    {
        if (root == null)
            return null;

        // Recursively convert left and right subtrees
        Node left = bTreeToCList(root.left);
        Node right = bTreeToCList(root.right);

        // Make a circular linked list of single node
        // (or root). To do so, make the right and
        // left pointers of this node point to itself
        root.left = root.right = root;

        // Step 1 (concatenate the left list with the list
        //         with single node, i.e., current node)
        // Step 2 (concatenate the returned list with the
        //         right List)
        return concatenate(concatenate(left, root), right);
    }

    // Display Circular Link List
    public void display(Node head)
    {
        System.out.println("Circular Linked List is :");
        Node itr = head;
        do {
            System.out.print(itr.val + " ");
            itr = itr.right;
        } while (itr != head);
        System.out.println();
    }
}

// Driver Code
class Main {
    public static void main(String args[])
    {
        // Build the tree
        Tree tree = new Tree();
        tree.root = new Node(10);
        tree.root.left = new Node(12);
        tree.root.right = new Node(15);
        tree.root.left.left = new Node(25);
        tree.root.left.right = new Node(30);
        tree.root.right.left = new Node(36);

        // head refers to the head of the Link List
        Node head = tree.bTreeToCList(tree.root);

        // Display the Circular LinkedList
        tree.display(head);
    }
}
```

Bài này trong sách tác giả viết hơi ngắn gọn nên mình có tham khảo code và thuật toán [ở đây](https://www.geeksforgeeks.org/convert-a-binary-tree-to-a-circular-doubly-link-list/)

### Problem-60
Cho một danh sách liên kết kép(doubly linked list) đã được sắp xếp, hãy viết thuật toán chuyển đổi nó thành cây tìm kiếm nhị phân cân bằng.

**Solution:** Tìm độ dài danh sách và xây dựng cây từ dưới lên.

```
	public BinarySearchTreeNode sortedList2BST(ListNode head){
		int len = 0;
		ListNode currentNode = head;
		while(currentNode != null){
			len++;
			currentNode = currentNode.getNext();
		}
		return construct(head, 0, len - 1);
	}

	public BinarySearchTreeNode construct(ListNode head, int start, int end){
		if(start > end){
			return null;
		}
		int mid = start + (end - start)/2;
		BinarySearchTreeNode left = construct(head, start, mid - 1);
		BinarySearchTreeNode root = new BinarySearchTreeNode(head.getData());
		root.setLeft(left);
		if(head.getNext() != null){
			head.setData(head.getNext().getData());
			head.setNext(head.getNext().getNext());
		}
		root.setRight(construct(head, mid + 1, end));
		return root;
	}
```

Time Complexity: 2T(n/2) + O(n) [Cho việc tìm node giữa] = O(nlogn).

### Problem-61
Cho một mảng đã được sắp xếp, hãy đưa ra thuật toán để chuyển đổi mảng thành BST.

**Solution:** Nếu chúng ta phải chọn một phần tử mảng làm gốc của một BST cân bằng, chúng ta nên chọn phần tử nào? Gốc của BST cân bằng phải là phần tử ở giữa từ mảng đã sắp xếp.
chúng ta sẽ chọn phần tử ở giữa từ mảng đã sắp xếp trong mỗi lần lặp.
Sau đó, chúng ta tạo một node trong cây được khởi tạo với phần tử này.
Sau khi phần tử được chọn, phần tử còn lại là gì? Bạn có thể xác định các vấn đề phụ trong vấn đề không? Có hai mảng còn lại — mảng bên trái và mảng bên phải.

Hai mảng này là các vấn đề con của vấn đề ban đầu, vì cả hai đều được sắp xếp.
Hơn nữa, chúng là các cây con của node con trái và phải của node hiện tại.

Mã bên dưới tạo BST cân bằng từ mảng đã sắp xếp trong thời gian O(n) (n là số phần tử trong mảng).
So sánh mức độ tương tự của mã với thuật toán tìm kiếm nhị phân.
Cả hai đều đang sử dụng phương pháp chia để trị.

```
	public BinaryTreeNode buildBST(int A[], int left, int right){
		BinaryTreeNode newNode;
		if(left > right){
			return null;
		}
		newNode = new BinaryTreeNode();
		if(left == right){
			newNode.setData(A[left]);
			newNode.setLeft(null);
			newNode.setRight(null);
		} else {
			int mid = left + (right - left)/2;
			newNode.setData(A[mid]);
			newNode.setLeft(buildBST(A, left, mid - 1));
			newNode.setRight(buildBST(A, mid + 1, right));
		}
		return newNode;
	}
```', '2023-02-11T17:13:25.000000Z', '2023-02-26T15:00:16.000000Z', '2023-02-11T17:13:24.000000Z'),
	('Thực hành setup cụm kafka trên AWS EC2 Phần 2:', 'MkNLrOj8VgA', '11', 'unlisted', 'https://images.viblo.asia/e6e10c17-c8e2-4949-a7da-8641b16b9909.png', 'Tác giả: https://www.facebook.com/lang.thinh.146/
Source: https://github.com/quocthinh861/kafka-zookeeper-cluster.git
<img loading="lazy" data-attachment-id="863" data-permalink="https://normanlimxk.com/kafka-ec2/" data-orig-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png" data-orig-size="1288,471" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&q...', '> Tác giả: https://www.facebook.com/lang.thinh.146/
>
> Source: https://github.com/quocthinh861/kafka-zookeeper-cluster.git
>
<img loading="lazy" data-attachment-id="863" data-permalink="https://normanlimxk.com/kafka-ec2/" data-orig-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png" data-orig-size="1288,471" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="kafka-ec2" data-image-description="" data-image-caption="" data-medium-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=300" data-large-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=1024" src="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=1024" alt="" class="wp-image-863" width="768" height="281" srcset="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=1024 1024w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=768 768w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=150 150w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=300 300w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png 1288w" sizes="(max-width: 768px) 100vw, 768px">

Ở bài viết trước, chúng ta đã setup xong cụm zookeeper bao gồm 3 servers chạy trên 3 AZ khác nhau, bài viết này sẽ tiếp tục tạo thêm 3 con trên 3 AZ còn lại để tạo cụm boostrap server nhé

# Kiến trúc Kafka
Nói sơ qua một tí, Kafka sử dụng Zookeeper để gửi các message đến các server (hay còn được gọi là broker) thông qua topic. Các topic này sẽ có số bản sao (replication factor) và sẽ được phân tán trên khắp broker. Trong phạm vi bài lab này, mô hình của chúng ta sẽ như sau:

![image.png](https://images.viblo.asia/e6e10c17-c8e2-4949-a7da-8641b16b9909.png)

Có thể thấy rằng chúng ta có 3 broker, với cách setup như thế này nếu trong tính huống 1 con broker bị shutdow thì dữ liệu của chúng ta tại thời điểm đó vẫn được bảo toàn, nhờ vào cơ chế sao lưu của kafka (N-1 brokers can be down, if N is your default topic replication factor). Dữ liệu được phân tán đều trên cụm, có nghĩa ít bộ nhớ được sử dụng hơn trên từng broker nhưng vẫn có thể bảo toàn tính khả dụng của dữ liệu

# Cấu hình Kafka
Để cấu hình cho Kafka thì có rất nhiều setting cho nó, việc setup sao cho phù hợp phụ thuộc vào hạ tầng của bạn. Bài viết này chủ yếu sử dụng các setting mặc định cung cấp bởi Kafka. Bạn có thể đọc file cấu hình Kafka tại [đây](https://github.com/quocthinh861/kafka-zookeeper-cluster/blob/main/kafka/server.properties). Chú ý chúng ta chỉ ra đường dẫn sao lưu dữ liệu và chỉ ra cụm zookeeper đã cài đặt ở [bài viết trước](https://viblo.asia/p/thuc-hanh-setup-cum-kafka-tren-aws-ec2-EvbLbb9lLnk)
```
# The id of the broker. This must be set to a unique integer for each broker.
broker.id=1
...
# Zookeeper connection string (see zookeeper docs for details).
# This is a comma separated host:port pairs, each corresponding to a zk
# server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002".
# You can also append an optional chroot string to the urls to specify the
# root directory for all kafka znodes.
zookeeper.connect=zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka
```

# Setup Kafka
Trước tiên mình sẽ setup chỉ với 1 server chạy kafka. Đầu tiên các bạn tạo ra 1 instance với AIM đã được tạo sẵn ở bài trước, đặt tên là `My Kafka 1`, với bài viết trước mình đã tạo 3 server Zookeeper trên 3 subnet khác nhau, với instance này các bạn chọn 1 trong các subnet còn lại, trong ví dụ của mình, mình thiết lập private ip cho nó là `192.168.1.119` (chú ý địa chỉ ip này chính là địa chỉ ip mà các bạn đã set trong bài viết trước `/etc/hosts` lúc đầu nha)

![image.png](https://images.viblo.asia/dfd6c3b6-05de-412d-98f5-b434ba1f957b.png)

SSH vào instance, tại đây các bạn đã có sẵn thư mục /kafka với tất cả setup đã được thiết lập sẵn. Để chạy Kafka trước tiên nhìn vào file setting cho nó[ ở đây ](https://github.com/quocthinh861/kafka-zookeeper-cluster/blob/main/setup/setup-6-kafka-single.sh). Có rất nhiều thông số cấu hình, mình muốn tập trung vào một số thông số quan trọng sau đây:

Với mỗi Kafka server cần có 1 id riêng biệt `broker.id=1`

`log.dirs=/data/kafka` chỉ định nên lưu dữ liệu log

`min.insync.replicas=2 `vì chúng ta chỉ có 1 kafka server nên các bạn sửa lại thành 1 nhé (sửa lại bằng 2 khi ở phía dưới bài viết)

`zookeeper.connect=zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka` đây là chuỗi kết nối cụm Zookeeper đã tạo, chú ý chúng ta thêm `/kafka` ở phía cuối để Zookeeper lưu tất cả dữ liệu cụm kafka ở một thư mục riêng có tên là kafka cho dễ quản lý nha

Bước tiếp theo gắn file setting này thay thế file setting mặc định

```
# edit kafka configuration
rm config/server.properties
nano config/server.properties
```

Chạy thử xem sao `bin/kafka-server-start.sh config/server.properties`.

![image.png](https://images.viblo.asia/199eaf02-f881-4d10-bdfe-1e5ac096932e.png)

Đến đây cũng như bài viết trước, mình sẽ biến nó thành service để chạy ngầm, file script có nội dung ở [đây](https://github.com/quocthinh861/kafka-zookeeper-cluster/blob/main/kafka/kafka)

```
# Install Kafka boot scripts
sudo nano /etc/init.d/kafka
sudo chmod +x /etc/init.d/kafka
sudo chown root:root /etc/init.d/kafka
# you can safely ignore the warning
sudo update-rc.d kafka defaults
```

Sau đó chúng ta có thể tắt và khởi động như 1 service
```
# start kafka
sudo service kafka start
```

Để xác định service đang chạy, các bạn dùng câu lệnh `nc -vz localhost 9092`

![image.png](https://images.viblo.asia/57d5f62a-827a-43e2-b38f-247137857439.png)

Chúng ta đã setup xong cụm 1 node Kafka rồi, để chạy thử vài câu lệnh xem cụm hoạt động tốt không nhé

Chúng ta tạo ra 1 topic trên server Kafka
```
# create a topic
bin/kafka-topics.sh --zookeeper zookeeper1:2181/kafka --create --topic first_topic --replication-factor 1 --partitions 3
```

Vào một trong các con Zookeeper chạy câu lệnh `bin/kafka-topics.sh --list --zookeeper localhost:2181 `, kết quả cho thấy topic được tạo ở trên đã được Zookeeper lưu lại 😘

![image.png](https://images.viblo.asia/cc0e3c6c-b2a3-444d-a3d3-67600dc6f706.png)

Vậy là đã hoàn thành xong việc setup cụm Kafka gồm 1 node rồi. Tiếp theo chỉ cần tạo AIM từ instance này và tạo thêm 2 instance trên 2 subnet còn lại giống bài viết trước thế là xong (chú ý file config các bạn sửa lại broker.id cho 2 instance lần lượt 2, 3) 😚Ở bài viết tiếp theo, mình sẽ thực hiện các thao tác gửi nhận dữ liệu trên cụm này nhé !!!', '2023-02-11T14:33:06.000000Z', '2023-02-27T01:31:04.000000Z', '2023-02-11T14:32:59.000000Z'),
	('[Series] Learn Go Day 2', 'Rk74a27AJeO', '1', 'unlisted', 'https://images.viblo.asia/62731dd2-f99f-4a30-95f5-2442ef3a5632.png', 'Giới thiệu
Hello everyone, chúng ta tiếp tục học Go ngày 2 nhé. Let''s go!!!

Nội dung
Pointers
Pointer là một biến chứa địa chỉ của một vùng nhớ trong bộ nhớ. Thay vì lưu trực tiếp giá trị vào biến, ta có thể lưu trữ địa chỉ của giá trị đó và sử dụng con trỏ để truy cập đến giá trị đó. Việc sử dụng con trỏ trong Go có thể giúp cải thiện hiệu suất và tiết kiệm bộ nhớ so với việc sao chép dữ liệu...', '## Giới thiệu
Hello everyone, chúng ta tiếp tục học Go ngày 2 nhé. Let''s go!!!

## Nội dung
### Pointers
Pointer là một biến chứa địa chỉ của một vùng nhớ trong bộ nhớ. Thay vì lưu trực tiếp giá trị vào biến, ta có thể lưu trữ địa chỉ của giá trị đó và sử dụng con trỏ để truy cập đến giá trị đó. Việc sử dụng con trỏ trong Go có thể giúp cải thiện hiệu suất và tiết kiệm bộ nhớ so với việc sao chép dữ liệu giữa các biến.

Để tạo một con trỏ, bạn sử dụng toán tử **"&"** để lấy địa chỉ của một biến, và toán tử **"*"** để truy cập giá trị tại địa chỉ đó.

cú pháp:

* Toán tử **"&"**:
    ```go
    i := 42
    p = &i
    ```
* Toán tử **"*"**:
    ```go
    g := *p
    ```

Ví dụ:
```go
import "fmt"

func main() {
	i, j := 42, 2701

	p := &i         // point trỏ tới địa chỉ ô nhớ của i
	fmt.Println(*p) // kết quả => 42
	*p = 21         // gán giá trị vào ô nhớ
	fmt.Println(i)  // kết quả => 21

	p = &j         // gán point trỏ tới địa chỉ ô nhớ của j
	*p = *p / 37   // gán giá trị vào ô nhớ
	fmt.Println(j) // kết quả => 73
}
```

### Structs
Struct là một kiểu dữ liệu (composite data type) cho phép bạn định nghĩa một tập hợp các trường (fields) có kiểu dữ liệu khác nhau. Nó giúp bạn tổ chức và lưu trữ các dữ liệu có liên quan với nhau trong cùng một đối tượng.
```go
type Vertex struct {
	X int
	Y int
}

func main() {
	fmt.Println(Vertex{1, 2})
}
```

Chúng ta có thể tạo một đối tượng **Vertex** bằng cách gán giá trị cho các trường dữ liệu của struct.
```go
vertex := Vertex{
  Y: 100,
  X: 200,
}
```

Chúng ta có thể truy cập và gán giá trị cho các trường dữ liệu của struct bằng cách sử dụng toán tử **"."**.
```go
vertex.Y = 200
vertex.X = 300
```

Chúng ta có thể truy cập và sửa đổi nội dung của struct bằng cách sử dụng Pointer.
```go
v := Vertex{1, 2}
p := &v
p.X = 400
```

### Arrays
Một mảng được khai báo bằng cách chỉ định loại dữ liệu được lưu trữ và độ dài của mảng.

Cú pháp:
```go
var <name> [lenght]<type>
```

ví dụ:  Tạo mảng a có chiều dài là 10 với các phần tử kiểu int.

```go
var a [10]int
```
> Lưu ý: Một khi khai báo, chiều dài và kiểu dữ liệu của mảng thì không thể thay đổi. Nếu muốn thay đổi chiều dài, phải tạo mảng mới và sao chép dữ liệu từ mảng cũ.


####  Zero value
Khi khai báo một mảng mà không gán giá trị, toàn bộ phần tử sẽ được gán giá trị mặc định theo kiểu dữ liệu (int = 0, string = "").

Ví dụ: mảng [5]int sẽ có tất cả các phần tử có giá trị 0.

![init-array.png](https://images.viblo.asia/43ae4cf7-5615-475b-96a2-06c20c76af9e.png)

####  Literal
```go
array := [5]int{10, 20, 30, 40, 50}
```

####  Calculating Size
Nếu độ dài được cho là **"..."**, Go sẽ xác định độ dài của mảng dựa trên số phần tử được khởi tạo.
```go
array := [...]int{10, 20, 30, 40, 50}
```

#### Specific elements
Nếu bạn biết độ dài của mảng mình cần, nhưng chỉ khởi tạo các phần tử cụ thể, bạn có thể sử dụng cú pháp này.
```go
array := [5]int{1: 10, 2: 20}
```

#### Pointer elements
Bạn có thể có một mảng các con trỏ. Bạn sử dụng toán tử * để truy cập giá trị mỗi con trỏ mà phần tử trỏ tới.
```go
array := [5]*int{0: new(int), 1: new(int)}

*array[0] = 10
*array[1] = 20
```
Các giá trị của mảng được khai báo trong **array** trông giống như hình dưới đây:
![Screenshot 2023-02-11 at 18.13.11.png](https://images.viblo.asia/ee1cca29-ce19-4dcf-b8cd-e7b237cb392d.png)

Một mảng là một giá trị trong Go. Điều này có nghĩa là bạn có thể sử dụng nó trong một thao tác gán. Do đó, một mảng có thể được gán cho các mảng khác cùng loại và cùng độ dài.
```go
var array1 [5]int
array2 := [5]int{1, 2, 3, 4, 5}
array1 = array2
```

Còn đối với Pointer thì khi chúng ta gán là gán các địa chỉ ô nhớ của con trỏ chứ không phải các giá trị mà con trỏ đang trỏ tới.
```go
var array1 [3]*string

array2 := [3]*string{new(string), new(string), new(string)}

*array2[0] = "Red"
*array2[1] = "Blue"
*array2[2] = "Green"

array1 = array2
```

Nó trông giống như hình dưới đây:
![Screenshot 2023-02-11 at 18.29.00.png](https://images.viblo.asia/62731dd2-f99f-4a30-95f5-2442ef3a5632.png)

#### Multidimensional array ( mảng đa chiều )
Multidimensional là một cấu trúc dữ liệu cho phép lưu trữ các phần tử dưới dạng bảng nhiều chiều. Mỗi phần tử trong mảng đa chiều được xác định bởi nhiều chỉ số được gọi là các chỉ mục.

```go
 // initialize
var array [4][2]int

// literal & initialize
array := [4][2]int{{10, 11}, {20, 21}, {30, 31}, {40, 41}}

// Declare & initialize outer array
array := [4][2]int{1: {20, 21}, 3: {40, 41}}

// Declare & initialize outer and inner array
array := [4][2]int{1: {0: 20}, 3: {1: 41}}
```
Giống như hình dưới đây:
![Screenshot 2023-02-11 at 18.46.12.png](https://images.viblo.asia/034ce08c-7d4b-445f-a409-8c501f6bbd9c.png)

#### Passing arrays between functions
Khi truyền một mảng giữa các hàm, có thể tốn nhiều bộ nhớ và ảnh hưởng đến hiệu suất. Mảng được truyền bằng cách sao chép toàn bộ mảng vào hàm với bất kể kích thước nào của nó.

```go
// Khai báo 1 mảng 8 megabytes.
var num [1e6]int

handleNum(num)

func handleNum(num [1e6]int) {
    ...
}
```

Khi gọi hàm **handleNum** với một mảng **8 megabytes**, toàn bộ mảng sẽ được sao chép và cấp phát trên ngăn xếp, tốn nhiều bộ nhớ và ảnh hưởng đến hiệu suất. Cách tốt hơn là truyền một con trỏ đến mảng và để chỉ sao chép **8 byte**.

```go
var num [1e6]int

handleNum(&num)

func handleNum(num *[1e6]int) {
    ...
}
```
##  Tổng kết
Vậy là sau 1 ngày mình đã học được:
* Pointers
* Structs
* Arrays

 Nếu có thắc mắc hoặc cần giải thích rõ thêm chỗ nào thì các bạn có thể comment ở dưới.
 Cám ơn các bạn đã theo dõi bài viết của mình. Chúc các bạn có 1 ngày vui vẻ. Tks', '2023-02-11T12:50:39.000000Z', '2023-02-28T01:41:04.000000Z', '2023-02-11T12:42:20.000000Z'),
	('Đừng dùng Heroku triển khai app NodeJS nữa! Hãy dùng nền tảng này...', 'Ny0VGEq0JPA', '2', 'unlisted', 'https://images.viblo.asia/914be8e6-d924-46ff-aa32-586ec482d142.png', 'Mở đầu
Khi đọc tiêu đề mọi người đừng tiếp nhận nó một cách quá nghiêm túc, mục đích của bài viết này mình muốn giới thiệu đến mọi người một nền tảng nữa có khả năng tương tự, thậm chí hơn một số chức năng của Heroku. Và một điều không kém quan trọng nữa là nền tảng này thì miễn phí khi sử dụng. Không tốn thêm thời gian lan man nữa, ngay sau đây mình sẽ giới thiệu với mọi người nền tảng này và ...', '# Mở đầu
Khi đọc tiêu đề mọi người đừng tiếp nhận nó một cách quá nghiêm túc, mục đích của bài viết này mình muốn giới thiệu đến mọi người một nền tảng nữa có khả năng tương tự, thậm chí hơn một số chức năng của Heroku. Và một điều không kém quan trọng nữa là nền tảng này thì miễn phí khi sử dụng. Không tốn thêm thời gian lan man nữa, ngay sau đây mình sẽ giới thiệu với mọi người nền tảng này và hướng dẫn cách triển khai **App NodeJS** lên trên nền tảng này.

# Bizfly App Engine là gì?
![image.png](https://images.viblo.asia/acd6d2be-ab95-43a1-a70a-662cec82fcac.png)

**Bizfly App Engine** là nền tảng mình và team mới phát triển trong thời gian gần đây, nền tảng này cho phép bạn triển khai các ứng dụng được viết bằng nhiều ngôn ngữ khác nhau như: Python, Golang, JavaScript, Ruby, C#, Java,... một cách nhanh chóng, trung bình chỉ mất vài phút để triển khai. Hệ thống sẽ tự nhận diện ngôn ngữ và tiến hành xây dựng cho phù hợp.

Nền tảng này còn giúp đơn giản hóa quá trình vận hành ứng dụng như: cập nhật phiên bản mới, restart, stop, rollback,...

Hy vọng mọi người sẽ thích sản phẩm này và sử dụng thường xuyên!

Document sản phẩm: https://docs.bizflycloud.vn/app_engine/


# Chuẩn bị

## Chuẩn bị ứng dụng
Để triển khai ứng dụng thì chắc chắn các bạn cần phải có Source Code rồi đúng không nào 😁. Các bạn có thể dùng source code của mình luôn hoặc cùng code mà bạn có sẵn.

Code trong bài này mình sẽ dùng ở đây: https://github.com/bizflycloud/app-engine-nodejs-sample

Cùng xem qua một chút về code này. Nội dung file **server.js**:
```javascript
const express = require(''express'');
const port = process.env.PORT || 8080;

const app = express();

app.get(''/'', (request, response) => {
    response.send(`<!DOCTYPE html>
<html>
  <head>
    <title>BizflyCloud App Engine</title>
  </head>
  <body>
    <img style="display: block; margin-left: auto; margin-right: auto; width: 50%;" src="https://techvccloud.mediacdn.vn/2018/12/5/logofacebook-1543996079655547158445-crop-1543996085792308014951.png"></img>
  </body>
</html>`);
});

app.listen(port);
```

Ứng dụng này đơn giản mở một web app lắng nghe tại cổng có giá trị là giá trị của biến môi trường **PORT**, nếu biến này không được khai báo sẽ sử dụng cổng 8080.

Khi người dùng truy cập vào ứng dụng này, server sẽ trả về 1 đoạn HTML để trình duyệt người dùng hiển thị ra.

Tiếp theo là nội dung của **packages.json**. Trong này ta sẽ định nghĩa các **dependencies** và **scripts** lần lượt là những thành phần phụ thuộc và câu lệnh mà ứng dụng sẽ chạy.
```json
{
    "author": "BizflyCloud App Engine",
    "dependencies": {
        "express": "^4.18.1"
    },
    "description": "Sample Node.js Application using NPM",
    "license": "Apache-2.0",
    "name": "sample",
    "repository": {
        "type": "git",
        "url": "https://github.com/paketo-buildpacks/samples"
    },
    "scripts": {
        "start": "echo \"start\" && node server.js"
    },
    "version": "0.0.0"
}
```

Như vậy bạn đã hiểu ứng dụng này làm gì rồi đúng không, giờ chúng ta sẽ đến giai đoạn triển khai.

## Chuẩn bị tài khoản

Để triển khai ứng dụng lên App Engine của Bizflycloud thì bạn cần phải có tài khoản đã, việc này không quá khó khăn, mọi người tự thực hiện nhé:

Đăng ký tài khoản ở đây nhé: https://manage.bizflycloud.vn/register
![image.png](https://images.viblo.asia/e38e87e4-97d3-4a09-acb2-625eb31e2a35.png)

Sau khi đã có tài khoản bạn hãy tiến hành đăng nhập, bạn sẽ thấy dịch vụ App Engine ở thanh menu bên trái
![image.png](https://images.viblo.asia/76e2afe7-46e5-431e-9ac2-260c83e2b1e7.png)

# Triển khai ứng dụng
## Tạo App và Service

Các ứng dụng của các bạn triển khai trên **App Engine** mà liên quan đến nhau có thể được gộp vào cùng chung một **App**. Vậy nên đầu tiên ta cần tạo **App** trước. Ở đây mình sẽ tạo app có tên **example**. Sau khi tạo xong ta sẽ được đẩy vào trong app đó, ở đây mình tiếp tục chọn **tạo Service** để tạo thêm service mới phục vụ việc triển khai **App NodeJS**
![image.png](https://images.viblo.asia/c64bb92f-03a8-4d6c-a3f7-c9cd56d708c1.png)

Trong phần tạo service mình sẽ nhập vào các thông tin như ở GIF dưới:

![Screencast-2023-02-11-160238.gif](https://images.viblo.asia/6488884d-8fee-46b8-b24c-c73def55954d.gif)

* **Tên service**: Đây là tên của service bạn muốn triển khai, tên này sẽ được chọn làm path khi bạn tạo từ service thứ 2 trở đi.
* **Location**: Vị trí ứng dụng bạn sẽ được triển khai, nên chọn vị trí gần bạn nhất để giảm độ trễ. (Hiện tại bên mình đang hỗ trợ Hà Nội thôi, tương lai sẽ nhiều vị trí hơn 😁)

Trong phần thông tin triển khai, phần này sẽ chưa các thông tin về nguồn ứng dụng bạn sẽ triển khai.
* **Soure type:** Bạn có thể lựa chọn cách thức triển khai bằng image hoặc source code. Mình có source code được lưu trên git nên sẽ chọn **GIT**
* **Source URL**: Đường dẫn đến repo của bạn dạng **http:// hoặc https://** nhé.
* **Branch:** Nhánh mà bạn muốn triển khai code.
* **Chế độ Private**: Dành cho các repo dạng private. Repo mình đang triển khai là Public nên không cần tick.

Cấu hình ứng dụng là mục chứa các thông tin về hạ tầng và network bạn sẽ triển khai:
* **Cấu hình:** Đây là cấu hình của mỗi container chạy ứng dụng của bạn.
* **Replicas:** Số bản sao chạy với cấu hình bên trên.
* **Port:** Cổng mà dịch vụ bạn đang chạy
* **Loại ứng dụng:** Mỗi loại ứng dụng sẽ có cách thức đóng gói khác nhau, hãy chọn đúng loại ứng dụng bạn muốn triển khai. Để hiểu từng loại ứng dụng bạn cóp thể trỏ vào từng nút đó.

Sau khi đã nhập xong đầy đủ bạn chỉ cần ấn Xác nhận thông tin để triển khai ứng dụng ngay lập tức.

## Kết quả

Sau khi triển khai xong hệ thống sẽ trả về cho bạn một URL để truy cập dịch vụ như hình.

Bạn có thể truy cập thử tại đây: https://example-nnwpu.appengine.bfcplatform.vn/nodejs-npm

![image.png](https://images.viblo.asia/c2fe5abc-e0be-460c-8a13-8fc26b0afa36.png)

# Các thao tác vận hành
## Giám sát - Monitoring
Khi có hệ thống giám sát bạn có thể dễ dàng phát hiện sự bất thường của ứng dụng một cách nhanh chóng.

Hệ thống giám sát các thông số hạ tầng quan trọng như **CPU, Memory, Network và Disk I/O.**

![monitor-svc.gif](https://images.viblo.asia/e75ec14f-c8ab-41b7-af9d-0e60503809a9.gif)

## Nhật ký hoạt động - Logs
Logs được chia làm 2 loại: **Runtime Logs** và **Build Logs**
* Runtime Logs sẽ chứa logs trong quá trình hoạt động
* Build Logs sẽ chứa logs trong quá trình đóng gói - xây dựng ứng dụng

![image.png](https://images.viblo.asia/e0dfd785-77dd-447e-8076-6b2ec00f2c4e.png)

## Tự động mở rộng - AutoScale
Đây là tính năng giúp ứng dụng của bạn tự động mở rộng hạ tầng khi bị quá tải. Bạn có thể cấu hình số bản sao tối đa muốn tự động mở rộng và mức độ phần trăm CPU mà tính năng này sẽ được kích hoạt.
![image.png](https://images.viblo.asia/890662f7-a359-41e9-bd25-92f3623989ae.png)

# Kết
Cám ơn mọi người đã đọc đến tận đây, hy vọng mọi người sẽ dành thời gian để trải nghiệm sản phẩm này! Nếu có đóng góp gì hay muốn tính năng nào phát triển trong tương lai, bạn có thể comment xuống dưới bài viết này hoặc nhắn trực tiếp cho mình qua Telegram @HoangViet12. Mọi phản hồi của các bạn đều rất quý giá đối với mình.

Nếu thấy bài viết này hay hãy Up Vote và Follow mình để tiếp tục xem nhiều bài viết về Bizfly App Engine nữa nhé! 👋👋👋

Bài viết này nằm trong Series [BizflyCloud App Engine Tutorials](https://viblo.asia/s/bizflycloud-app-engine-tutorials-r1QLxnGr4Aw)', '2023-02-11T09:51:36.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-11T09:45:24.000000Z'),
	('Tổng quan về thuật toán và cấu trúc dữ liệu', 'W13VMgQWJY7', '3', 'unlisted', '', 'Trước khi đi chi tiết vào các nội dung chi tiết tiếp theo của khóa học, ta xem xét ví dụ sau:

Question :
>- Giả sử ta có một danh sách các cặp thông tin: (họ và tên, số điện thoại) dưới dạng: (t1,s1),(t2,s2),...,(tn,sn).
- Yêu cầu đặt ra là hãy viết một chương trình cho phép in ra "số điện thoại" khi nhập "họ và
tên" của một người bất kỳ.

Để giải bài toán này, chúng ta có thể sử dụng nhiều cá...', '<p>Trước khi đi chi tiết vào các nội dung chi tiết tiếp theo của khóa học, ta xem xét ví dụ sau:</p>

> Question :
>- Giả sử ta có một danh sách các cặp thông tin: (họ và tên, số điện thoại) dưới dạng: (t1,s1),(t2,s2),...,(tn,sn).
> - Yêu cầu đặt ra là hãy viết một chương trình cho phép in ra "số điện thoại" khi nhập "họ và
> tên" của một người bất kỳ.

<p>Để giải bài toán này, chúng ta có thể sử dụng nhiều cách thức như sau:

 * Một cách đơn giản và trực quan nhất mà chúng ta có thể nghĩ đến đó là duyệt lần lượt danh sách đã cho theo tên t1,t2,...tn cho tới khi tìm thấy tên đã chỉ định, thì sẽ tiến hành đối chiếu để lấy ra số điện thoại tương ứng của người này. Tuy nhiên, để duyệt qua toàn bộ một danh sách rất lớn sẽ tốn khá nhiều thời gian. Hãy thử tưởng tượng đây là chức năng của một chương trình tìm kiếm số của tổng đài điện thoại thì nó sẽ cực kỳ chậm, nhất là khi phải nhận đến hàng triệu truy vấn vào cùng một thời điểm thì rõ ràng điều này sẽ làm tắc nghẽn dịch vụ.
 * Một cách nhanh hơn, nếu trước đó danh mục điện thoại đã được sắp xếp theo thứ tự từ điển (dictionary order) đối với họ và tên, thì chúng ta có thể áp dụng một giải thuật tìm kiếm khác tốt hơn, như ta vẫn thường làm khi tra từ điển. Khi bạn tra từ điển, rõ ràng bạn sẽ không lật từng trang phải không? Bạn sẽ làm gì? Như tôi, tôi sẽ thường làm như thế này: Lật đến vị trí nào đó của từ điển, nghĩ xem từ mình cần tìm là trước hoặc sau trang này, sau đó sẽ lật tiếp ngẫu nhiên đến phía mà tôi nghĩ nó sẽ ở, rồi tiếp tục các bước như vừa làm cho tới khi tìm được từ mong muốn. Rõ ràng, dù chưa hiểu thuật toán là gì, bạn cũng có thể dễ dàng thấy cách này về mặt trực quan đã tốt hơn cách phía trước rất nhiều phải không?
  * Hoặc, cải tiến hơn nữa, trong từ điển còn có thêm một bảng mục lục để chỉ dẫn theo chữ cái đầu tiên của "Họ và tên",  thì chắc rằng khi tìm số điện thoại của "Nguyễn Văn Long" ta sẽ dễ dàng bỏ qua được các tên khác mà chữ đầu không phải là chữ Ng. Nhanh hơn rất nhiều nữa phải không?
> Note!!
>
> Trong ví dụ trên: Danh sách điện thoại là một dạng dữ liệu nó sẽ được tổ chức theo nhiều cách khác nhau cho từng trường hợp:
> * danh sách thông thường;
> * danh sách sắp xếp theo thú tự từ điển;
> * danh sách được sắp xếp và chỉ mục có mục lục.
>
> Đây là các "cấu trúc dữ liệu". Còn các cách thức thực hiện việc tra cứu theo từng dạng "cấu trúc dữ liệu" được gọi là "thuật toán" hay "giải thuật".

#### Thuật toán và cấu trúc dữ liệu
   Từ ví dụ trên ta có thể thấy giữa cấu trúc dữ liệu và giải thuật có mối quan hệ mật thiết. Có thể coi chúng như hình với bóng. Không thể nói tới cái này mà không nhắc tới cái kia. Niklaus Wirth đã đưa ra một công thức thể hiện khá rõ vai trò và mối liên hệ giữa cấu trúc dữ liệu và thuật toán:
> Note!!
>
> <div align="center">CHƯƠNG TRÌNH = THUẬT TOÁN + CẤU TRÚC DỮ LIỆU
>
> Programs = Algorithms + Data structures</div>

Một thuật toán giải bài toán bao giờ cũng thao tác trên một cách tổ chức dữ liệu (cấu trúc dữ liệu) cụ thể và các thao tác phải được cấu trúc dữ liệu đó hỗ trợ.
> Tip&Trick
>
> Sau này R. Kowalski còn phân tích chi tiết hơn công thức trên bằng cách đưa ra công thức: "Algorithms = Logic + Control", với ý nghĩa thuật toán gồm hai thành phần: thành phần logic xác định tri thức được dùng trong việc giải bài toán và thành phần điều khiển xác định các chiến lược giải toán theo tri thức được sử dụng. Thành phần logic xác định ý nghĩa của thuật toán, còn thành phần điều khiển liên quan đến tính hiệu quả của thuật toán. Tính hiệu quả có thể được cải thiện bằng cách cải thiện phần điều khiển mà không thay đổi logic của thuật toán.

Khi tổ chức dữ liệu cho bài toán thay đổi thì thuật toán cũng phải thay đổi theo để phù hợp với cách tổ chức dữ liệu mới. Chẳng hạn như ví dụ trên, một danh sách bất kỳ sẽ phải xử lý khác một danh sách có thứ tự và một danh sách có thứ tự lại khác một danh sách đã được đánh chỉ số. Trong quá trình xây dựng, hoàn thiện thuật toán cũng sẽ gợi mở cho chúng ta cách tổ chức dữ liệu phù hợp với thuật toán và tiết kiệm tài nguyên của hệ thống. Quá trình giải một bài toán trên máy tính là một quá trình hoàn thiện dần cách tổ chức dữ liệu và thuật toán để tăng hiệu quả cho nó.

Có thể, đôi lúc, khi nói tới việc giải quyết bài toán trên máy tính, chúng ta chỉ chú ý đến giải thuật hay thuật toán (algorithms). Nhưng, xét cho cùng, giải thuật chỉ phản ánh các phép xử lý, còn đối tượng để xử lý trên máy tính điện tử, chính là dữ liệu (data) chúng biểu diễn các thông tin cần thiết cho bài toán: các dữ kiện đưa vào, các kết quả trung gian... Không thể nói tới giải thuật mà không nghĩ tới: giải thuật đó được tác động trên dữ liệu nào, còn khi xét tới dữ liệu thì cũng phải hiểu: dữ liệu ấy cần được tác động giải thuật gì để đưa tới kết quả mong muốn. Bản thân các phần tử của dữ liệu thường có mối quan hệ với nhau, ngoài ra nếu lại biết "tổ chức" theo các cấu trúc thích hợp thì việc thực hiện các phép xử lý trên các dữ liệu sẽ càng thuận lợi hơn, đạt hiệu quả cao hơn. Với một cấu trúc dữ liệu đã chọn ta sẽ có giải thuật xử lý tương ứng. Cấu trúc dữ liệu thay đổi, giải thuật cũng thay đổi theo.
> Note
>
> Tóm lại, để giải quyết các bài toán trong lập trình chúng ta cần sử dụng các thuật toán để tác động lên các cấu trúc dữ liệu phù hợp. Thuật toán và cấu trúc dữ liệu là hai thành phần không thể tách rời để xây dựng chương trình.
> Đây là trọng tâm của khoá học này!

Trong bài tiếp theo, chúng ta sẽ đi chi tiết về hai khái niệm cấu trúc dữ liệu và thuật toán, cũng như các vấn đề đối với hai đối tượng này.
</p>', '2023-02-11T08:47:18.000000Z', '2023-02-25T07:16:04.000000Z', '2023-02-11T08:47:49.000000Z'),
	('Làm chức năng đăng nhập bằng QR Code giống Zalo', 'vlZL99j8LQK', '4', 'unlisted', 'https://images.viblo.asia/8eaec524-5115-448d-9c1b-5eb60af3cc89.png', 'Mở đầu
- Một chức năng khá tiện cho các trường hợp quên mật khẩu nhưng vẫn còn session trên điện thoại.
- Với đức tính thích tìm tòi, nghịp ngợm chàng sinh viên tên Hoàng đã mở F12 và sau đó ....... Có bài viết này 😂

1. Luồng hoạt động

1. Đầu tiên khi vào trang chủ zalo phiên bản web id.zalo.me trình duyệt gửi một request đến https://id.zalo.me/account/authen?a=qr&t=1 và response trả về có dạ...', '# Mở đầu
- Một chức năng khá tiện cho các trường hợp quên mật khẩu nhưng vẫn còn session trên điện thoại.
- Với đức tính thích tìm tòi, nghịp ngợm chàng sinh viên tên Hoàng đã mở F12 và sau đó ....... Có bài viết này 😂

![image.png](https://images.viblo.asia/32c38645-dad1-4b31-8dce-37272b1d44f0.png)

# 1. Luồng hoạt động

![image.png](https://images.viblo.asia/f43663f3-dec4-47fa-94cf-9d69bfba7839.png)

1. Đầu tiên khi vào trang chủ zalo phiên bản web `id.zalo.me` trình duyệt gửi một request đến `https://id.zalo.me/account/authen?a=qr&t=1` và response trả về có dạng

```
{
    "code": "A", // Dùng để nhận dạng trình duyệt đang đăng nhập
    "image: "B", // Ảnh qrcode dưới dạng base64
    "token": "C" // Nội dung trong QRCode
}
```

>  Vấn đề đầu tiên: Làm sao nhận dạng được trình duyệt để khi điện thoại quét QR Code thành công mình còn thực hiện các thao tác như xác nhận thông tin, cấp token và chuyển hướng nó đến trang chủ.
>

2. Tiếp theo trình duyệt thực hiện request thứ 2 đến `https://id.zalo.me/account/authen?a=qr&t=2` với `code` gửi kèm trong body.

![image.png](https://images.viblo.asia/e8b73168-ee92-469a-b78c-aaa7cce14cb5.png)

Điểm khá thú vị request này sẽ mãi ở trạng thái `pending`. Nó chỉ success khi có người quét mã QR Code bằng ứng dụng zalo hoặc request timeout.

> Đến đây mọi chuyện đã sáng tỏ, zalo dựa vào "code"  để cấp mã nhận diện cho trình duyệt.

3. Khi người dùng quét QR Code trong ứng dụng, app sẽ gửi request lên zalo để xác nhận. Nếu thành công thì request ở bước 2 nào có `code` tương ứng với `token` sẽ trả về dữ liệu là tên người dùng.

![image.png](https://images.viblo.asia/8eaec524-5115-448d-9c1b-5eb60af3cc89.png)


4. Đến bước này có thể cho người dùng đăng nhập. Nhưng zalo vẫn bắt thêm 1 bước xác nhận trên điện thoại nữa. Trình duyệt sẽ hiển thị avatar và tên người dùng lên màn hình, và request tiếp đến `https://id.zalo.me/account/authen?a=qr&t=3` kèm với `code`

![image.png](https://images.viblo.asia/33e2eb71-62f1-4ecb-9366-bf5f5f190301.png)

> Vẫn giống như bước 2 request này vẫn sẽ pending cho đến khi người dùng xác nhận, từ chối trên điện thoại hoặc timeout.
> Nếu thành công người dùng sẽ được cấp token và chuyển hướng đến trang chủ

5. Nếu quá lâu không được quét, request ở bước 2, 3 sẽ timeout và yêu cầu người dùng tạo lại mã mới.

# 2. Thử triển khai demo nho nhỏ
Em sẽ dùng Expressjs để demo nhỏ nhé

1. Đầu tiên viết API sinh `code, qrcode, token`
``` js
app.post("/account/authen", (req,res) => {
  const { t } = req.query;

  if(t == "1"){
    // Sinh code và token random rồi lưu vào database
    // Tạo QRCode với token vừa tạo dạng base64
    return res.send({ code, qrcode, token })
  }
})
```

2. Viết giao diện và call API `/account/authen?t=1`  để render ảnh QR và lưu lại `code` (các bác tự viết nhé).

3. Tiếp tục viết API thứ 2 phía backend:

``` js
app.post("/account/authen", (req,res) => {
  const { t } = req.query;

  if(t == "1"){
    // Sinh code và token random rồi lưu vào database
    // Tao QRCode với token vừa tạo dạng base64
    return res.send({ code, qrcode, token })
  }

  if(t == "2"){
   // api này sẽ mãi pending cho đến khi nhận được event confirm của socket (như ảnh dưới)
    socket.on(`confirm-info-${req.body.code}`, ({ avatar, name}) => {
      return res.send({ avatar, name });
    });
  }
})
```

Sau đó request đến `/account/authen?t=2` kèm theo `code`.

> Việc giao tiếp giữa các controller có nhiều cách, ở đây em dùng socket cho nhanh.
>
![image.png](https://images.viblo.asia/2f6920dd-5f15-42ac-a5c8-f75f6c0e99cc.png)

4. Thay vì viết 1 con app để đọc QR rồi gửi request để confirm thì ta viết 1 api cho mobile rồi giả lập điện thoại quét bằng postman.
``` js
app.post("/mobile/authen", (req, res) => {
  const { t } = req.query

  if(t == 2){
    const { token, jwt } = req.body
    // Check jwt xem có hợp lệ không ?
    // Nếu có ? query database tìm code tương ứng với token
    // Hợp lệ emit socket
    io.emit(`comfirm-info-${code}`, { name: "Bùi Việt Hoàng" })

    res.send("OK")
  }
})
```

![image.png](https://images.viblo.asia/49df87a7-c9c5-4016-ae39-27cf5ee99d62.png)

5. Request `/account/authen?t=2` nhận được event của socket lập tức trả về tên của người dùng. Và tiếp tục request đến `/account/authen?t=3` để chờ người dùng xác nhận


![image.png](https://images.viblo.asia/1e34e1a4-7de1-44e1-99fb-5b4a9a1c62c4.png)

Cập nhật code backend
``` js
app.post("/account/authen", (req,res) => {
  const { t } = req.query;

  if(t == "1"){
    // Sinh code và token random rồi lưu vào database
    // Tao QRCode với token vừa tạo dạng base64
    return res.send({ code, qrcode, token })
  }

  if(t == "2"){
    // api này sẽ mãi pending cho đến khi nhận được event confirm của socket (như ảnh dưới)
    socket.on(`comfirm-info-${req.body.code}`, ({ avatar, name}) => {
      return res.send({ avatar, name });
    });
  }

  if(t == "3"){
    // api này sẽ mãi pending cho đến khi nhận được event confirm của socket
    socket.on(`comfirm-auth-${req.body.code}`, () => {
      // sinh token jwt và trả về cho trình duyệt web có thể đăng nhập
      return res.send({ jwt });
    });
  }
})
```

``` js
app.post("/mobile/authen", (req, res) => {
  const { t } = req.query

  if(t == 2){
    const { token, jwt } = req.body
    // Check jwt xem có hợp lệ không ?
    // Nếu có ? Query database tìm code tương ứng với token
    // Hợp lệ emit socket với code vừa query
    io.emit(`comfirm-info-${code}`, { name: "Bùi Việt Hoàng" })

    res.send("OK")
  }

  if(t == "3"){
    // Kiểm tra xác thực trên đt
    io.emit(`comfirm-auth-${code}`, {})
    res.send("OK")
  }
})
```

6. Nếu request `/account/authen?t=3`thành công chuyển hướng người dùng đến trang chủ
7. Xử lý timeout ta viết 1 middleware để xử lý.

``` js
app.use(function(req, res, next){
  res.setTimeout(30000, function(){
    console.log(''Mã qr hết hạn, vui lòng tạo mới.'');
      res.status(408).send();
  });

  next();
});
```

# 3. Kết
Nếu có gì sai sót mong nhận được góp ý từ các bác 😘😘', '2023-02-11T08:45:08.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-14T08:08:04.000000Z'),
	('Eloquent Performance: N+1 Query Problems', 'qPoL7zPkJvk', '5', 'unlisted', 'https://images.viblo.asia/b3429388-61a7-492d-ba30-eb5a34d5e06f.png', 'Eloquent performance is typically the main reason for slow Laravel projects. A big part of that is a so-called "N+1 Query Problem". In this article, I will show a few different examples of what to watch out for, including the cases when the problem is "hidden" in unexpected places in the code.

What is the N+1 Query Problem

In short, it''s when Laravel code runs too many database queries. It ha...', 'Eloquent performance is typically the main reason for slow Laravel projects. A big part of that is a so-called "N+1 Query Problem". In this article, I will show a few different examples of what to watch out for, including the cases when the problem is "hidden" in unexpected places in the code.

**What is the N+1 Query Problem**

In short, it''s when Laravel code runs too many database queries. It happens because Eloquent allows developers to write a readable syntax with models, without digging deeper into what "magic" is happening under the hood.

This is not only an Eloquent, or even Laravel, problem: it''s well-known in the dev industry. Why is it called "N+1"? Because, in the Eloquent case, it queries ONE row from the database, and then performs one more query for EACH related record. So, N queries, plus the record itself, total N+1.

To solve it, we need to query the related records upfront, and Eloquent allows us to do that easily, with so-called eager loading. But before we get to the solutions, let''s discuss the problems

**Case**. "Regular" N+1 Query.
This one can be taken directly from the official Laravel documentation:

```php
// app/Models/Book.php:
class Book extends Model
{
    public function author()
    {
        return $this->belongsTo(Author::class);
    }
}

// Then, in some Controller:
$books = Book::all();

foreach ($books as $book) {
    echo $book->author->name;
}
```

What happens here? The $book->author part will perform one extra DB query for every book, to get its author.

Look at the number of queries.
![example1.png](https://images.viblo.asia/b3429388-61a7-492d-ba30-eb5a34d5e06f.png)

As you can see, for 20 books, there are 21 queries, exactly N+1, where N = 20.

And yes, you get it right: if you have 100 books on the list, you will have 101 queries to the DB. Awful performance, although the code seemed "innocent", right.

The fix is to load the relationship upfront, immediately in the Controller, with the eager loading that I mentioned earlier:

```php
// Instead of:
$books = Book::all();

// You should do:
$books = Book::with(''author'')->get();
```

The result is much better - only 2 queries:
![example1-2.png](https://images.viblo.asia/811af405-5a04-44bc-a20d-8904769214f2.png)

When you use eager loading, Eloquent gets all the records into the array and launches ONE query to the related DB table, passing those IDs from that array. And then, whenever you call $book->author, it loads the result from the variable that is already in memory, no need to query the database again.', '2023-02-11T08:08:22.000000Z', '2023-02-28T02:22:05.000000Z', '2023-02-11T08:08:40.000000Z'),
	('Thực hành với Domain Driven Design (Phần 2)', 'RQqKLoaN57z', '6', 'unlisted', '', 'Chào mừng mọi người với phần 2 của series thực hành với DDD!

Xem lại Phần 1

API Get list meterials

- Controller

MaterialListGetController.php

- Application Service

MaterialListGetApplicationService.php

- Kết quả trả về của handle() mình sẽ định nghĩa 1 interface chung với method toArray()
IResult.php

- Infrastructure layer: Get data from DB

MaterialRepository.php

Trong bài viết lần nà...', 'Chào mừng mọi người với phần 2 của series thực hành với DDD!

[Xem lại Phần 1](https://viblo.asia/p/thuc-hanh-voi-domain-driven-design-phan-1-YWOZrVJPZQ0)

### API Get list meterials

- Controller

MaterialListGetController.php
```php
final class MaterialListGetController
{
    public function __invoke()
    {
        $service = new MaterialListGetApplicationService(
          new MaterialRepository()
        );

        $result = $service->handle();

        return response()->json($result->toArray());
    }
}
```

- Application Service

MaterialListGetApplicationService.php
```php
final class MaterialListGetApplicationService
{
    private IMaterialRepository $materialRepository;

    public function __construct(IMaterialRepository $materialRepository)
    {
        $this->materialRepository = $materialRepository;
    }

    public function handle(): IResult
    {
        $collection = $this->materialRepository->find();

        return new MaterialListResult($collection);
    }
}
```

- Kết quả trả về của handle() mình sẽ định nghĩa 1 interface chung với method toArray()
IResult.php
```php
interface IResult
{
    public function toArray(): array;
}
```

```php
final class MaterialListResult implements IResult
{
    /**
     * @var Material[]
     */
    private array $materials;

    // Định nghĩa response cho API ở implemented method này.
    public function toArray(): array
    {
        $data = [];

        foreach ($this->materials as $material) {
            $data[] = [
                ''code'' => $material->getCode()->getValue(),
                ''name'' => $material->getName()->getValue(),
                ''created'' => $material->getCreatedDate()->getValue(),
                ''modified'' => $material->getUpdatedDate()->getValue(),
            ];
        }

        return [
            ''data'' => $data,
        ];
    }
}
```

- Infrastructure layer: Get data from DB

MaterialRepository.php
```php
    public function find(): array
    {
        $sql = <<<SQL
SELECT
    *
FROM
    materials
ORDER BY
    code
SQL;
        $records = DB::select($sql);

        $result = [];

        // set object values
        foreach ($records as $record) {
            $entity = Material::create();
            $entity->setName(new MaterialName($record->name));
            $entity->setCode(new MaterialCode($record->code));
            $entity->setCreatedDate(new Date($record->created));
            $entity->setUpdatedDate(new Date($record->modified));

            $result[] = $entity;
        }

        return $result;
    }
```

Trong bài viết lần này mình đã đề cập qua những class và cách implement cho một API Get theo Domain Driven Design.
Hẹn gặp các bạn ở bài viết lần sau.', '2023-02-11T04:11:01.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-11T04:10:53.000000Z'),
	('Chapter 4: Understanding Git Branches', 'obA466XM4Kv', '7', 'unlisted', '', 'This chapter belong to Getting Started with Git: A Beginner''s Guide  Series

In this chapter, you will learn about Git branches, what they are, and why they are an essential part of the Git version control system. We will start by discussing the concept of branches in Git, what they are used for, and how they work. We will then move on to creating and managing branches, including working with b...', '*This chapter belong to [Getting Started with Git: A Beginner''s Guide](https://viblo.asia/s/getting-started-with-git-a-beginners-guide-x7Z4DE6oJnX)  Series*

In this chapter, you will learn about Git branches, what they are, and why they are an essential part of the Git version control system. We will start by discussing the concept of branches in Git, what they are used for, and how they work. We will then move on to creating and managing branches, including working with branches, merging, and deleting branches. Finally, we will go over advanced branch concepts, such as rebasing, fast-forward merging.

**What are Git Branches?**

Git branches are pointers that track the development of a particular feature or bug fix in your Git repository. A Git repository can contain many branches, each of which can be worked on independently from one another. This means that multiple developers can work on different features in parallel, without interfering with each other''s work.

**Creating a Branch**

To create a new branch, you use the git branch command followed by the name of the branch you want to create. For example, to create a new branch called “***feature1***”, you would run the following command:

```
$ git branch feature1
```

**Switching between Branches**

To switch between branches, you use the git checkout command followed by the name of the branch you want to switch to. For example, to switch to the “feature1” branch, you would run the following command:

```
$ git checkout feature1
```

**Merging Branches**

To merge one branch into another, you use the git merge command followed by the name of the branch you want to merge.

* Rebasing

    Rebasing is a Git command that allows you to take the changes from one branch and reapply them on top of another branch. It''s useful for keeping your branches up-to-date and for making sure that your branch contains only the changes that you need.

    ```
    $ git rebase <branch-name>
    ```

* Fast-Forward Merging

    Fast-forward merging is a way of merging branches in Git that keeps the branch history linear. When you perform a fast-forward merge, Git simply moves the branch pointer to the latest commit on the branch you''re merging.
    ```
    $ git merge <branch-name>
    ```

**Deleting Branches**

To delete a branch, you use the git branch command followed by the -d option followed by the name of the branch you want to delete. For example, to delete the “feature1” branch, you would run the following command:
```
$ git branch -d feature1
```

### Summary

In this chapter, we have covered the basics of Git branches, including what they are, how to create, switch between, merge, and delete branches. We also went over advanced concepts such as rebasing, fast-forward merging. By understanding these concepts, you will be able to use Git branches effectively in your projects and work more efficiently with Git.', '2023-02-11T04:06:33.000000Z', '2023-02-28T01:01:03.000000Z', '2023-02-11T04:06:27.000000Z'),
	('Chapter 3: Basic Git Commands and Workflow', 'MkNLrONOVgA', '8', 'unlisted', '', 'This chapter belong to Getting Started with Git: A Beginner''s Guide  Series

In this chapter, we will be diving into the basics of using Git, including how to use essential Git commands and the basic workflow of using Git. Before diving into the commands, it''s important to understand what Git is and what it does. Git is a distributed version control system, which means that it keeps track of ch...', '*This chapter belong to [Getting Started with Git: A Beginner''s Guide](https://viblo.asia/s/getting-started-with-git-a-beginners-guide-x7Z4DE6oJnX)  Series*

In this chapter, we will be diving into the basics of using Git, including how to use essential Git commands and the basic workflow of using Git. Before diving into the commands, it''s important to understand what Git is and what it does. Git is a distributed version control system, which means that it keeps track of changes made to files and directories over time. The changes are tracked by creating a repository, which is a central place to store all changes. The repository contains all the information about the current version of the files, including all the previous versions, making it easy to revert to an older version if needed.

In order to use Git, you''ll need to have it installed on your computer. Once installed, you can start using Git from the command line. To help you understand how Git works, we will go over some of the most commonly used Git commands.

### Git terms

* Working Area: This refers to the place where you do your day-to-day work. This is where you create, edit and save your files.
* Staging Area: Also known as the "Index", the staging area is a place where you can collect changes that you want to commit to the repository.
* Local Repository: The local repository is a place where you store the changes you make to your working area. It is stored in your computer and acts as a backup for your work.
* Remote Repository: This is a copy of your local repository stored on a remote server. This allows you to share your work with others and collaborate on projects.
* Commit: A commit is a saved version of your changes. When you commit changes, Git takes a snapshot of your working area and stores it in your local repository.
* Branch: A branch is a separate line of development in Git. You can create a new branch to work on a new feature or bug fix, and then merge the branch back into the main branch when you are done.

### Git Workflows
The basic Git workflow starts with creating a new repository, making changes to your files, and then committing those changes to your local repository. When you are ready to share your work, you can push your changes to a remote repository. When collaborating with others, you can pull changes from the remote repository to your local repository.

It is important to regularly commit your changes and push them to a remote repository to keep your work safe and to make it easier for others to access your changes. When working on a larger project, it is a good idea to create a new branch for each feature or bug fix you work on. This way, you can easily switch between different branches and merge your changes back into the main branch when you are done.

By following these basic Git commands and workflow, you will be able to effectively manage your projects and collaborate with others using Git.

### Git commands
1. `git init`

    This command is used to initialize a new Git repository. It creates a new directory in your current location, which acts as the repository. The command is used to start a new project and create a local repository for it.
    Example:
    ```csharp
    $ git init
    ```
3. `git clone`

     This command is used to clone an existing Git repository. It creates a local copy of a remote repository, which you can then use to make changes and push them back to the remote repository.
     Example:
    ```csharp
    $ git clone [repository-url]
    ```
5. `git status`

    This command is used to check the status of a Git repository. When you use this command, Git will show you which files have been modified, added, or deleted. It will also show you which changes are staged for committing.
    Example:
    ```csharp
    $ git status
    ```
7. `git add`

    This command is used to stage changes for committing. When you make changes to a file, you''ll need to use this command to add those changes to the staging area. The staging area is a place where changes are kept temporarily until they are committed.
    Example:
    ```csharp
    $ git add [file-name]
    ```
9. `git commit`

    This command is used to commit changes to the repository. When you use this command, all changes in the staging area are committed to the repository, along with a message that describes the changes.
    Example:
    ```csharp
    $ git commit -m "commit message"
    ```
11. `git push`

    This command is used to push changes from a local repository to a remote repository. When you use this command, all changes that have been committed are pushed to the remote repository, updating it with the latest changes.
    Example:
    ```csharp
    $ git push [remote-repository-name] [branch-name]
    ```
13. `git pull`

    This command is used to retrieve changes from a remote repository and update a local repository with those changes. When you use this command, Git will download any changes that have been made to the remote repository and merge them with your local repository.
    Example:
    ```csharp
    $ git pull [remote-repository-name] [branch-name]
    ```
15. `git log`

    This command is used to view a log of all changes that have been committed to a repository. When you use this command, Git will display a list of all commits, along with the date, author, and commit message for each commit.
     Example:
    ```csharp
    $ git log
    ```
17. `git stash`

    The git stash command is used to temporarily save changes that have not yet been committed to the repository. This is useful when you need to switch to a different branch to work on a different task, but do not want to commit your current changes. The stash allows you to save your changes and retrieve them later when you are ready to continue working on the same task. To run the git stash command, simply type "git stash" in the terminal or command prompt.
     Example:
    ```csharp
    $ git stash
    ```
18. `git cherry-pick`

    The git cherry-pick command is used to apply a specific commit from one branch to another branch. This is useful when you want to incorporate changes made in one branch into another branch, without having to merge the entire branch. To run the git cherry-pick command, simply type "git cherry-pick [commit_hash]" in the terminal or command prompt, replacing [commit_hash] with the hash of the specific commit you want to apply.
    Example:
    ```csharp
    $ git cherry-pick [commit_hash]
    ```


This chapter provides an overview of how these commands and stages work together to help you manage your code changes in Git. The examples provided in this chapter give you a hands-on understanding of how to use these commands effectively in your Git workflow. By the end of this chapter, you should have a clear understanding of the basic Git commands and how to use them to manage your code changes.', '2023-02-11T03:29:58.000000Z', '2023-02-24T11:00:08.000000Z', '2023-02-17T16:36:07.000000Z'),
	('Chapter 2: Installing and Configuring Git', '5pPLkP5GVRZ', '9', 'unlisted', '', 'This chapter belong to Getting Started with Git: A Beginner''s Guide  Series

In this chapter, we will focus on installing Git on your computer and setting it up for use. Before diving into Git commands and usage, you must have Git installed and properly configured on your computer. Git is available for Windows, Mac, and Linux operating systems and can be easily installed using the installation ...', '*This chapter belong to [Getting Started with Git: A Beginner''s Guide](https://viblo.asia/s/getting-started-with-git-a-beginners-guide-x7Z4DE6oJnX)  Series*

In this chapter, we will focus on installing Git on your computer and setting it up for use. Before diving into Git commands and usage, you must have Git installed and properly configured on your computer. Git is available for Windows, Mac, and Linux operating systems and can be easily installed using the installation packages provided by the Git official website.
### Installing
* Installing Git on Windows

     To install Git on Windows, you need to follow these steps:

    1. Download the latest Git version from the official Git website
    2. Double-click the downloaded file and run the installer.
    3. Follow the on-screen instructions to complete the installation.

* Installing Git on Mac

    To install Git on Mac, you need to follow these steps:

    1. Download the latest Git version from the official Git website.
    2. Double-click the downloaded file and run the installer.
    3. Follow the on-screen instructions to complete the installation.
    4. Installing Git on Linux

* To install Git on Linux, you need to follow these steps:

    1. Open the terminal window and run the following command:

        `sudo apt-get install git-all`

   2. The system will prompt you for your password. Enter your password, and the Git installation process will begin.
    3. Once the installation is complete, you can run the Git version command to check if the installation was successful.

### Configuring
Once you have installed Git on your computer, the next step is to configure it. You need to configure Git with your username and email address, as it will be used to identify the author of the changes made to the repository.

To configure Git, you need to run the following command in the terminal window:

```
git config --global user.name "Your Name"
git config --global user.email "Your Email Address"
```
With these simple steps, you have installed and configured Git on your computer. In the next chapter, we will dive into the Git commands and usage. Before you start working with Git, it''s important to understand the basics of version control and the Git terminology.', '2023-02-11T03:03:39.000000Z', '2023-02-24T09:27:03.000000Z', '2023-02-11T03:15:06.000000Z'),
	('Chapter 1: Understanding Git and Version Control', '7ymJXXvqJkq', '10', 'unlisted', '', 'This chapter belong to Getting Started with Git: A Beginner''s Guide  Series

1.1 Introduction to Git
In this section, we will define what Git is and what it does. Git is a distributed version control system that helps teams manage and track changes to software projects. It was created in 2005 by Linus Torvalds, the creator of the Linux operating system.

1.2 What is Version Control
Version cont...', '*This chapter belong to [Getting Started with Git: A Beginner''s Guide](https://viblo.asia/s/getting-started-with-git-a-beginners-guide-x7Z4DE6oJnX)  Series*

1.1 Introduction to Git
In this section, we will define what Git is and what it does. Git is a distributed version control system that helps teams manage and track changes to software projects. It was created in 2005 by Linus Torvalds, the creator of the Linux operating system.

1.2 What is Version Control
Version control is a system that records changes to a file or set of files over time so that you can recall specific versions later. This helps in maintaining a history of changes made to the code, and also makes it easier to revert to an earlier version of the code if needed.

1.3 Understanding Git Workflow
Git allows developers to work on different parts of a project simultaneously and merge their changes together. This is achieved through a unique branching and merging workflow that Git follows.

1.4 Key Features of Git
Git offers many key features that make it a popular choice for version control systems. Some of these features include:

* Distributed: Git allows for multiple copies of a project to be stored in different locations, making it easy for developers to work on the same project from different locations.
* Branching: Git allows developers to create different branches of a project, making it possible to work on different features or bugs simultaneously without affecting the main project.
* Merging: Git makes it easy to merge different branches of a project together, ensuring that the changes made in one branch are properly integrated into the main project.
* Speed: Git is fast and efficient, making it ideal for large projects with many developers working on the same codebase.
* Ease of use: Git has a user-friendly interface and a straightforward command-line interface, making it easy to use for developers of all levels of experience.

In this chapter, we will cover the basics of Git and version control to help you get started with using Git in your projects.', '2023-02-11T03:01:45.000000Z', '2023-02-27T14:03:04.000000Z', '2023-02-11T03:15:17.000000Z'),
	('Tăng tốc database phần 15 NULL trong Oracle Database', 'r1QLxQqqVAw', '11', 'unlisted', '', 'NULL luôn là một thứ gây bối rối, mặc dù ý tưởng của nó chỉ đơn giản là một giá trị cho biết là chỗ này chưa có dữ liệu. Có một số cái lạ nữa như là truy vấn thì luôn dùng IS NULL chứ không dùng = NULL.  Tuy nhiên ORACLE đối xử với NULL một cách dị hợm hơn chuẩn thông thường. Hơn nữa cách index trên NULL còn tiếp tục khác biệt.

Theo chuẩn thông thường, NULL được định nghĩa là chưa có dữ liệu, ...', 'NULL luôn là một thứ gây bối rối, mặc dù ý tưởng của nó chỉ đơn giản là một giá trị cho biết là chỗ này chưa có dữ liệu. Có một số cái lạ nữa như là truy vấn thì luôn dùng IS NULL chứ không dùng = NULL.  Tuy nhiên ORACLE đối xử với NULL một cách dị hợm hơn chuẩn thông thường. Hơn nữa cách index trên NULL còn tiếp tục khác biệt.

Theo chuẩn thông thường, NULL được định nghĩa là chưa có dữ liệu, hoặc dữ liệu chưa xác định. Nghĩa là không có giá trị nào = NULL. Tuy nhiên ORACLE lại khác nó coi empty string là NULL

```
   SELECT     ''0 IS NULL???'' AS "what is NULL?" FROM dual
    WHERE      0 IS NULL
UNION ALL
   SELECT    ''0 is not null'' FROM dual
    WHERE     0 IS NOT NULL
UNION ALL
   SELECT '''''''''' IS NULL???''  FROM dual
    WHERE    '''' IS NULL
UNION ALL
   SELECT '''''''''' is not null'' FROM dual
    WHERE    '''' IS NOT NULL
```

Đây là kết quả

| what is NULL?|
| -------- |
| 0 is not null  |
| '''' IS NULL??? |

Với tâm lý thích làm Dev phải băn khoăn, Oracle còn cho NULL là empty string luôn

```
SELECT 1
     , 1 || ''''
     , 1 || NULL
  FROM dual
```

Kết quả

![image.png](https://images.viblo.asia/c8add8e8-ea4e-405c-93f1-40554bae762c.png)

Trong khi ở db khác nó sẽ thế này
![image.png](https://images.viblo.asia/a973d55c-634e-4f0d-afa3-e7c163f13311.png)

Về cơ bản khác db khác mà có quan hệ với NULL sẽ là NULL nhưng oracle thì không như vậy. Thường thì ở mọi ngôn ngữ lập trình empty string sẽ không bao giờ là NULL. Ngoại trừ ...
Oracle Database. Nên là trong thực tế không thể nào lưu giá trị empty string  với kiểu VARCHAR2. Nếu bạn cố lưu thì Oracle đơn giản chỉ lưu NULL vào đó.

Cái đặc thù này không những lạ mà còn nguy hiểm. Và điều này còn tiếp tục của phần index nữa và mình sẽ nói ở những bài sau nhé!', '2023-02-10T16:29:46.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-10T16:29:24.000000Z'),
	('CI/CD cho Mobile App | Auto build Mobile App bằng CodeMagic ✨', 'E1XVOXQP4Mz', '1', 'unlisted', 'https://images.viblo.asia/6d513951-cc98-442d-ac7e-5b53fe391916.png', 'Lời chúc
Như thường lệ lướt Viblo, mình thường không để ý tới cái header đầu trang cho lắm 😀 Nay nhân ngày vừa mới được nghỉ việc mà chưa tìm được việc mới, tiện nhìn thấy cái header của Viblo có đăng tải event viết khai bút đầu xuân (đúng ý trời đã định) nên tham gia cho vui, nhân tiện cũng là lần đầu mình viết blog/ guide lên mạng, có gì sai sót hay lủng củng mong anh em góp ý để mình sửa chữ...', '# Lời chúc
Như thường lệ lướt Viblo, mình thường không để ý tới cái header đầu trang cho lắm 😀 Nay nhân ngày vừa mới được nghỉ việc mà chưa tìm được việc mới, tiện nhìn thấy cái header của Viblo có đăng tải event viết khai bút đầu xuân (đúng ý trời đã định) nên tham gia cho vui, nhân tiện cũng là lần đầu mình viết blog/ guide lên mạng, có gì sai sót hay lủng củng mong anh em góp ý để mình sửa chữa nhé.
    Giống như mọi bài viết khác tham gia event này, lời đầu tiên mình chúc những người đang đọc bài viết này thật nhiều sức khoẻ ( alway first thing 😀), hạnh phúc bên gia đình và người thân bạn bè, công việc thật thuận lợi nhé. Qua đó cũng cảm ơn đội ngũ của Viblo đã tạo ra sân chơi bổ ích và những sự kiện rất ý nghĩa cho cộng đồng
# Mở đầu
### CI/CD là gì?
Khái niệm CI (Continuos Integration) hay CD (Continuous Delivery - chuyển giao liên tục) chắc cũng không còn xa lạ với anh em dev. Theo cách văn vở thì nó là quá trình tích hợp và sử dụng các công cụ làm việc liên tục và tự động hoá của phần mềm vào vòng đời phát triển của sản phẩm. Còn theo cách dân dã, đây là quá trình tự động build, test, deploy web (đối với FE/BE) hoặc build app, deploy app lên chợ ứng dụng (đối với Mobile App) chỉ với 1 nút nhất (hoặc trigger vào hành động on push của Git). Hiện nay, CI CD trở thành điều hiển nhiên sẽ có trong quá trình phát triển phần mềm.
![CI-CD-la-gi-1.png](https://images.viblo.asia/6d513951-cc98-442d-ac7e-5b53fe391916.png)
### Mục đích và hạn chế
Như đã nói ở trên thì CI/CD được ứng dụng rất nhiều vào quy trình tự động hoá phát triển phần mềm. Hoặc chúng ta có thể tự build cài đặt cho Android/ iOS từ những dự án open source mà không cần kiến thức về lập trình Mobile chẳng hạn. Cái này khá hay với anh em non-tech vì có rất nhiều dự án mobile open-source hay ho (Youtube Vanced là 1 ví dụ), sau khi build ra file apk hoặc file ipa (dùng AltStore để cài đặt lên macOS, cái này nếu mọi người quan tâm mình sẽ lên 1 bài nữa sau) cài trực tiếp trên device luôn.
Hạn chế lớn nhất là dùng nhiều sẽ tốn phí. Với mỗi nhà cung cấp dịch vụ CI/CD thì mức phí sẽ khác nhau. Nếu dùng CodeMagic thì sẽ được free 150 tiếng mỗi tháng, khá là tẹt ga. Ở đây có 1 tips nhỏ là dùng hết 150 tiếng thì tạo tài khoản khác để xài free 😁
Hạn chế thứ 2 nữa là khá là khó để cấu hình với nhiều dự án quá phức tạp (nhiều môi trường,...)
# Chuẩn bị
### Giới thiệu về CodeMagic
Như tiêu đề bài viết, chúng ta sẽ chỉ đi vào CI/CD trên Mobile App (hoặc do mình không biết làm FE/BE 😁). Hiện nay có rất nhiều nhà cung cấp đã hỗ trợ việc này, có thể kể đến như Github Action, Bitrise, Gilab CLI,... (nếu mọi người quan tâm mình sẽ lên 1 bài nữa). Tuy nhiên ở bài viết này chúng ta sẽ sử dụng đến CodeMagic. Chắc hẳn anh em code Flutter nhiều có thể sẽ thấy cái tên này quen quen vì đây là nơi chia sẻ khá nhiều blog/ guide về Mobile App rất chi tiết, anh em có thể tham khảo thêm [ở đây](https://blog.codemagic.io/)

### Đăng kí và cấu hình Source Code
Để sử dụng thì for sure, chúng ta phải đăng kí tài khoản [ở đây](https://codemagic.io/login). Bước này mình xin phép skip nhé

Sau khi đăng nhập xong, chúng ta tiến hành thêm ứng dụng vào từ Git repo (Github, Gitlab, Bitbucket...). Ở đây mình sẽ demo add Github repo vào. Chọn ```Add application```, sau đó chọn Github và chọn ```Github integration``` để cấp quyền read github repo cho CodeMagic
![image.png](https://images.viblo.asia/316276ca-7704-4261-ba51-e83f4788ecd2.png)
Lưu ý là ở đây chỉ có thể add được những repo của mình, nên nếu repo nào không phải của mình thì anh em có thể fork nó về cho nhanh
Tiếp đến, chọn project type. Ở đây mình đang thử build 1 ứng dụng Flutter nên mình sẽ chọn Flutter và khi add thành công sẽ có kết quả như sau
![image.png](https://images.viblo.asia/253b2c0f-971a-431f-89c4-dec2fe98db29.png)
# Cấu hình
Tiếp đến là phần quan trọng nhất của quá trình. Ở đây ta sẽ có 2 cách cấu hình
### Cấu hình bằng Work Flow Editor
![image.png](https://images.viblo.asia/529c0885-e802-487c-a6b1-4e7ed427a96f.png)
Đây là cách cấu hình theo kiểu mì ăn liền khá là đơn giản. Như anh em có thể thấy trong ảnh trên, chúng ta chỉ cần tick và tick vào các mục như sau:
Build for Platforms: Sẽ build ra file cài đặt cho những platform nào
Run build on: Source code sẽ được build trên thiết bị nào. Ở đây theo mặc định ta sẽ build trên Mac Mini M1, những option còn lại đều phải nạp lần đầu (thêm banking info) để lựa chọn, có đầy đủ cả Linux, MacOS và Window.
    ![image.png](https://images.viblo.asia/6f4677f5-152a-4f83-a870-f58944ccb919.png)
Build trigger: Trigger hành động khi nào thì ứng dụng sẽ được build. Cái này tuỳ vào tính chất của work flow, nếu deploy lên môi trường testing thì thường sẽ trigger vào on push của nhánh dev hoặc staging. Còn nếu cấu hình để deploy thì sẽ trigger vào nhánh master của repo.
![image.png](https://images.viblo.asia/12ca7709-b141-41ed-b619-e980d7c8e4aa.png)
Environment variables: Thêm các biến env vào bản build
Build: Lựa chọn Flutter, XCode, CocoaPods version, lựa chọn chế độ build (debug, release hay profile), Android output format (apk hay aab), các tham số truyền vào khi build
![image.png](https://images.viblo.asia/1e50b0dd-b7f2-4ef3-abb5-985e214e40f1.png)
Distribution: Cấu hình keystore, sign app để publish
![image.png](https://images.viblo.asia/e07aab61-da15-446f-a6fb-9447242b235b.png)
Notification: Kênh thông báo, có thể thông báo qua email hoặc Slack khi build xong (ở đây có thể tự cấu hình webhook để bắn thông báo)

### Cấu hình bằng file .yaml
Với 1 số project có cấu hình phức tạp hơn thì chúng ta cần phải cấu hình bằng file yaml. Tương tự như cấu hình như cách ở trên thì sử dụng file .yaml cũng sẽ có những mục tương tự nhưng ở mức độ advantage hơn.
Sau đây là đoạn workflow bằng file .yaml mẫu để chạy build được ra file cài đặt Android.
```
workflows:
  android-workflow:
    name: Android Workflow
    instance_type: mac_mini_m1
    max_build_duration: 120
    environment:
      groups:
        - google_credentials # <-- (Includes GCLOUD_KEY_FILE, GOOGLE_CREDENTIALS)
      vars:
        FIREBASE_PROJECT: "YOUR_FIREBASE_PROJECT_NAME" # <-- Put your Firebase Project Name here
      flutter: stable
      xcode: latest
      cocoapods: default
    scripts:
      - name: Set up debug.keystore
        script: |
          rm -f ~/.android/debug.keystore
          keytool -genkeypair -alias androiddebugkey -keypass android -keystore ~/.android/debug.keystore -storepass android -dname ''CN=Android Debug,O=Android,C=US'' -keyalg ''RSA'' -keysize 2048 -validity 10000
      - name: Set up local.properties
        script: |
          echo "flutter.sdk=$HOME/programs/flutter" > "$CM_BUILD_DIR/android/local.properties"
      - name: Get Flutter packages
        script: |
          flutter packages pub get
      - name: Build APK with Flutter
        script: |
          flutter build apk --debug
      - name: Create debug and test APK
        script: |
          set -ex
          cd android
          ./gradlew app:assembleAndroidTest
          ./gradlew app:assembleDebug -Ptarget="$CM_BUILD_DIR/integration_test/app_test.dart"
    artifacts:
      - build/**/outputs/**/*.apk
      - build/**/outputs/**/*.aab
      - build/**/outputs/**/mapping.txt
      - flutter_drive.log
    publishing:
      email:
        recipients:
          - user_1@example.com
          - user_2@example.com
        notify:
          success: true # To not receive a notification when a build succeeds
          failure: false # To not receive a notification when a build fails
```
Như anh em có thể thấy là khá là lằng nhằng để cấu hình được với những người không có kiến thức về lập trình, nên mình không recommend cách này cho lắm.
# Kết quả
Sau khi build thành công sẽ có thông báo gửi về. File cài đặt sẽ được gửi kèm trong email hoặc build history, anh em chỉ việc tải file về và cài đặt trực tiếp (đối với Android) hoặc qua 1 chút thủ thuật khác (đổi với iOS).
![image.png](https://images.viblo.asia/457b3d08-ce15-4aeb-a0b7-f3dc7d12d499.png)

Trên đây mình vừa hướng dẫn cơ bản tạo 1 workflow để build file 1 cách tự động, ở bài viết tiếp theo mình sẽ hướng dẫn về sign keystore, auto deploy lên CHPlay mỗi lần build. Nhấn upvote nếu thấy hấp dẫn để ủng hộ mình nhé 😘', '2023-02-10T15:04:52.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-10T14:58:19.000000Z'),
	('Deploy Reactjs Với Docker và Nginx lên Ubuntu Server', 'PAoJeZ2AL1j', '2', 'unlisted', 'https://images.viblo.asia/31553040-4b41-4aaa-bf30-9e84b8d0fcec.png', 'Tổng quan
Docker là một công cụ khá tuyệt vời và rất hữu ích trong việc triển khai các ứng dụng thông qua container, trong bài viết này mình xin chia sẻ phương pháp để deploy dự án Reactjs lên server Ubuntu sử dụng webserver Nginx hoàn toàn trên Docker.

Chuẩn bị
Trước tiên các bạn cần chuẩn bị:

* Source code, nếu chưa có thì có thể tạo ở bước tiếp theo.
* 1 server ubuntu version 16, 18 hoặc 2...', '# **Tổng quan**
Docker là một công cụ khá tuyệt vời và rất hữu ích trong việc triển khai các ứng dụng thông qua container, trong bài viết này mình xin chia sẻ phương pháp để deploy dự án Reactjs lên server Ubuntu sử dụng webserver Nginx hoàn toàn trên Docker.

![](https://images.viblo.asia/0f089ca2-84af-4c0b-ae14-d3635bdf8a38.png)

## **Chuẩn bị**
Trước tiên các bạn cần chuẩn bị:

* Source code, nếu chưa có thì có thể tạo ở bước tiếp theo.
* 1 server ubuntu version 16, 18 hoặc 20... đều được, nếu chưa có thì các bạn có thể  tham khảo [Sunteco Cloud](http://sunteco.vn/sun-virtual-machine/), đang free trial cho tài khoản đăng ký mới.
* 1 chút kinh nghiệm cơ bản về Docker và Nginx.

Chuẩn bị xong thì bắt tay vào việc thôi nào...

## **1.Source code**
Tạo 1 project reactjs, nếu bạn đã có source code có thể  bỏ qua bước này:
```markdown
npx create-react-app react-deploy
cd react-deploy
```

![](https://images.viblo.asia/733d0e05-7596-4a4e-9dc0-e1480eaf9110.png)

Sau đó hãy thử run local:
```markdown
npm start
```
Mở trình duyệt và bạn sẽ thấy project sẽ chạy ở port 3000 ( hoặc port khác nếu như port 3000 bị ứng dụng khác chiếm dụng ).
![](https://images.viblo.asia/31553040-4b41-4aaa-bf30-9e84b8d0fcec.png)

## **2.Cấu hình Dockerfile**
Tại root project, chúng ta sẽ tạo 1 file với tên “**Dockerfile**” với nội dung:
```markdown
# Build docker image.
# Sử dung node
FROM node:12 as node

# Khai báo tham số
ARG workdir=.
LABEL description="deploy react app"

# Khái báo workdir trong node.
WORKDIR /app

# Copy project vào trong workdir của node.
COPY ${workdir}/ /app/

# Cài đặt các thư viện node liên quan.
RUN npm install

# Chạy lệnh build.
RUN npm run build

# Sử dụng nginx
FROM nginx:1.12
# Copy folder đã được build vào folder chạy của nginx.
COPY --from=node /app/build/ /var/www/dist/

# Copy file cấu hình chạy cho nginx (file nginx.conf sẽ tạo ở bước tiếp theo)
COPY --from=node /app/nginx.conf /etc/nginx/nginx.conf

# Cài đặt curl cho câu lệnh check HEALTH
RUN apt-get update && apt-get install -y curl

# Kiểm tra trạng thái của container sau khi chạy
HEALTHCHECK --interval=1m --timeout=3s \
  CMD curl -f http://localhost || exit 1

CMD ["nginx", "-g", "daemon off;"]
```
![](https://images.viblo.asia/cd4d1d7a-55cd-4a02-b5dd-32981896f74d.png)

## **3.Khởi tạo và cấu hình Nginx**
Tại root project, chúng ta sẽ tạo 1 file với tên “**nginx.conf**” với nội dung:
```shell
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    fastcgi_read_timeout 500;
    log_format  main  ''$remote_addr - $remote_user [$time_local] "$request" ''
                      ''$status $body_bytes_sent "$http_referer" ''
                      ''"$http_user_agent" "$http_x_forwarded_for"'';
    access_log  /var/log/nginx/access.log main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    server {
            listen       80;
            listen  [::]:80;
            server_name  localhost;
            include /etc/nginx/default.d/*.conf;
            location / {
                    alias /var/www/dist/;
                    try_files $uri $uri/ /index.html;

                    add_header Cache-Control public;
                    add_header Cache-Control no-store;
                    add_header Cache-Control no-cache;

                    if_modified_since off;
                    add_header Last-Modified "";
                    expires off;
            }
    }
}

```
Trong file config của nginx sẽ xuất hiện khá nhiều concept, các bạn có thể search để tìm hiểu sâu hơn. Nhưng có 1 số concept cần quan tâm, đó là:

* **worker_processes**: Thiết lập này định nghĩa số worker processes mà NGINX sẽ sử dụng. Bởi vì NGINX là đơn luồng (single threaded), nó thường bằng với số lõi CPU.
* **worker_connection**: Đây là số lượng tối đa của các kết nối đồng thời cho mỗi worker process và nói cho các worker process của chúng ta có bao nhiêu người có thể được phục vụ đồng thời bởi NGINX.
* **access_log & error_log**: Đây là những tệp tin mà NGINX sẽ sử dụng để log bất kỳ lỗi và số lần truy cập. Các bản ghi này thường được sử dụng để gỡ lỗi hoặc sửa chữa.
* **server**: Là các khối block dùng để định nghĩa các server ảo để xử lý các request từ client của bạn. Mỗi client request sẽ được xử lý dựa trên cấu hình được xác định trong mỗi server. Do đó, NGINX cần quyết định server nào phù hợp nhất cho request đó. Các directive được sử dụng để quyết định server là:

    * **listen**: là sự kết hợp địa chỉ IP/port mà server này được thiết kế để respond. Nếu một request từ client phù hợp với các giá trị này, server này có khả năng sẽ được lựa chọn để xử lý kết nối.
    * **server_name**: directive này là một thành phần khác, dùng để chọn một server để xử lý. Nếu có nhiều server đáp ứng được directive listen, NGINX sẽ phân tích cú pháp header “Host” của request và lựa chọn server phù hợp.

Trong một block **server**, chúng ta có thể định nghĩa nhiều **location** context được sử dụng để quyết định cách xử lý các request từ client. Bất cứ khi nào một request đến, NGINX sẽ kiểm tra khớp URI tới một trong số các location context và xử lý nó cho phù hợp.
Có nhiều directive quan trọng có thể được sử dụng trong **location** context , chẳng hạn như:

* **try_files**: Sẽ cố gắng phục vụ các tệp tin tĩnh được tìm thấy trong thư mục được trỏ tới bởi directive gốc.
* **proxy_pass**: Sẽ gửi request tới một proxy server cụ thể.
* **rewrite**: Sẽ viết lại URI tới dựa trên một regular expression để một khối location có thể xử lý nó.

## **4.Run Docker local**
Sau khi tạo xong  **nginx.conf**  và  **Dockerfile** thì chúng ta sẽ chạy thử dưới local thông qua Docker để xem thử kết quả nhé.
Đầu tiên cần phải build Dockerfile thành image với câu lệnh cmd (mở cmd tại root project) :
```css
docker build -t [image name]:[tag version] [path to dockerfile]

docker build -t  react-deploy .
```

![](https://images.viblo.asia/b3666426-5319-47b8-a868-75066f54d8f6.png)

Với câu lệnh trên thì chúng ta sẽ tạo 1 image với tên “**react-deploy**”, tag version để null nên tag mặc định sẽ là “**latest**” hoặc có thể sửa tag thành **react-deploy:0.1** nếu muốn gắn tag 0.1 và path to dockerfile sẽ để “**.**” do cmd đang đứng tại project.

**Lưu ý:** Nếu các bạn dùng linux/ubuntu có thể sẽ gặp lỗi liên quan đến permission docker (như ảnh bên dưới).

![](https://images.viblo.asia/da10e698-8965-4620-9926-0d1177eca7af.png)

Gặp lỗi này thì chúng ta chỉ cần cấp quyền cho docker theo câu lệnh:
```shell
sudo chown -R 1000 /var/run/docker.sock
```
Sau khi build image xong thì hãy kiểm tra trong list image:

```cpp
docker images
```

Ở đây chúng ta sẽ thấy có 1 image tên react-deploy với tag là latest.

![](https://images.viblo.asia/af728f7a-7832-472c-a335-c1ef0a0a6ad0.png)

Tiếp theo chúng ta sẽ run image:

```shell
docker run -d -p 80:80 --name react-deploy-container react-deploy:latest
```

Với câu lệnh trên thì chúng ta sẽ run 1 container  từ image “**react-deploy:latest”** với các option:

* **-d**: Chạy container ở background, có nghĩa là khi chúng ta tắt cửa sổ cmd thì container vẫn sẽ chạy bình thường.

* **-p**: Bind port của container vào port của host theo cú pháp: `[port host]:[port container]`

* **-–name**: Tên của container, cụ thể ở đây là “*react-deploy-container*”.

Sau khi run image xong thì chúng ta sẽ kiểm tra xem container đã run thành công chưa nhé:

```rust
docker ps
```

![](https://images.viblo.asia/d2037248-ad66-444c-a9d3-098383e4c70a.png)

Nếu thành công thì bạn sẽ thấy 1 container như hình và project sẽ run ở http://localhost mà không cần port 3000 nữa.
Nếu đến bước này mà các bạn không thấy container thì có thể comment dưới bài viết để mình support nhé.

 ## **5.Triển khai lên server ubuntu**

 Đến bước này là chúng ta đã chạy thành công ở local, tiếp theo sẽ phải đưa mọi thứ lên server ubuntu.
 Có nhiều cách như push code lên git, copy file lên server thông qua SCP… Ở bài viết này thì mình sẽ sử dụng Docker Hub nhé.

Docker Hub là một dịch vụ do Docker cung cấp, cho phép tìm kiếm và chia sẻ các container images.
Nếu chưa có tài khoản thì bạn có thể đăng ký tài khoản tại đây: https://hub.docker.com/

Sau khi tạo tài khoản xong thì chúng ta sẽ tạo 1 repository:
![](https://images.viblo.asia/96d63f92-5ae0-4c27-9c91-de545a7d9802.png)

Tiếp theo cần phải login docker để push image vừa build từ local lên Docker hub:
```shell
docker login -u [username] -p [password]
```
![](https://images.viblo.asia/754dfada-9226-4a00-9919-f7ca9b8ee9c3.png)

Gắn tag cho image cần push:

```css
docker tag [image name]:[tag] [repository]:[tag repository]
```

Cụ thể ở project chúng ta vừa build sẽ là:

```css
docker tag react-deploy:latest manhlh231/deploy-nginx:0.2
```

Tiếp theo sẽ push tag lên Docker hub:

```python
docker push manhlh231/deploy-nginx:0.2
```
![](https://images.viblo.asia/48e08a26-32eb-47db-bbf4-c0de092eb5ec.png)

Với câu lệnh trên, chúng ta vừa push image **react-deploy** với **tag latest ở local** lên repository **manhlh231/deploy-nginx** với **tag 0.2** trên Docker hub.

Sau đó thử check trên repository Docker hub sẽ thấy tag 0.2 vừa push lên.
![](https://images.viblo.asia/058d736b-4d02-400f-9d92-7cbdd8fc92d8.png)

Sau khi push image thành công lên Docker hub thì chúng ta sẽ remote vào server Ubuntu để pull image về server.

```cpp
ssh ubuntu@[ip server]
ssh ubuntu@103.9.211.66
```
Pull image:

```css
docker pull manhlh231/deploy-nginx:0.2
```

Run image trên server:
```markdown
docker run -d -p 80:80 --name reactv0.2 manhlh231/deploy-nginx:0.2
```

Kiểm tra kết quả tại địa chỉ của server!!
http://103.9.211.66/

Cảm ơn các bạn đã theo dõi bài viết.', '2023-02-10T12:12:59.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-24T04:11:06.000000Z'),
	('Bài 3 -  Đăng ký Firebase và cấu hình Fastlane đẩy APK lên Firebase Distribution (Phiên bản thử nghiệm)', 'y37LdwymJov', '3', 'unlisted', 'https://images.viblo.asia/3da88c64-df98-4a25-89a9-3eff4b318e04.png', 'Để tiện cho đội tester test sản phẩm và tự động hơn nên chúng ta cần làm CI - CD

Tóm tắt
Các khái niệm

* Firebase là một phần mềm phát triển ứng dụng do Google hỗ trợ cho phép các nhà phát triển phát triển các ứng dụng iOS, Android và web. Firebase cung cấp các công cụ để theo dõi các phân tích, báo cáo và sửa chữa các sự cố ứng dụng, tạo thử nghiệm tiếp thị và sản phẩm.

* APK là viết tắt củ...', '> Để tiện cho đội tester test sản phẩm và tự động hơn nên chúng ta cần làm CI - CD

# Tóm tắt
## Các khái niệm

* Firebase là một phần mềm phát triển ứng dụng do Google hỗ trợ cho phép các nhà phát triển phát triển các ứng dụng iOS, Android và web. Firebase cung cấp các công cụ để theo dõi các phân tích, báo cáo và sửa chữa các sự cố ứng dụng, tạo thử nghiệm tiếp thị và sản phẩm.

* APK là viết tắt của  **Android Package** (đôi khi là  **Android Package Kit** hoặc **Android Application Package** ). Đó là định dạng tệp mà Android sử dụng để phân phối và cài đặt ứng dụng. Do đó, APK chứa tất cả các yếu tố mà một ứng dụng cần cài đặt chính xác trên thiết bị của bạn.

* IPA là một tiện ích mở rộng cho tệp gói App Store iOS là tệp lưu trữ ứng dụng được sử dụng để phân phối các ứng dụng trên iOS. IPA chứa các tệp ở dạng không nén, chỉ có thể được cài đặt trên iOS.

# Hướng dẫn

## Đăng ký Firebase

* Chúng ta vào trang chủ của Firebase để đăng ký: https://console.firebase.google.com/u/0/

![Screenshot 2023-02-10 at 13.19.49.png](https://images.viblo.asia/3da88c64-df98-4a25-89a9-3eff4b318e04.png)

sau khi login thành công  chúng ta cọn "**Add Project**"

![](https://images.viblo.asia/2228fac0-e13e-451d-b22a-ce8f10b0b88a.png)

* Nhập tên project, ở đây mình sẽ đặt tên là "**React Native DevOps**"

![](https://images.viblo.asia/6a242cbc-ef9e-4bda-bab7-12d3e4b6e7b1.png)

* Tiếp tục nhấp vào **Continue**

![Screenshot 2023-02-10 at 13.34.58.png](https://images.viblo.asia/2c5ad938-c378-4836-b269-11c809ca075a.png)

* Tiếp tục nhấp vào **Continue**

![](https://images.viblo.asia/6fb20016-0e6e-457d-b13c-761cbd6b5eb6.png)

* Ở bước này chúng ta chọn account của GA or là tạo account mới cho GA, sau dó nhấp vào "Create project"

![Screenshot 2023-02-10 at 13.37.15.png](https://images.viblo.asia/daf6d2e6-4037-48e5-86e9-9278d0d84ca5.png)


* Tiếp tục nhấp vào **Continue**, Như vậy bạn đã tạo thành công project trên Firebase
*
![Screenshot 2023-02-10 at 13.38.04.png](https://images.viblo.asia/1ee79b99-1865-4450-bf1b-dcafc542bd5e.png)

## Cấu hình Firebase cho Android

* Tạo App Name cho project android bằng cách nhấp vào icon Android trên trang dashboard của Firebase

![](https://images.viblo.asia/d7893857-82c0-4f58-b649-f59925f50119.png)

* Nhập **Android ackage name** và nhấp vào "**Register app**"

![](https://images.viblo.asia/dd9fc80f-997b-428e-bca1-7d6b4d90be15.png)

* Tải file **google-services.json** về và nhấp vào "**Next**"

![Screenshot 2023-02-10 at 13.46.28.png](https://images.viblo.asia/467af0ce-2b39-480f-bde4-ad829e2dd5f2.png)

* Copy file vừa tải về vào thư mục **android/app**

![](https://images.viblo.asia/864cba07-2105-4305-b0b7-b7eb84fbbdc9.png)

* Sau đó mở **Android studio**  và chọn project của mình

![Screenshot 2023-02-10 at 13.47.52.png](https://images.viblo.asia/37743f0e-fce6-4472-bce2-367a1c932459.png)

* Để cho các giá trị cấu hình google-services.json có thể truy cập được vào SDK Firebase, bạn cần có plugin Gradle dịch vụ của Google.

![](https://images.viblo.asia/b252478f-18a7-44e4-9b15-968035c2875c.png)

* Sau đó, trong tệp module (app-level) build.gradle , hãy thêm cả plugin dịch vụ google và bất kỳ SDK Firebase nào bạn muốn sử dụng trong ứng dụng của mình:

![](https://images.viblo.asia/0094549c-2839-4ef8-a12e-0a3cf89779b9.png)

* Tiếp tục quay lại trang web và nhấp vào "**Next**"

![](https://images.viblo.asia/5b950f29-49a3-4330-ae39-9f1b4dde3900.png)

* Tiếp tục quay lại trang web và nhấp vào "**Continue console**"

![](https://images.viblo.asia/01283676-e67e-4c84-a5e6-3dc15861c854.png)

![Screenshot 2023-02-10 at 14.47.44.png](https://images.viblo.asia/8e111288-058f-4d62-9252-cea150e6ff4a.png)

* Như vậy mình đã tạo Firebase cho android thành công

## Cấu hình Fastlane cho Android

Đầu tiền vào thư mục **android** :

```
cd android
```

![Screenshot 2023-02-10 at 15.05.40.png](https://images.viblo.asia/4a354dcb-3312-43e2-95aa-0aa39892b0d1.png)

sau đó init fastlane bằng lệnh

```
fastlane init
```

![](https://images.viblo.asia/fe829f2d-fcce-44a1-b7e4-00689bf4748f.png)

Sau khi init thành công thì sẽ có thư mục **fastlane** và 2 file "**Appfile**" , "**Fastfile**"

Cài đặt firebase-tools dùng để lấy token login

```
 npm i firebase-tools -g
```

![Screenshot 2023-02-10 at 16.19.23.png](https://images.viblo.asia/7c3251b4-74aa-416c-8d71-c4575a8c57b6.png)

sau khi mình cài đặt thành công và sử dụng lệnh để lấy token login

```
firebase login:ci
```

![](https://images.viblo.asia/e5e68563-3969-41a6-acb8-9e5e207ccdbb.png)

như vậy mình đã có token login

```
1//0gP2yENNqCT1oCgYIARAAGBASNwF-L9IrqQI9gih5h73FSmaozzyn0HSQXxS7Vyyav2h4zEk4ClMbgmz6CwbEShz_qJVMmTxiGas
```

Tiếp tục mình sẽ lấy app-id

![](https://images.viblo.asia/9b64793d-9975-456a-9253-49b5273b84db.png)

```
1:320882145170:android:21837959d5ffc9fe65b34b
```


Tiếp tục ta cập nhật "**Appfile**" , "**Fastfile**"

* Appfile
```
json_key_file("") # Path to the json secret file - Follow https://docs.fastlane.tools/actions/supply/#setup to get one
package_name("com.reactnativedevops") # e.g. com.krausefx.app
```

* Fastfile

```
default_platform(:android)
  desc "Submit a new Beta Build to Crashlytics Beta"
  lane :beta do

    gradle(
      task: "clean"
    )

    gradle(
      task: ''assemble'', #assemble #bundle
      build_type: ''Release''
    )

     firebase_app_distribution(
       app: "1:320882145170:android:21837959d5ffc9fe65b34b",
       firebase_cli_token: "1//0gP2yENNqCT1oCgYIARAAGBASNwF-L9IrqQI9gih5h73FSmaozzyn0HSQXxS7Vyyav2h4zEk4ClMbgmz6CwbEShz_qJVMmTxiGas",
     )
  end
end
```

Tiếp tục add plugin cho fastlane

```
fastlane add_plugin firebase_app_distribution
```

![Screenshot 2023-02-10 at 16.59.01.png](https://images.viblo.asia/7defe04d-d771-4b9c-b499-f53409bf26fb.png)

Kích hoạt  Firebase Distribution trên  Firebase console:

![](https://images.viblo.asia/8f37b6b1-6284-458d-8eb6-b315eddedbc0.png)

![Screenshot 2023-02-10 at 17.07.23.png](https://images.viblo.asia/b9549722-c18f-4d2b-b9fd-dee877e1b4e2.png)

Sau đó ta dùng lệnh để build

```
cd android && fastlane beta
```

![image.png](https://images.viblo.asia/b717010c-f474-4d84-ad26-c8047ddc971c.png)

Khi build thành công ta vào trang Firebase console để kiểm tra xem bản build đã lên chưa

![Screenshot 2023-02-10 at 17.48.53.png](https://images.viblo.asia/b416fa7d-314f-45d0-b440-b740fa73b680.png)

Như vậy bản build đã build thành công, bây giờ mình chỉ cần thêm mail của tester vào để test bản build Android thôi


Các bạn có thể tham khảo qua [github](https://github.com/tdduydev/ReactNativeDevOps)
### Cảm ơn các bạn đã theo dõi bài viết, nếu bài viết hay thì cho mình xin 1 upvote để có động lực làm thêm nhiều bài che sẽ hơn.', '2023-02-10T10:50:10.000000Z', '2023-02-28T03:00:23.000000Z', '2023-02-10T11:28:36.000000Z'),
	('Blog#140: Node.jsとはなにか？なぜみんな使っているのか？', '018J2vDeJYK', '4', 'unlisted', 'https://images.viblo.asia/98b53609-3fd1-4319-a52d-533bd7fbb847.png', '

この記事の主な目的は、日本語レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために簡単な日本語を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ日本語を学ぶことです。

こんにちは、私はトゥアンと申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

この記事は、JavaScriptを勉強しているときに、みんながNode.jsを前提に話を進めるのを見かけると、「Node.jsってWebサーバじゃないの？ なんでインストールしなきゃいけないの？ なんでみんな使ってるの？」という疑問を持つ人がいるかもしれないということを考えて書かれています。その疑問を解消することを目的としています。

基礎：JavaScri...', '![image.png](https://images.viblo.asia/98b53609-3fd1-4319-a52d-533bd7fbb847.png)

> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。
-----
こんにちは、私は[トゥアン](https://tuan-portfolio.web.app/#/)と申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

この記事は、JavaScriptを勉強しているときに、みんながNode.jsを前提に話を進めるのを見かけると、「Node.jsってWebサーバじゃないの？ なんでインストールしなきゃいけないの？ なんでみんな使ってるの？」という疑問を持つ人がいるかもしれないということを考えて書かれています。その疑問を解消することを目的としています。

# 基礎：JavaScriptの特徴
まずは、JavaScriptと他のプログラミング言語の違いを理解する必要があります。**JavaScript**は、ChromeやFirefoxなどの「**ブラウザ上**」で動作するプログラミング言語です。一方、PythonやRubyなどの一般的なプログラミング言語は、通常「**パソコン上**」

![image.png](https://images.viblo.asia/7a3e769f-11d8-4667-8971-b587efb0642c.png)

パソコン上で動作するアプリケーション（PythonやRubyなど）が、OSの機能（ファイルの読み書きやネットワーク通信など）にアクセスできるかどうかが、その違いとなります。

![image.png](https://images.viblo.asia/1bbcc2f8-3ca5-4720-9780-6d3f12df6ddf.png)

パソコンにアクセスしただけで、勝手にパソコン上のファイルを読み書きしたり、消したりする可能性があるので、ブラウザ上で動作するプログラム（JavaScript）がOSの機能へアクセスできないようになっています。

しかし、OSの機能へ全くアクセスできないと不便なので、ブラウザが限定的にOSの機能へのアクセスを仲介してくれています。その仲介で、カメラやマイクへのアクセスもできるようになり、Web会議などができるようになりました。

![image.png](https://images.viblo.asia/a3ea24f8-8b2d-4c42-82ce-d016fe4e6b6c.png)

# Node.jsって何者？
Node.jsというのは、ブラウザ上でしか動かなかったJavaScriptを、パソコン上で動かせるようにするツールです。

![image.png](https://images.viblo.asia/37fd27a9-ccfc-459e-b2bc-87212dcac361.png)

Node.jsは、WindowsにPythonをインストールすると「python.exe」ができるように、インストールすると「node.exe」というJavaScriptを実行するアプリケーション（JavaScript実行環境）ができます。Node.jsを使うと、JavaScriptでOSの機能にアクセスして、ブラウザ上ではできなかった自由なファイルの読み書きやネットワーク通信などを行うことができます。

![image.png](https://images.viblo.asia/f95fa22e-2e90-45c6-9ec1-13c679846343.png)

Node.jsは、Webアプリケーションだけでなく、他の種類のアプリケーションを作成するためにも使えます。例えば、コマンドラインツールやデスクトップアプリケーションなどを作成することができます。

## Node.jsはサーバサイドのJavaScript実行環境？
Node.jsは、Webサーバを構築するために設計されたJavaScriptの実行環境です。そのため、「サーバサイドのJavaScript実行環境」という紹介がよくされます。しかし、現在では、Node.jsを使って「ブラウザで実行するJavaScript」を開発するための環境としても利用されています。つまり、Node.jsは「サーバサイドのJavaScript実行環境」としても「クライアントサイドJavaScriptの開発環境」としても利用されているということです。

# npmって何者？
Node.jsを使うときに便利なツール、npmがあります。npmはPythonのpipやRubyのgem(RubyGems)、Debianのapt、MacのHomebrew、Rustのcargoなどと同じようなものです。

yarnというのもありますが、npmと同じことができるので大丈夫です。「パッケージ」というのはライブラリやフレームワークのことで、VueやReact、webpack、jQueryなどのことです。

Node.jsで使いたいライブラリがある場合、npmを使ってインストールするので、jsファイルをダウンロードしてきて`<script src="xxx.js"></script>`とか書く必要はありません。

# Node.jsってなんでみんな使ってるの？
JavaScriptを使えるようになったNode.jsを使って、クライアントサイドのプログラムを書いたり、Webアプリケーションやモバイル/デスクトップ用のアプリケーションを作ることができるようになりました。

## 目的1. 新しい仕様のJavaScriptまたはTypeScriptでクライアントサイドのプログラムを書きたい
![image.png](https://images.viblo.asia/b4e41bea-7573-47ba-8aee-63a6f8099618.png)

JavaScriptの新しい仕様（ES2015以降）を使うためには、Babelを使って変換したり、Node.jsを使って環境を整える必要があります。TypeScriptについては割愛します。

JavaScriptの最新仕様（ES2015以降）は、至る所で解説されています。それらを使うためには、Babelを使って変換したり、Node.jsを使って環境を整える必要があります。TypeScriptについては今回は話しません。

## 目的2. Webアプリケーションを作りたい
Ruby + RailsやPython + Djangoなどで作るような**Webアプリケーション**をNode.jsで作ることも可能です。

この場合の対応する項目を表で書くととなります。

| 実行環境 | 言語 | Webフレームワーク |
|:---:|:---:|:---:|
| Ruby | Ruby | Ruby on Railsなど |
| Python | Python | Djangoなど |
| Node.js | JavaScript | Expressなど |

Node.jsは、大量の同時接続をさばけるようなネットワークアプリケーションを構築するために設計されたプログラミング言語です。

Node.jsは、Webサーバとしての役割を受け持ち、HTTPリクエストを受け取り、処理をしてくれます。

一般的なWebサーバ（Apacheやnginx）の代わりにNode.jsを使うことができますが、Node.jsだけでは機能が足りないので、Apacheやnginxをリバースプロキシとして置く構成が多いです。

JavaScriptしかできない人はNode.jsを選ぶように言われるかもしれませんが、Node.jsを勉強する労力と、他のプログラミング言語を勉強する労力はあまり変わらないので、言語にとらわれずに特徴をよく調べてから選択するのがいいでしょう。

## 目的3. モバイル/デスクトップ用のアプリケーションを作りたい
Node.jsを使えば、モバイルアプリケーションやデスクトップアプリケーションを作ることができます。モバイルアプリケーションの場合は、React Nativeというフレームワークを使いますが、デスクトップアプリケーションの場合は、Electronというフレームワークを使います。

Electronは、JavaScript、HTML、CSSを使ってデスクトップアプリケーションを作成するためのフレームワークです。

**Electron**
[https://www.electronjs.org/](https://www.electronjs.org/)

![image.png](https://images.viblo.asia/9f3fc880-f022-4b70-9999-3a9066446d16.png)

JavaScriptはウェブサイトを作るための言語で、UI（ユーザーインターフェース）を操作するのによく使われます。そのため、UIを構築するためのライブラリやフレームワークが充実しています。その財産を活用することで、ウェブサイトと同じようなUIを作ることができるのは大きなメリットです。

また、Electronを使えば、WindowsやMac、LinuxなどのOSの機能を扱うアプリケーションを作ることができます。さらに、Electronを使えば、同じコードでWindowsやMac、Linuxなどのプラットフォームで動くアプリを作ることができます。

Visual Studio Code、Slack、Discord、Twitch、Skypeなどのデスクトップアプリは、このElectronを使って作られています。

## 目的4. その他
Node.jsは、ウェブサイトのアセットをバンドル（webpack）するため、SassをCSSに変換（node-sass）するため、テストツール（Jest）やコード検証ツール（ESLint）を使うため、開発用の簡易Webサーバ（webpack-dev-server）をローカルで立てるため、静的サイトをビルド（Gatsby）するためなど、様々な用途で使われています。

# 結論
Node.jsはJavaScriptに大きな可能性をもたらしました。他のプログラミング言語と比べて設計が甘いと言われるJavaScriptですが、多くの人が使用しているため、ライブラリなども含めて急速に進化しています。そのため、今の時代に生まれて、このスリリングなJavaScriptの進化の波に乗れるのはワクワクできて楽しいことです。Node.jsをインストールしなければならないのは、ES2015を書きたいだけなのになぜなのかという疑問を解消するためです。

# 最後
いつもお世話になっています。この記事を楽しんで、新しいことを学べたら嬉しいです。

今度の記事でお会いしましょう！この記事が気に入ったら、私を応援するために「LIKE」を押して登録してください。ありがとうございました。

-----
> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。

# リソース
* https://tuan200tokyo.blogspot.com/2023/02/blog140-nodejs.html', '2023-02-10T10:07:43.000000Z', '2023-02-27T09:06:08.000000Z', '2023-02-10T09:54:41.000000Z'),
	('Blog#139: What is Node.js? Why is everyone using it?', 'EvbLbbGlLnk', '5', 'unlisted', 'https://images.viblo.asia/e7589420-6b85-4948-8cda-a1a1bcdb4c80.png', '

The main goal of this article is to help you improve your English level. I will use Simple English to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but remember that the main target of this article is still to LEARN ENGLISH.

Hi, I''m Tuan, a Full-stack Web Developer from Tokyo 😊.
F...', '![image.png](https://images.viblo.asia/e7589420-6b85-4948-8cda-a1a1bcdb4c80.png)

> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.
-----
Hi, I''m [Tuan](https://tuan-portfolio.web.app/#/), a Full-stack Web Developer from Tokyo 😊.
Follow my blog to not miss out on useful and interesting articles in the future.

[This article is a translation from another article. LINK](https://viblo.asia/p/blog140-nodejs%E3%81%A8%E3%81%AF%E3%81%AA%E3%81%AB%E3%81%8B%E3%81%AA%E3%81%9C%E3%81%BF%E3%82%93%E3%81%AA%E4%BD%BF%E3%81%A3%E3%81%A6%E3%81%84%E3%82%8B%E3%81%AE%E3%81%8B-018J2vDeJYK)

You are learning JavaScript and may encounter everyone discussing Node.js and have questions like "Isn''t Node.js a web server? Why do I have to install it? Why is everyone using it?" The purpose of this article is to answer those questions.

# The features of JavaScript
You need to understand the difference between JavaScript and other programming languages first. JavaScript is a programming language that runs on browsers like Chrome and Firefox, while other popular programming languages like Python and Ruby usually run on computers. It''s like the difference between a browser and a computer - one is for surfing the web, the other is for doing serious work. Or, as I like to say, JavaScript is for browsing the web, while other languages are for browsing the fridge.

![image.png](https://images.viblo.asia/7a3e769f-11d8-4667-8971-b587efb0642c.png)

Applications that run on a computer (such as Python or Ruby) can access the functions of the operating system (such as reading and writing files or network communication), which is the difference. Or, in other words, computers are like a box of chocolates - you never know what you''re gonna get!

![image.png](https://images.viblo.asia/1bbcc2f8-3ca5-4720-9780-6d3f12df6ddf.png)

Just by accessing a computer, there is a possibility that files on the computer can be read, written, or deleted without permission, so programs that run on browsers (JavaScript) are prevented from accessing the functions of the operating system.

However, it is inconvenient to not be able to access the functions of the OS at all, so the browser mediates limited access to the functions of the OS. Through this mediation, access to the camera and microphone is also enabled, and web conferences are now possible.

![image.png](https://images.viblo.asia/a3ea24f8-8b2d-4c42-82ce-d016fe4e6b6c.png)

# What is Node.js?
Node.js is a tool that allows you to run JavaScript on your computer, instead of just in your browser.

![image.png](https://images.viblo.asia/37fd27a9-ccfc-459e-b2bc-87212dcac361.png)

Node.js installs an application (a JavaScript runtime environment) called "node.exe" when you install it on Windows, just like when you install Python you get "python.exe". With Node.js, you can access the operating system''s features with JavaScript and do things like read and write files and network communication that you can''t do on a browser.

![image.png](https://images.viblo.asia/f95fa22e-2e90-45c6-9ec1-13c679846343.png)

Node.js can be used not only for web applications, but also to create other types of applications. For example, you can create command line tools and desktop applications.

## Node.js is a server-side environment for running JavaScript?
Node.js is an environment designed to build web servers using JavaScript. That''s why it''s often referred to as a "server-side JavaScript execution environment". However, nowadays Node.js is also used as an environment to develop "JavaScript to be run in the browser", so it can be used both as a "server-side JavaScript execution environment" and a "client-side JavaScript development environment". In other words, Node.js is used for both!

# What is npm?
NPM is a handy tool when using Node.js. It''s like Python''s pip, Ruby''s gem (RubyGems), Debian''s apt, Mac''s Homebrew, and Rust''s cargo.

There''s also yarn, but it''s okay because it can do the same thing as npm. "Packages" are libraries and frameworks, like Vue, React, webpack, and jQuery.

If you want to use a library with Node.js, you can install it with npm, so you don''t have to download a js file and write `<script src="xxx.js"></script>`. It''s like a magical package delivery service!

# Why is everyone using Node.js?
Now you can use Node.js, which has enabled you to use JavaScript, to write client-side programs and create web applications and applications for mobile/desktop! Yay!

## Purpose 1: I want to write client-side programs in new specifications of JavaScript or TypeScript.

![image.png](https://images.viblo.asia/b4e41bea-7573-47ba-8aee-63a6f8099618.png)

To use the newest JavaScript specifications (ES2015 and beyond), you need to use Babel to convert it or set up an environment with Node.js.

Let''s not talk about TypeScript this time.

## Purpose 2: I want to create a web application.
You can make web applications with Node.js, just like you can with Ruby + Rails or Python + Django.

| Execution environment | Language | Web framework |
|:---:|:---:|:---:|
| Ruby | Ruby | Ruby on Rails ..vv|
| Python | Python | Django ...vv|
| Node.js | JavaScript | Express ...vv|

Node.js is a programming language designed to build network applications that can handle large amounts of simultaneous connections. It takes on the role of a web server, receiving HTTP requests and processing them.

You can use Node.js instead of a typical web server (Apache or nginx), but often a configuration with Node.js and Apache or nginx as a reverse proxy is used because Node.js alone is not enough.

People who can only do JavaScript may be told to choose Node.js, but the effort to learn Node.js is not much different from the effort to learn other programming languages, so it''s best to choose without being tied to a language and to research its features well.

## Purpose 3: I want to create applications for mobile/desktop.
Using Node.js, you can create mobile applications and desktop applications. For mobile applications, you use the framework React Native, and for desktop applications, you use the framework Electron. Electron is a framework for creating desktop applications using JavaScript, HTML, and CSS.

**Electron**: [https://www.electronjs.org/](https://www.electronjs.org/)

![image.png](https://images.viblo.asia/9f3fc880-f022-4b70-9999-3a9066446d16.png)

JavaScript is a language used for creating websites, and it''s often used for manipulating the user interface (UI). Because of this, there are many libraries and frameworks available for building UI. This is a big advantage because it allows you to create UI that''s similar to websites.

Additionally, using Electron, you can create applications that handle the features of operating systems like Windows, Mac, Linux, etc. Furthermore, using Electron, you can create applications that run on different platforms such as Windows, Mac, Linux, etc. using the same code.

Desktop applications like Visual Studio Code, Slack, Discord, Twitch, Skype, etc. are created using Electron.

## Purpose 4: Others
Node.js is used for various other purposes, like bundling website assets with webpack, converting Sass to CSS using node-sass, using testing tools like Jest and code validation tools like ESLint, setting up a development-friendly web server locally with webpack-dev-server, and building static sites with Gatsby. It''s like a Swiss Army knife for web developers!

# Conclusion
Node.js has brought the same level of potential to JavaScript as other programming languages. (The V8 JavaScript engine is also responsible for this, but it was not mentioned in the text because it can make the discussion more complicated.)

As often said, JavaScript does have some weaknesses in its design compared to other languages. Some people may think that it is still on the same level as other languages.

However, JavaScript has a huge user base among young people, and it is evolving at an incredible speed, including its libraries, making it the only programming language with changing trends.

jQuery is now considered a historical relic, but it was born after Rails and Django (it is not easy to compare, but still). It shows how fast things are moving.

Personally, I find it exciting and enjoyable to be able to ride this thrilling wave of evolution in JavaScript that was born in this era.

Finally, I hope that this article will answer common questions such as "Is Node.js not a web server? Why do I have to install it if I just want to write with ES2015?" that are often asked at the beginning.

# And Finally
As always, I hope you enjoyed this article and learned something new.
Thank you and see you in the next articles!

If you liked this article, please give me a like and subscribe to support me. Thank you. 😊

-----
> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.

# Resource
* https://tuan200tokyo.blogspot.com/2023/02/blog139-what-is-nodejs-why-is-everyone.html', '2023-02-10T10:07:25.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-10T10:08:15.000000Z'),
	('Extension ChatGPT | ChatGPT đã được tích hợp vào Visual Studio Code ra sao', 'E1XVOXeP4Mz', '6', 'unlisted', 'https://images.viblo.asia/3b073711-5c21-459f-9def-3dfafc30e66e.png', 'Hí anh em, lại là mình đây | Đầu năm chúc anh em năm mới phát tài phát lộc, lương trăm củ nhé. 😆😆🥰

Hôm trước mình đã có 1 bài viết về hướng dẫn tạo tài khoản ChatGPT (tham khảo tại đây) , hôm nay thì mình xin giới thiệu với các bạn 1 extension tích hợp ChatGPT để hỗ trợ coding được hiệu quả. Gét gô!!!!

1. Cài đặt Extension ChatGPT
Đầu tiên các bạn vào vscode và tìm extension có tên là "ChatGP...', '> Hí anh em, lại là mình đây | Đầu năm chúc anh em năm mới phát tài phát lộc, lương trăm củ nhé. 😆😆🥰

*Hôm trước mình đã có 1 bài viết về hướng dẫn tạo tài khoản ChatGPT ([tham khảo tại đây](https://viblo.asia/p/chat-gpt-cach-tao-tai-khoan-nhanh-gon-le-cho-nguoi-dung-o-viet-nam-WR5JRmn04Gv)) , hôm nay thì mình xin giới thiệu với các bạn 1 extension tích hợp ChatGPT để hỗ trợ coding được hiệu quả. Gét gô!!!!*

# 1. Cài đặt Extension ChatGPT
Đầu tiên các bạn vào vscode và tìm extension có tên là "ChatGPT" để tiến hành cài đặt:

![](https://images.viblo.asia/3b073711-5c21-459f-9def-3dfafc30e66e.png)

Mọi người lưu ý chọn đúng tên và nhà phát hành nhé (do có nhiều extension khác tương tự, tuy nhiên mình có thử dùng thì không ổn lắm).

Tiếp theo, chúng ta cần login account ChatGPT (Xem hướng dẫn đăng ký [tại đây](https://viblo.asia/p/chat-gpt-cach-tao-tai-khoan-nhanh-gon-le-cho-nguoi-dung-o-viet-nam-WR5JRmn04Gv)) để tiến hành sử dụng. Sẽ có 2 phương thức xác thực bao gồm:
* Login trực tiếp bằng tài khoản gmail thông qua trình duyệt
* Login bằng API Secret Key

![image.png](https://images.viblo.asia/cdc2a39e-58db-40a6-a219-5177c372295b.png)

Ở đây mình sẽ hướng dẫn các bạn cách login bằng API Key nhé:
1. Các bạn truy cập trang chủ của OpenAI Api: https://openai.com/api/ sau đó đăng nhập tài khoản đang sử dụng ChatGPT
2. Vào "**Personal**", chọn mục "**View Api keys**"

![](https://images.viblo.asia/12a48017-8da1-4cdc-998b-d310cea96c2a.png)

3. Ở màn hình Account API Keys, chọn "Create new secret key", sau đó copy đoạn key được hiển thị

![](https://images.viblo.asia/7add6c16-bcbc-449d-a1eb-18d7d3595819.png)

4. Quay trở lại VSCode, vào **Extension Setting** của extension ChatGPT vừa cài đặt lúc nãy, kéo xuống tìm mục "**Chagpt > gpt3: Api Key**" và paste đoạn key lúc nãy vào. Vậy là xong. Bạn có thể bắt đầu code thần sầu với chatGPT ngay bên cạnh rồi 🥰😍

![](https://images.viblo.asia/fa4c684f-3fac-4350-8e69-7a924366bcdc.png)

![](https://images.viblo.asia/35097c26-5674-425f-8b97-eab840427053.png)


# 2. Các tính năng nổi bật
- Để sử dụng extension, các bạn thực hiện bôi đen 1 đoạn code, sau đó click chuột phải, sẽ có một số option để chọn như: Tìm bug, Giải thích code, Tối ưu code, ..vv.vvv Đây là những tính năng mình đặc biệt thích ở extension này.

![](https://images.viblo.asia/7e6c0a9d-38bf-4e65-9184-23e506f07090.png)

Như ở ví dụ trên, mình code tào lao 1 đoạn như vậy, để xem thử con Bot được tích hợp này sẽ xử lý như thế nào nhé. Đầu tiên mình sẽ cho nó giải thích đoạn code, lúc này một cửa sổ trò chuyện nhỏ sẽ xuất hiện bên trái, ở đây chúng ta có thể tương tác với ChatGPT giống như phiên bản web:

![](https://images.viblo.asia/a23731b9-5836-41d3-b017-5ac724583393.png)

Khá là tiện lợi phải không nào, bây giờ chúng ta thử cho nó tìm bug trong đoạn code và refactor lại nhé:
- Tìm ra được bug nè:

![](https://images.viblo.asia/65bf8d97-69f2-4692-b0cd-546ac4e0e7e6.png)

- Chỉ ra cách refactor lại code:

![](https://images.viblo.asia/c8f6a23b-5cbd-4136-8763-68e4059535c9.png)

Khá là xịn kaka 😁

# 3. Tổng kết
*  Extension này còn có các tính năng hay ho khác nữa, nhưng trong khuôn khổ bài viết này mình không thể giới thiệu đầy đủ được, các bạn vào nghiên cứu tiếp nhé
*  Nội dung chatbot trong trình tích hợp này đã được filter lại theo chủ đề công nghệ, coding, nên nhiều câu hỏi về lĩnh vực ngoài lề khác nó sẽ không trả lời như phiên bản web

![](https://images.viblo.asia/f5903e18-3b04-434c-8bad-e066a57044ef.png)

*  Có lẽ cũng chính vì được giới hạn chủ đề như vậy, nên tốc độ trả lời của nó mình nhận xét nhanh và mượt hơn nhiều phiên bản web hiện tại 😘
*  1 Lần nữa mình nhấn mạnh là phiên bản ChatGPT hiện tại vẫn đang trong qúa trình hoàn thiện, nên thông tin mà nó trả lời không phải lúc nào cũng chính xác 100%, vì vậy anh em sử dụng nó thì nên chỉ để tham khảo thôi nhé, đừng tin tưởng quá


# Tài liệu tham khảo
- Extension ChatGPT: https://github.com/gencay/vscode-chatgpt
- https://marketplace.visualstudio.com/items?itemName=gencay.vscode-chatgpt', '2023-02-10T06:43:10.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-20T12:42:37.000000Z'),
	('Xây dựng ứng dụng hỗ trợ luyện viết tiếng Anh bằng ChatGPT API và NextJS', '3kY4g5okLAe', '7', 'unlisted', 'https://images.viblo.asia/5605bade-1aa2-4880-b7bb-a1c249e6b9f0.png', 'Xin chào tất cả các bạn!

Nhân dịp năm mới xin chúc tất cả các bạn đọc của Viblo một năm an khang thịnh vượng, đạt được nhiều thành công trong sự nghiệp và cuộc sống!

Chắc hẳn các bạn đều biết tới ChatGPT, 1 con bot AI nổi lên trong thời gian gần đây với khả năng trò chuyện và trả lời về hầu như mọi lĩnh vực trong cuộc sống. Dù còn nhiều tranh cãi về tính đúng sai của dữ liệu nhưng không thể p...', 'Xin chào tất cả các bạn!

Nhân dịp năm mới xin chúc tất cả các bạn đọc của Viblo một năm an khang thịnh vượng, đạt được nhiều thành công trong sự nghiệp và cuộc sống!

Chắc hẳn các bạn đều biết tới ChatGPT, 1 con bot AI nổi lên trong thời gian gần đây với khả năng trò chuyện và trả lời về hầu như mọi lĩnh vực trong cuộc sống. Dù còn nhiều tranh cãi về tính đúng sai của dữ liệu nhưng không thể phủ nhận được sức mạnh rất lớn của công cụ này cũng như AI trong việc giúp tăng năng suất của con người trong nhiều ngành nghề khác nhau như lập trình, marketing,…

Trong bài viết này, chúng ta sẽ sử dụng API của nó để viết 1 ứng dụng đơn giản hỗ trợ người dùng trong việc học tiếng Anh, và cụ thể hơn là tối ưu việc viết bài luận IELTS Writing và Speaking.

Và tất nhiên, khá nhiều đoạn code trong ứng dụng này được chính ChatGPT viết 😃

Vì OpenAI chưa mở public đến API của chính ChatGPT, nên mình sẽ sử dụng API Text Completion với tính năng generate text tương tự như ChatGPT.

Các bạn có thể tham khảo ở đây.

[OpenAI API](https://platform.openai.com/docs/guides/completion)

Các tính năng của ứng dụng này bao gồm:

- Từ kiểu bài luận: IELTS Writing task 2 và đề bài do người dùng nhập, ứng dụng cung cấp gợi ý, tạo bài mẫu
- Chỉnh sửa lỗi, gợi ý câu văn, giải thích nghĩa của từ,… dựa theo đoạn văn bản người dùng đã nhập và đề bài luận

Các bạn có thể check source code của project ở đây.

[https://github.com/ngviethoang/ai-writing-assistant](https://github.com/ngviethoang/ai-writing-assistant)

Demo ứng dụng.

[Writing Assistant](https://ai-writing-assistant.vercel.app/)

## Cài đặt

Khởi tạo NextJS project

```powershell
yarn create next-app --typescript
```

Cài đặt các thư viện: OpenAI client, ChakraUI (UI framework)

```powershell
yarn add @chakra-ui/react @emotion/react @emotion/styled framer-motion
yarn add openai
```

### Đăng ký OpenAI API key

Đăng nhập tài khoản OpenAI tại trang [https://platform.openai.com/](https://platform.openai.com/)

Tạo API Secret Key

![](https://images.viblo.asia/8a84c294-2edb-49a3-b4d7-8650c4ad099d.png)

Tạo file `.env` trong project và lưu secret key

```tsx
OPENAI_API_KEY=[Nhập key đã tạo]
```

Thêm file `.env` này vào file `.gitignore` để tránh bị lộ key khi commit code

### Tạo prompt để giao tiếp với API

Để giao tiếp với Text Completion API, ta cần sử dụng các câu truy vấn (prompt). Đây là bước quan trọng để có thể ra được output chính xác như những gì ta mong muốn. Theo thuật ngữ trong NLP là *prompt engineering*.

Ví dụ như 1 prompt mẫu để tạo outline mẫu cho bài viết theo đề bài của IELTS Writing task:

```
Act as an IELTS test taker with a band score of 8.0. Write an essay outline in response to the following IELTS Writing Task 2 question: [insert IELTS Writing Task 2 question]
```

Ở đây ta có thể định nghĩa các parameter có thể truyền lên từ UI:

- `actor`: an IELTS test taker with a band score of 8.0
- `question`: IELTS Writing Task 2 question
- `content`: đoạn text do người dùng nhập

Tạo hàm xây dựng prompt dùng cho việc truy vấn API dựa trên các parameter `actor`, `question`, `content`.

```tsx
const getPrompt = (topicType: string, promptType: string, topic: string, content: string) => {
  let actor, questionType
  switch (topicType) {
    case ''IELTS Writing'':
      questionType = ''IELTS Writing Task 2''
      actor = ''an IELTS test taker with a band score of 8.0''
      break
    case ''IELTS Speaking'':
      questionType = ''IELTS Speaking''
      actor = ''an IELTS test taker with a band score of 8.0''
      break
    default:
      questionType = ''''
      actor = ''a person''
      break
  }

  switch (promptType) {
		case ''outline'':
      return `Act as ${actor}. Write an essay outline in response to the following ${questionType} question: ${topic}`
    case ''support_arguments'':
      return `Act as ${actor}. Given the following ${questionType} question, generate 3 arguments to support the statement: ${topic}`
    case ''oppose_arguments'':
      return `Act as ${actor}. Given the following ${questionType} question, generate 3 arguments to oppose the statement: ${topic}`
    case ''sample_answer'':
      return `Act as ${actor}. Write an essay in response to the following ${questionType} question with at least 250 words: ${topic}`

    case ''summarize'':
      return `Act as a summarizer and summarize this essay:
${content}`
		// ...

    default:
      return ''''
  }
}
```

### Tạo API handler trong NextJS

Để tạo API handler xử lý kết quả truy vấn từ Text Completion, tạo API route trong thư mục `pages/api/prompt.ts`

```tsx
import type { NextApiRequest, NextApiResponse } from ''next''
import { Configuration, OpenAIApi } from ''openai'';

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

const isEmpty = (str: string) => !str.trim().length

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<any>
) {
  if (!configuration.apiKey) {
    res.status(500).json({
      error: {
        message:
          ''OpenAI API key not configured, please follow instructions in README.md'',
      },
    });
    return;
  }

  const question = req.body.question || '''';
  const topicType = req.body.topicType || '''';
  const promptType = req.body.promptType || '''';
  const content = req.body.content || '''';

  if (isEmpty(question) || isEmpty(topicType) || isEmpty(promptType)) {
    res.status(400).json({
      error: {
        message: ''Invalid args'',
      },
    });
    return;
  }

  const prompt = getPrompt(topicType, promptType, question, content)
  if (isEmpty(prompt)) {
    res.status(400).json({
      error: {
        message: ''Invalid prompt'',
      },
    });
    return;
  }

  try {
    const completion = await openai.createCompletion({
      model: ''text-davinci-003'',
      prompt,
      temperature: 0.5,
      max_tokens: 550,
    });
    res.status(200).json({ result: completion.data.choices[0].text });
  } catch (error: any) {
    if (error.response) {
      console.error(error.response.status, error.response.data);
      res.status(error.response.status).json(error.response.data);
    } else {
      console.error(`Error with OpenAI API request: ${error.message}`);
      res.status(500).json({
        error: {
          message: ''An error occurred during your request.'',
        },
      });
    }
  }
}
```

Các tham số trong Text Completion API được sử dụng

- `model`: sử dụng model text-davinci-003 mới nhất và mạnh nhất trong các GPT-3 model
- `prompt`: câu truy vấn đã build ở step trước
- `temperature`: quyết định độ ổn định của kết quả, temperature càng cao model ra kết quả càng đa dạng hơn
- `max_tokens`: số lượng token tối đa trả về, có thể giới hạn số lượng token trả  về mỗi prompt để giảm chi phí

## Code giao diện

Tiếp theo là phần frontend cho ứng dụng, mình sẽ viết các component cơ bản như

- Text editor để nhập câu hỏi, nội dung bài viết
- Các button dùng để gọi API tương ứng với các function như tạo outline bài viết, tạo bài viết sample, chữa lỗi chính tả, nhận xét,…
- Component hiển thị kết quả trả về từ API

Tạo các component và layout cho page bằng ChakraUI

```tsx
import { Box, Button, Heading, HStack, Select, Spinner, Text, Textarea, Tooltip, useToast, VStack } from ''@chakra-ui/react'';
import { useState } from ''react'';

const topicTypes = [''IELTS Writing'', ''IELTS Speaking''];

const Writing = () => {
  const [topicType, setTopicType] = useState(topicTypes[0]);
  const [question, setQuestion] = useState('''');
  const [content, setContent] = useState('''');
  const [selectedContent, setSelectedContent] = useState('''');

  return (
    <div style={{ position: ''relative'' }}>
      <VStack spacing={5} padding={5}>
        <VStack w={''100%''} spacing={2} alignItems="flex-start">
          <HStack alignItems="flex-start" w="100%" gap={2}>
            <Text>AI Type: </Text>
            <Select
              size={''sm''}
              w={40}
              value={topicType}
              onChange={(e) => setTopicType(e.target.value)}
            >
              {topicTypes.map((type) => (
                <option key={type} value={type}>
                  {type}
                </option>
              ))}
            </Select>
          </HStack>
          <HStack alignItems="flex-start" w="100%" gap={2}>
            <Text>Question: </Text>
            <Textarea
              value={question}
              onChange={(e) => setQuestion(e.target.value)}
            />
          </HStack>
        </VStack>

        <HStack spacing={5} alignItems="flex-start" w="100%">
          <VStack w="100%">
            <Textarea
              rows={20}
              value={content}
              onChange={(e) => setContent(e.target.value)}
              onSelect={(e: any) => {
                // lưu selection text để lấy gợi ý từ API cho các từ này
                e.preventDefault();
                const { selectionStart, selectionEnd }: any = e.target;
                const selectedText = content.slice(selectionStart, selectionEnd);
                setSelectedContent(selectedText);
              }}
            />
          </VStack>
          {/* render buttons và kết quả gợi ý */}
          <VStack alignItems="flex-start" w="100%"></VStack>
        </HStack>
      </VStack>
    </div>
  );
};

export default Writing;
```

Render các button để generate prompt và kết quả gợi ý từ API

```tsx
const generateButtons = [
  { name: ''Outline'', promptType: ''outline'', tooltip: ''Write an essay outline'' },
  {
    name: ''Supportive arguments'',
    promptType: ''support_arguments'',
    tooltip: ''generate 3 arguments to support the statement'',
  },
  {
    name: ''Opposite arguments'',
    promptType: ''oppose_arguments'',
    tooltip: ''generate 3 arguments to oppose the statement'',
  },
  // ... full list button in source code
];

const vocabButtons = [
  {
    name: ''Dictionary'',
    promptType: ''dictionary'',
    tooltip:
      ''Explain the meaning of the word and give me an example of how to use it in real life'',
  },
  { name: ''Synonyms'', promptType: ''synonyms'', tooltip: ''Give me 5 synonyms'' },
  { name: ''Antonyms'', promptType: ''antonyms'', tooltip: ''Give me 5 antonyms'' },
];

const [result, setResult] = useState({ title: '''', content: '''' });

const renderButtons = (buttons: any[], color: string, content: string, isDisabled: boolean) => {
  return (
    <HStack gap={1} wrap="wrap" alignItems="flex-start">
      {buttons.map((btn, i) => (
        <Tooltip key={i} hasArrow label={btn.tooltip}>
          <Button
            colorScheme={color}
            variant="outline"
            size="sm"
            isDisabled={isDisabled}
            onClick={async () => {
              setSelectContent();
              const resultContent = await queryPrompt(btn.promptType, content);
              if (resultContent) {
                setResult({ title: btn.name, content: resultContent });
              }
            }}
          >
            {btn.name}
          </Button>
        </Tooltip>
      ))}
    </HStack>
  );
};

return (
	// ...
	<VStack alignItems="flex-start" w="100%">
	  {renderButtons(generateButtons, ''blue'', content, false)}
		<Text fontSize="sm">For selection text: </Text>
		{/* chỉ enable các button khi content text được select */}
    {renderButtons(contentButtons, ''teal'', selectedContent, !selectedContent )}

		{!!result.title && (
	    <VStack alignItems="flex-start">
	      <Heading size="md">{result.title}</Heading>
	      <pre style={{ whiteSpace: ''pre-wrap'', fontFamily: ''inherit'' }}>
	        {result.content}
	      </pre>
	    </VStack>
	  )}
	</VStack>
	// ...
)
```

Kết quả trả về từ API:

![](https://images.viblo.asia/5605bade-1aa2-4880-b7bb-a1c249e6b9f0.png)

GPT API này có chi phí khá cao nên chúng ta có thể sử dụng cache để lưu lại kết quả các truy vấn trước đó.

Gọi API `/api/prompt` khi click các button trên để hiển thị kết quả gợi ý

```tsx
const toast = useToast();

const [loadingPrompt, setLoadingPrompt] = useState(false);

const queryPrompt = async (promptType: string, content: string) => {
  setLoadingPrompt(true);
  const response = await fetch(''/api/prompt'', {
    method: ''POST'',
    headers: {
      Accept: ''application/json'',
      ''Content-Type'': ''application/json'',
    },
    body: JSON.stringify({ topicType, promptType, question, content }),
  });
  const data = await response.json();
  setLoadingPrompt(false);
  if (!response.ok) {
    toast({
      title: ''Error'',
      description: data?.error?.message,
      status: ''error'',
      duration: 9000,
      isClosable: true,
    });
    return '''';
  }
  return (data.result || '''').trim();
};
```

Chạy ứng dụng

```tsx
npm run dev
```

Giao diện ứng dụng

![](https://images.viblo.asia/108fb60e-ee76-4d4e-af44-2d9cb9958fa4.png)

### Kết luận

Qua việc xây dựng ứng dụng này, hy vọng bạn đã nắm được cách để tích hợp AI vào ứng dụng của mình để phục vụ các use case khác như chatbot, gia sư dạy học, PT lên lịch tập,…

Hẹn gặp lại ở các bài viết sau!', '2023-02-10T03:59:05.000000Z', '2023-02-28T05:13:04.000000Z', '2023-02-10T03:45:34.000000Z'),
	('Series SolidJS - Tập 3: Reactivity primitives trong SolidJS', 'BQyJKjQW4Me', '8', 'unlisted', 'https://images.viblo.asia/81bcbde7-c61f-4b23-9846-691c77a1a48d.jpeg', 'Giới thiệu
Hello everyone, chúng ta lại gặp nhau nữa rồi ✌️\
Tập trước trong series mình đã chia sẻ về cách khởi tạo project  SolidJS và cách hoạt động cơ bản của 1 ứng dụng SolidJS.

Trong tập 3 này mình và các bạn sẽ cùng tìm hiểu về 📥 Reactivity primitives của SolidJS nhé.

Nội dung
* 📥 Reactivity primitives
    - Signals
    - Effects
    - Memo

"Reactivity primitives" là một khái niệm tro...', '## Giới thiệu
Hello everyone, chúng ta lại gặp nhau nữa rồi ✌️\
Tập trước trong series mình đã chia sẻ về cách khởi tạo project  **[SolidJS](https://www.solidjs.com/)** và cách hoạt động cơ bản của 1 ứng dụng SolidJS.

Trong tập 3 này mình và các bạn sẽ cùng tìm hiểu về 📥 **[Reactivity primitives](https://www.solidjs.com/guides/reactivity)** của **[SolidJS](https://www.solidjs.com/)** nhé.

## Nội dung
* 📥 **[Reactivity primitives](https://www.solidjs.com/guides/reactivity)**
    - *Signals*
    - *Effects*
    - *Memo*

**"Reactivity primitives"** là một khái niệm trong lập trình web và là một phần của các kỹ thuật xử lý tương tác của người dùng trên giao diện. Nó bao gồm các phương thức cơ bản để **xử lý các sự kiện tương tác và cập nhật giao diện** theo thời gian thực.

`Vd: thao tác nhấn vào một nút trên web là một phương thức tương tác cơ bản và có thể được sử dụng để xử lý sự kiện nhấp chuột hoặc gõ từ bấm phím.`

-----

###  **[Reactivity primitives](https://www.solidjs.com/guides/reactivity)** - Signals là gì?

Là một trong những định nghĩa nền tảng của **reactivity primitives** trong Solid, nó thể hiện 1 trạng thái, 1 giá trị, 1 chức năng, dữ liệu hay tín hiệu mà bạn cần thể hiện trong giao diện...

khi bạn thay đổi giá trị của **signals**, nó sẽ tự động cập nhật đến bất kì nơi nào và bất kì thứ gì đang sử dụng giá trị của **signals** đó.

Khởi tạo 1 signals:

```jsx
import { createSignal } from "solid-js";

const [count, setCount] = createSignal(0);
```

Ở đây chúng ta có thể hiểu như sau:

- Đối số mang giá trị **`0`** được truyền cho hàm **`createSignal()`** được gọi là **giá trị khởi tạo**.
- Giá trị trả về là một mảng có gồm hai hàm chức năng. Sử dụng **destructuring** trong Javascript để có thể thể đặt tên cho các function này. Mình đặt tên cho hàm getter là `count` và setter là `setCount` nhé.
- Ở ví dụ trên nếu chúng ta muốn log ra giá trị `count` thì sẽ không được, thay vào đấy chúng ta phải gọi hàm `count()` để nhận được giá trị trả về như mong muốn.
```jsx
console.log(count) // không trả về giá trị
console.log(count()) // 0
```
- Hàm `setCount()` dùng để cập nhật lại giá trị trả về (số đếm)

```jsx
// Chúng ta có 2 cách viết như sau
setCount(count() + 1)
setCount(c => c + 1)
```

> Bạn có thấy syntax giống trong ReactJS không? 😁
> Hãy comment cho mình biết Signals có gì giống hay khác với **`useState`** trong **ReactJS** nhé.

###  **[Reactivity primitives](https://www.solidjs.com/guides/reactivity)**  -  Effects là gì?

Signals là các giá trị mà ta có thể theo dõi và sử dụng, nhưng chúng chỉ là một nửa của câu chuyện.

**Effects** thực thi dựa vào sự thay đổi giá trị của Signals. Lúc này **Effects** tạo ra một `side effect` (tác dụng phụ) phụ thuộc vào tín hiệu Signals.

```jsx
const [count, setCount] = createSignal(0);

createEffect(() => {
    console.log("The count is now", count());
});
```

Mình có 1 ví dụ nhỏ về việc đếm số như sau:

```jsx
import { render } from ''solid-js/web'';
import { createSignal, createEffect } from ''solid-js'';

function Counter() {
  const [count, setCount] = createSignal(0);

  createEffect(() => {
    console.log("The count is now", count());
  });

  return <button onClick={() => setCount(count() + 1)}>
            Click Me {count()}
         </button>
}

render(() => <Counter />, document.getElementById(''app''))
```
> Các bạn có thể copy đoạn code trên và paste vào https://playground.solidjs.com/ để chạy vd trực tiếp nhé, hoặc bạn có thể thử ngay trên chính source code đã tạo ở tập trước ^^

Mình sẽ giải thích vd trên như sau:

- Chúng ta đã khởi tạo 1 Signals với giá trị là 0
- Sau đấy tiếp tục chúng ta sử dụng hàm **createEffect()** và truyền vào trong đó 1 function để log (hiển thị trên `tab Console`) ra giá trị số đếm hiện tại `count()`
- Tiếp đến ở phần giao diện ta có 1 button, khi click sẽ tăng số đếm lên +1 đơn vị

Khi chúng ta sử dụng hàm **createEffect()** nó sẽ luôn tạo ra 1 phản ứng phụ (side effect) để cho ta biết được giá trị `count()` thay đổi ra sao

Trước khi chúng ta click vào button `Click Me` thì side effect này đã được thực thi và nó đã `console.log("The count is now", count())` ra giá trị khởi tạo **(initial value)** ban đầu chính là số **`0`**


![](https://images.viblo.asia/cf481d67-3a0e-4a60-b56e-af35cc86d87e.png)


Tiếp sau đấy mỗi lần chúng ta click vào button `Click Me` thì giá trị số đếm `count()` sẽ tăng lên 1 đơn vị --> cũng đồng nghĩa với việc xảy ra 1 side effect (phản ứng phụ) `console.log("The count is now", count())`

![](https://images.viblo.asia/8b29c0d2-17f5-4ecd-88d9-37654f0c1a52.png)

----

> Bạn cũng có thể sử dụng nhiều hàm **createEffect()**, mỗi Effect sẽ sinh ra `side effect` theo từng Signal trong cùng 1 **Component <Counter/>**

```jsx
import { render } from ''solid-js/web'';
import { createSignal, createEffect } from ''solid-js'';

function Counter() {
  const [count, setCount] = createSignal(0);
  const [name, setName] = createSignal("Tùng Anh Nguyễn");

  createEffect(() => {
    console.log("The count is now", count());
  });

  createEffect(() => {
    console.log("My name is ", name());
  });

  const handleClick = () => {
    // Cách update signal gọi trực tiếp hàm getter là count()
    setCount(count() + 1)

    // Signal chấp nhận 1 hàm sử dụng giá trị trước đó đặt cho giá trị tiếp theo.
    setName(name => name + " (Jeremy)")
  }

  return <button onClick={handleClick}>Click Me: {name()} - {count()}</button>
}

render(() => <Counter />, document.getElementById(''app''))
```

![](https://images.viblo.asia/a72f823f-13d8-4114-b1c7-ceaf8350b617.png)


###  **[Reactivity primitives](https://www.solidjs.com/guides/reactivity)**  -  Memos là gì?


Hầu hết các công việc chúng ta gặp phải đều có thể sử dụng Signals là đủ yêu cầu. Tuy nhiên đôi lúc chúng ta sẽ gặp phải những trường hợp phải xử lý các công việc lặp đi lặp lại. Vậy đâu là giải pháp? 🧐


**`createMemo`** tạo ra tín hiệu (Signal) với công việc chính là đọc, tính toán lại giá trị của nó bất cứ khi nào giá trị có sự thay đổi, cập nhật.

Chúng ta sẽ sử dụng **`createMemo`** khi muốn lưu vào bộ nhớ đệm một số giá trị và truy cập chúng mà không cần xem xét việc truy xuất lại chúng, cho đến khi một giá trị phụ thuộc (dependence) thay đổi.

---

Ví dụ: mình muốn hiển thị số đếm `count()` 100 lần và cập nhật giá trị số đếm khi nhấp vào nút (button) ---> sử dụng **`createMemo()`** sẽ cho phép việc tính toán lại chỉ xảy ra một lần cho mỗi lần click

```jsx

import { render } from ''solid-js/web'';
import { createSignal, createMemo } from ''solid-js'';

function Counter() {
   const [count, setCount] = createSignal(0);
   // Nếu chúng ta không bọc nó trong createMemo
   // Việc tính toán và thể hiện giá trị sẽ xảy ra 100 lần cho mỗi lần click
   // const counter = () => {
   //    return count();
   // }

    // Ngược lại nếu chúng ta bọc nó trong createMemo
    // Việc tính toán lại và thể hiện giá trị chỉ xảy ra một lần cho mỗi lần click
   const counter = createMemo(() => {
       return count()
   })

   return (
       <>
       <button onClick={() => setCount(count() + 1)}>Count: {count()}</button>
       <div>1. {counter()}</div>
       <div>2. {counter()}</div>
       <div>3. {counter()}</div>
       <div>4. {counter()}</div>
       <div>5. {counter()}</div>

       <p>95 more times...</p>
       </>
   );
}

render(() => <Counter />, document.getElementById(''app''))
```

```jsx
   // Nếu chúng ta không bọc nó trong createMemo
   // Việc tính toán và thể hiện giá trị sẽ xảy ra 100 lần cho mỗi lần click
   const counter = () => {
      return count();
   }

    // Ngược lại nếu chúng ta bọc nó trong createMemo
    // Việc tính toán lại và thể hiện giá trị chỉ xảy ra một lần cho mỗi lần click
   const counter = createMemo(() => {
       return count()
   })
```

Điều này rất có lợi cho việc tính toán và sử dụng bộ nhớ của các effect, dữ liệu có các thành phần phụ thuộc và hơn hết là **giảm thiểu công việc** cần phải làm **cho các hoạt động tốn kém** hiệu suất như tạo DOM, tính toán giá trị....



## Tổng kết lại tập 3 thôi nào

Tập 3 này chúng ta đã cùng tìm hiểu về các tính năng chính của **[Reactivity primitives](https://www.solidjs.com/guides/reactivity)** như *Signals*, *Effects* và *Memos*

Trong tập sau mình sẽ cùng đi vào phần tiếp theo:
* 🔄 **[Lifecycle methods](https://www.solidjs.com/docs/latest/api#lifecycles)**
    - *onMount*
    - *onCleanup*
    - *onError*

Cảm ơn các bạn đã theo dõi tập 3 trong series về **[SolidJS](https://www.solidjs.com/)**. Nếu các bạn có thắc mắc hoặc góp ý về bài viết hãy **comment** giúp mình nhé, cảm ơn các bạn 😘

Series SolidJS - Tập 4: https://viblo.asia/p/series-solidjs-tap-4-lifecycle-vong-doi-trong-solidjs-y37Ldw3yJov

### Tham khảo
https://www.solidjs.com/tutorial/introduction_signals
https://www.solidjs.com/tutorial/introduction_effects
https://www.solidjs.com/tutorial/introduction_memos', '2023-02-09T19:40:03.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-19T15:05:18.000000Z'),
	('Ref và Reactive trong Vue 3', 'm2vJPORl4eK', '9', 'unlisted', 'https://images.viblo.asia/c71c8d77-fc56-4903-bf5a-5f64e41474ae.png', 'Trong Vue 3 có hai Reactivity API mà dễ làm newbie gây nhầm lẫn khi sử dụng đó là ref và reactive. Bài viết này mình sẽ hướng dẫn cách sử dụng 2 API trên, kèm một số so sánh với Vue 2 cho những ai mới chuyển từ Vue 2 lên Vue 3.

Ref

Ví dụ đơn giản khi thay đổi một reactive state bằng Vue 2:

Chức năng tương tự nhưng sử dụng ref() trong Vue 3:

Để hiểu rõ hơn về nguyên lý hoạt động của ref(), c...', 'Trong Vue 3 có hai [Reactivity API](https://vuejs.org/api/reactivity-core.html) mà dễ làm newbie gây nhầm lẫn khi sử dụng đó là [ref](https://vuejs.org/api/reactivity-core.html#ref) và [reactive](https://vuejs.org/api/reactivity-core.html#reactive). Bài viết này mình sẽ hướng dẫn cách sử dụng 2 API trên, kèm một số so sánh với Vue 2 cho những ai mới chuyển từ Vue 2 lên Vue 3.

## Ref

Ví dụ đơn giản khi thay đổi một *reactive state* bằng Vue 2:

```javascript
<template>
  <h1>Count: {{ count }}</h1>

  <button @click="increaseCount">Increase Count</button>
</template>

<script>
export default {
  data() {
    return {
      count: 0,
    };
  },

  methods: {
    increaseCount() {
      this.count++;
    },
  },
};
</script>
```

Chức năng tương tự nhưng sử dụng **ref()** trong Vue 3:

```javascript
<template>
  <h1>Count: {{ count }}</h1>

  <button @click="increaseCount">Increase Count</button>
</template>

<script>
import {ref} from "vue";

export default {
  setup() {
    // Tạo 1 reactive state count = 0
    // (count ở đây là một Proxy object chứ không phải number)
    const count = ref(0);

    const increaseCount = () => {
      // Tăng giá trị của count bằng cách cập nhật giá trị thuộc tính value
      count.value++;
    };

    return {
      count,
      increaseCount,
    };
  },
};
</script>
```

Để hiểu rõ hơn về nguyên lý hoạt động của **ref()**, các bạn nên tìm hiểu thêm về [Proxy trong Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy).

**Một số chú ý về ref():**

- Chúng ta có thể lưu dữ liệu gì vào _ref object_ cũng được.

- Ref object là _mutable_, khi cần thay đổi giá trị thì có thể thay đổi trực tiếp thuộc tính **value** của nó. Tuy nhiên khi dùng ref object ở template thì chúng ta không cần **.value** vì nó được tự động _unwrap_.

## Reactive

Trong đa số trường hợp, chúng ta chỉ cần dùng **ref()** là đủ. Vậy dùng **reactive()** để làm gì?

**reactive()** hoạt động tương tự **ref()** nhưng nó chỉ nhận tham số là object, không nhận các kiểu dữ liệu _primitives_ (number, string, boolean). Và chúng ta thay đổi giá trị của _reactive object_ bằng cách thay đổi các thuộc tính của nó (thay vì thay đổi thuộc tính _value_ như _ref_). Ví dụ ở trên viết lại bằng **reactive()**:

```javascript
<template>
  <h1>Count: {{ state.count }}</h1>

  <button @click="increaseCount">Increase Count</button>
</template>

<script>
import {reactive} from "vue";

export default {
  setup() {
    // Tạo 1 reactive state có thuộc tính count = 0
    const state = reactive({count: 0});

    const increaseCount = () => {
      // Tăng giá trị của thuộc tính count
      state.count++;
    };

    return {
      state,
      increaseCount,
    };
  },
};
</script>
```

Về bản chất **ref()** là một hàm wrap lại **reactive** (bên trong _ref()_ sử dụng _reactive()_), nên trong đa số trường hợp chúng ta có thể sử dụng hầu hết **ref()** cho đồng bộ và đỡ phải nhớ nhiều, chỉ cần chú ý khi thay đổi giá trị của _ref object_ phải thông qua thuộc tính _value_. Bạn cũng có thể dùng **reactive** khi muốn tạo 1 state tập trung để đỡ phải tạo nhiều biến, ví dụ:

```javascript
// Dùng ref()
const isLoading = ref(false);
const isError = ref(false);
const user = ref({
  name: "Robin",
  role: "Admin",
});

// Dùng reactive()
const state = reactive({
  isLoading: false,
  isError: false,
  user: {
    name: "Robin",
    role: "Admin",
  },
});
```

Chú ý khi dùng **reactive** chúng ta chỉ được truyền vào một object và khi update thì sẽ update các thuộc tính của object đó, chứ không dùng phép gán trực tiếp vào _reactive object_. Ví dụ như sau là sai:

```javascript
<template>
  <h1>User name: {{ user.name }}</h1>
  <h1>User role: {{ user.role }}</h1>

  <button @click="updateUser">Update</button>
</template>

<script>
import {reactive} from "vue";

export default {
  setup() {
    // Tạo 1 reactive object user
    const user = reactive({name: "Robin", role: "Admin"});

    const updateUser = () => {
      // Ví dụ dữ liệu mới lấy từ form, api, ... sau đó update trực tiếp bằng phép gán

      // Code sai
      user = {name: "Huy", role: "Staff"};
    };

    return {
      user,
      updateUser,
    };
  },
};
</script>
```

Ở dòng 20 ví dụ trên là code sai do chúng ta gán giá trị cho biến user thành một object mới. Nếu ở lúc khai báo dùng `const` thì sẽ báo lỗi luôn, còn nếu dùng `let` thì code đúng cú pháp nhưng khi bấm nút thì giao diện không update do biến **user** không còn là _reactive object_ nữa, chỉ là một object bình thường. Có thể sửa lại bằng cách cập nhật từng thuộc tính một:

```javascript
user.name = "Huy";
user.role = "Staff";
```

Hoặc sử dụng `ref()`:

```javascript
<template>
  <h1>User name: {{ user.name }}</h1>
  <h1>User role: {{ user.role }}</h1>

  <button @click="updateUser">Update</button>
</template>

<script>
import {ref} from "vue";

export default {
  setup() {
    // Tạo 1 ref object user
    const user = ref({name: "Robin", role: "Admin"});

    const updateUser = () => {
      // Cập nhật ref object qua thuộc tính value
      user.value = {name: "Huy", role: "Staff"};
    };

    return {
      user,
      updateUser,
    };
  },
};
</script>
```

---
*Nguồn: [https://huydq.dev](https://huydq.dev).*', '2023-02-09T17:11:03.000000Z', '2023-02-28T03:49:11.000000Z', '2023-02-09T17:13:30.000000Z'),
	('Resolved React refresh webpack plugin throws $RefreshSig$ is not defined', 'MG24BwRzJz3', '10', 'unlisted', '', 'While using Babel transform and the webpack hot reload middleware approach, and after build the project in PROD mode, an uncaught ReferenceError:  is not defined error thrown in console.

Per react-refresh-webpack-plugin docs :
Ensure both the Babel transform (react-refresh/babel) and this plugin are enabled only in development mode!

and the packages:
- "@pmmmwh/react-refresh-webpack-plugin": ...', 'While using Babel transform and the webpack hot reload middleware approach, and after build the project in PROD mode, an uncaught ReferenceError: **$RefreshSig$** is not defined error thrown in console.

Per `react-refresh-webpack-plugin` [docs](https://github.com/pmmmwh/react-refresh-webpack-plugin "docs") :
> Ensure both the Babel transform (react-refresh/babel) and this plugin are enabled only in development mode!

and the packages:
- `"@pmmmwh/react-refresh-webpack-plugin": "^0.5.4"`,
- `"react-refresh": "^0.11.0"`,
- `"webpack": "5.66.0"`,

This is my solution:

```
const mode = process.env.WEBPACK_SERVE ? ''development'' : ''production'';
module.exports = {
  module: {
    rules: [
      {
        test: /\.(ts|js)x?$/,
        exclude: /node_modules/,
        use: {
          loader: ''babel-loader'',
          options: {
            presets: [''@babel/preset-react'', ''@babel/preset-env'', ''@babel/preset-typescript''],
            plugins: [''@babel/plugin-transform-runtime'', mode!=''production'' && require.resolve(''react-refresh/babel'')].filter(Boolean),
          },
        },
      },
...
```

Nam Le - https://nready.net/?p=1335,', '2023-02-09T15:43:47.000000Z', '2023-02-27T13:38:04.000000Z', '2023-02-09T15:41:25.000000Z'),
	('Các bài viết ngắn phần 24', 'GyZJZnr8Jjm', '11', 'unlisted', '', 'Cơ sở dữ liệu và ngữ cảnh sử dụng
Có rất nhiều loại cơ sở dữ, phải đến hàng trăm loại, phổ biến hiện nay như PostgresSQL, Oracle, MySQL, MariaDB, SQLite, MongoDB, S3, Ceph, …

Có thể phân thành nhiều nhóm và ngữ cảnh sử dụng như sau:

– Relational Database: cơ sở dữ liệu quan hệ, có thể sử dụng cho đa số các mục đích
ví dụ: Oracle, mySQL, PostgresSQL, SQL Server, …

– In-memory store: tốc độ nh...', '## Cơ sở dữ liệu và ngữ cảnh sử dụng
Có rất nhiều loại cơ sở dữ, phải đến hàng trăm loại, phổ biến hiện nay như PostgresSQL, Oracle, MySQL, MariaDB, SQLite, MongoDB, S3, Ceph, …

Có thể phân thành nhiều nhóm và ngữ cảnh sử dụng như sau:

– **Relational Database**: cơ sở dữ liệu quan hệ, có thể sử dụng cho đa số các mục đích
ví dụ: Oracle, mySQL, PostgresSQL, SQL Server, …

– **In-memory store**: tốc độ nhanh và kích thước dữ liệu hạn chế do đó lý tưởng cho các loại dữ liệu tính toán hay sử dụng nhanh (caches)
ví dụ: Redis, Hazelcast, Aerospike, …

– **Time-series databas**e: lưu trữ và quản lý dữ liệu đánh dấu theo thời gian
ví dụ: InfluxDB, Prometheus, Aeroskipe, …

– **Graph database**: phù hợp với dữ liệu nhiều quan hệ phức tạp và phi cấu trúc
ví dụ: Neo4j, OrientDB, ArangoDB, …

– **Document store**: kho tài liệu phù hợp các dữ liệu lớn ít hay không thay đổi
ví dụ: Amazon DynamoDB, MongoDB, …

– **Wide column store**: sử dụng cho dữ liệu lớn, như phân tích, báo cáo, các dữ liệu không chuẩn hoá
ví dụ: Microsoft Azure Cosmos DB, ScyllaDB, Amazon Keyspaces, …

[Ref link](https://blog.bytebytego.com/p/ep36-types-of-databases-and-use-cases)

## Các bài viết trên blog được yêu thích (cập nhật)
Số lượng hot blog posts của blog BeautyOnCode đã từ số 16 lên con số 49 trong 3 tháng nha mọi người ^^

Một số bài gần đây cập nhật thêm:
– [BeautyOnCode đạt top 1 trên Careerly](https://beautyoncode.com/beautyoncode-dat-top-1-tren-careerly/)
– [Vấn đề của cuộc sống](https://beautyoncode.com/van-de-cua-cuoc-song/)
– [Lexical Enviroment trong JavaScript](https://beautyoncode.com/lexical-environment-trong-javascript/)
– [Chơi cùng JavaScript](https://beautyoncode.com/choi-cung-javascript/)
– [Mảng trong JavaScript](https://beautyoncode.com/array/)
– [Khai báo biến với var, let, const trong JavaScript](https://beautyoncode.com/khai-bao-bien-voi-var-let-va-const-trong-javascript/)
– [CSS trong JS là gì?](https://beautyoncode.com/css-trong-js-la-gi/)
– [Điều gì xảy ra khi chạy chương trình JavaScript?](https://beautyoncode.com/dieu-gi-xay-ra-khi-chay-mot-chuong-trinh-javascript/)

Mọi người ghé đọc nha <3

Sắp đến mình có dự định gửi newsletter cho mọi người tổng kết các nội dung từ blog BeautyOnCode, các bạn đăng ký để vào [mail list này](https://beautyoncode.us5.list-manage.com/subscribe?u=617ec2445e7ed8052b2f9b41a&id=b8b61cb15d) nhé.
Các newsletter đã gửi:

– [BeautyOnCode #1 Newsletter](http://mailchi.mp/1479bb9acd6f/beautyoncode-1-newsletter)

– [BeautyOnCode #2 Newsletter](https://mailchi.mp/ee10732252bb/beautyoncode-2-newsletter)

## State of CSS 2022

State of CSS là cuộc khảo sát hàng năm về các xu hướng mới nhất của CSS.

**Bạn nghĩ mình đã biết gì về CSS?**
Xem qua khảo sát này để biết thế giới đang dùng gì và bạn đang dùng gì nhé ^^

CSS đã phát triển thành một ngôn ngữ mạnh nhờ các tiến bộ từ Flexbox, Grid và CSS Variables.
Danh sách các tính năng có thể làm thay đổi cuộc chơi như parent selector, native nesting, container layer, cascade layer, … sẽ khiến bạn sốc đấy ^^

**Danh sách các chủ đề:**

– **Features**: bao gồm nhiều loại cú pháp, từ khoá

– **Layout**: cách các thành phần hiển thị trên trang như subgrid, writing modes, css logical properties, aspect-ratio, content-visibility, flexbox gap, @container, object-view-box, viewport percent length unit, media queries range context

– **Shape & Graphics**: blend-mode, filters & effects, backdrop filter, intrinsic sizing, conic-gradient(),

– **Colors**: colors(), accent-color, curentcolor, color-mix, wide gamut color, relative colors, gradient color spaces

– **Interaction**: scroll snap, overscroll behavior, touch action, scroll behavior, scrollbar-gutter

– **Typography**: font-display, line-clamp, variable fonts, font palette,

– **Accessibility**: prefer reduced motion, prefer color scheme, prefer reduced data, color constrast, color scheme, prefers constrast, forced-color, :focus-visibile

– **Selectors**: `::marker`, `:has()`, `:where()`

Ở mỗi phần sẽ bao gồm tỉ lệ số người biết và số người sử dụng, link CanIUse để kiểm tra support, link MDN để tìm hiểu thêm, và các resource gợi ý để bạn tìm hiểu thêm.

https://2022.stateofcss.com/

## Kỹ năng tìm kiếm thông tin

Kỹ năng tìm kiếm thông tin (research)

> Research skills refer to the ability to search for, extract, organize, evaluate and use or present information that is relevant to a particular topic.

Tạm dịch:
Kỹ năng nghiên cứu là nói đến khả năng biết tìm kiếm, phân loại, đánh giá và sử dụng thông tin liên qua đến một chủ đề cụ thể.

Qua định nghĩa trên thì kỹ năng này có thể chia thành các kỹ năng nhỏ sau:

**1. Tìm kiếm thông tin:**
– học cách tìm kiếm, các mẹo tìm kiếm hiệu quả
– sử các từ khoá phù hợp
– đọc là chìa khoá để tìm các từ khoá về các chủ đề, e có thể đọc sách,
– các bài báo, blog, các newsletters
– lại search để tìm từ khoá “keyword for …”
– hỏi người có kinh nghiệm hơn để tìm gợi ý

**2. Trích xuất và phân loại thông tin:**
– ghi lại những gì bạn đọc được
– phân loại nội dung theo chủ đề

**3. Sử dụng nội dung**
– chia sẻ nội dung bạn ghi lại
– thảo luận chủ đề bạn tìm hiểu
– viết các note tổng hợp theo chủ đề

Bạn ghé đọc thêm về cách nguồn tài nguyên mình gợi ý trong blog [này](https://beautyoncode.com/ky-nang-tim-kiem-thong-tin/) nha.

## Security dành cho developer

Hôm qua mình có tham gia nghe buổi chia sẻ của anh HieuPC, chuyên gia về bảo mật do cộng đồng Dwarves Foudation tổ chức.

Dưới đây là một vài note muốn chia sẻ đến bạn.

Lập trình viên thường tập trung phát triển sản phẩm, một ngày nào đó bị hack thì sẽ bảo mật sau.
–> đây là mindset chưa đúng và có thể gây hậu quả nghiêm trọng cho dự án, khách hàng và công ty.

**An ninh mạng (cybersecurity) chia làm 4 yếu tố:**

1. credentiality – bảo mật tài nguyên hệ thống
2. competence – nói về năng lực, mỗi con người tham gia nên làm công việc phù hợp với khả năng của mình. Tránh tình trạng không biết mà cố làm gây những lỗi, hạn chế gây ảnh hưởng hệ thống
3. intellectual property rights – vấn đề quyền sở hữu, ví dụ như việc sử dụng các resource như code sẽ có các loại license khác nhau.
4. computer abuse – không dùng kỹ năng về bảo mật để làm hại người khác

Việc bảo vệ dữ liệu khách hàng sẽ làm tăng uy tín công ty. Một công ty bị lộ thông tin người dùng thì tỉ lệ bị tẩy chay rất cao (30%).

**Hướng dẫn về bảo mật:**
– bảo mật ngay từ đầu
– phòng bệnh hơn chữa bệnh
– luôn kiểm tra lỗi bảo mật
– xây dựng cơ sở hạ tầng

Tất cả các tài khoản quan trọng cần bật bảo mật 2 bước, vì mỗi mật khẩu thôi thì không đủ.

**Lập trình viên nên:**
– tìm hiểu thêm về các chuẩn bảo mật
– thường xuyên thực hiện core review
– tập trung vào functional requirement
– đưa ra guideline về bảo mật cho dự án, áp bảo mật vào từng giai đoạn phát triển sản phẩm
– tìm hiểu và áp dụng OWAP top 10 (https://owasp.org/www-project-top-ten/)
– tìm hiểu thêm cheatsheet series owap (https://cheatsheetseries.owasp.org/)
– tìm hiểu về security requirements của từng loại công nghệ, tải về benchmark để tìm hiểu thêm (https://www.cisecurity.org/cis-benchmarks/)

**Một số nguồn tìm hiểu về bảo mật:**
– https://www.securecodewarrior.com/ (trial 14 days – good resource to learn & practice)
– https://portswigger.net/web-security (free)

Anh HiếuPC cũng chia sẻ rất nhiều về bảo mật trên các kênh của anh ấy, mọi người có thể tìm kiếm thêm nhé.

---

Nội dung này thuộc BeautyOnCode’s short posts là các bài viết ngắn tóm tắt nội dung và ý kiến cá nhân từ các nguồn như các slack channels (công ty, cộng đồng), các newsletters, …

Bài viết này đăng từ bài gốc của blog BeautyOnCode tại [đây](https://beautyoncode.com/cac-bai-viet-ngan-phan-24/).

BeautyOnCode.', '2023-02-09T15:30:33.000000Z', '2023-02-27T12:20:07.000000Z', '2023-02-09T15:28:56.000000Z'),
	('[Phần 2] Trò chơi Audition - Xây dựng chức năng nhảy 8K với JavaScript', 'EoW4ogPl4ml', '1', 'unlisted', 'https://images.viblo.asia/be6fc692-1fe8-44f2-88d4-c3819cc139d4.jpg', 'Quý Mão 2023 - Đây là một thời điểm mới, một cơ hội mới để chúng ta cùng nhau tiếp tục sáng tạo và phát triển cộng đồng Viblo trở nên phổ biến và vững mạnh hơn.

Chúc mừng năm mới 2023, chúc mừng mọi người sức khỏe tốt, hạnh phúc gia đình, thành công trong công việc và tình yêu. Hãy cùng nhau tạo ra những kỷ niệm đẹp trong năm nay và sáng tạo những ước mơ mới.
1. Giới thiệu

Audition - Một tựa ...', 'Quý Mão 2023 - Đây là một thời điểm mới, một cơ hội mới để chúng ta cùng nhau tiếp tục sáng tạo và phát triển cộng đồng Viblo trở nên phổ biến và vững mạnh hơn.

Chúc mừng năm mới 2023, chúc mừng mọi người sức khỏe tốt, hạnh phúc gia đình, thành công trong công việc và tình yêu. Hãy cùng nhau tạo ra những kỷ niệm đẹp trong năm nay và sáng tạo những ước mơ mới.
# 1. Giới thiệu

**Audition** - Một tựa game online mỗi khi nhắc tới thì đại đa số thế hệ 8x và 9x đời đầu sẽ bất chợt có cảm giác bồi hồi, xao xuyến với bao nhiêu kỉ niệm ùa về 😊😊😊 Là thế hệ giữa 9x nhưng may sao ngày bé, mình được các ông anh dẫn đi NET cỏ đưa mình vào con đường nghiện game online ngày ấy... 😃

![image.png](https://images.viblo.asia/5c044c3a-62ab-46a8-95c2-143011f818a0.png)

Ở [Phần 1](https://viblo.asia/p/phan-1-tro-choi-audition-xay-dung-chuc-nang-co-ban-voi-javascript-bJzKmD1E59N) mình đã hướng dẫn mọi người xây dựng các tính năng cơ bản : select music, dance with type 4K, 4K reverse, tính điểm,... Trong bài viết ở phần 2 này, mình sẽ hướng dẫn thêm chức năng dance with type 8K and 8K reverse, chức năng home page để chọn lựa kiểu nhảy và chọn nhạc.

Mình hi vọng sẽ được sự đón nhận, phản hồi từ mọi người để game được tốt và nhiều chức năng hơn 😘

# 2. Home page Audition

```html
<h1>Guide</h1>
<table>
    <tr class="heading">
        <th>Button</th>
        <th>Content</th>
    </tr>
    <tr>
        <td>Del</td>
        <td>Dance with reverse button</td>
    </tr>
    <tr>
        <td>⬆ ⬇ ⬅ ➡</td>
        <td>Up Down Left Right</td>
    </tr>
    <tr>
        <td>↖ ↙ ↗ ↘</td>
        <td>Left-Up Left-Down Right-Up Right-Down</td>
    </tr>
</table>

<div>
    <div class="options" >
        <label for="list-music"></label><select id="list-music" class="hide-option option">
        <option selected="selected" disabled="disabled" value="">Select music</option>
        <option value="https://firebasestorage.googleapis.com/v0/b/tuvandaihoc-c8a1c.appspot.com/o/Waiting%20For%20You%20-%20MONO_%20Onionn.mp3?alt=media&token=a10b4da9-9967-4dc4-b120-76c7e08e13e2">Waiting For You - Mono</option>
        <option value="https://firebasestorage.googleapis.com/v0/b/tuvandaihoc-c8a1c.appspot.com/o/dua%20nao%20lam%20em%20buon_%20-%20Phuc%20Du.mp3?alt=media&token=5123bcc3-3305-408c-adf9-e3cb3d95d8cd">Đứa nào làm em buồn? - Phúc Du</option>
        <option value="https://firebasestorage.googleapis.com/v0/b/tuvandaihoc-c8a1c.appspot.com/o/See%20Tinh%20-%20Hoang%20Thuy%20Linh.mp3?alt=media&token=87095bae-98a7-4d18-9573-2e129d0c136b">See Tình - Hoàng Thuỳ Linh</option>
    </select>
    </div>

    <div class="options" style="margin-top: 30px">
        <label for="list-type-dance"></label><select id="list-type-dance" class="hide-option option">
        <option selected="selected" disabled="disabled" value="">Select type dance</option>
        <option value="4k">4K Dance</option>
        <option value="8k">8K Dance</option>
    </select>
    </div>
</div>

<div class="button" id="button" onclick="handleLetGo()">Let''s go!</div>
```

- **home.html**: File này chứa giao diện trang chủ cho phép mọi người lựa chọn nhạc và kiểu nhảy ( Mình không phải dân chuyên Front-end nên html, css không tốt lắm nên các bạn cố gắng bỏ qua nha 😃😃😃 )

```javascript
function handleLetGo() {
    let music = document.getElementById("list-music").value;
    let typeDance = document.getElementById("list-type-dance").value;

    if (music === "" || typeDance === "") {
        alert("Vui lòng chọn nhạc và kiểu nhảy");
        return
    }
    window.location.href = "/game-development/games/audition/audition.html?music="+ music + "&type=" + typeDance;
}

window.addEventListener("load", (event) => {
    let music = LIST_MUSIC[Math.floor(Math.random()*LIST_MUSIC.length)];
    let audio = new Audio(music);
    audio.play().catch(function (error) {
        console.log("Chrome cannot play sound without user interaction first" + error)
    });
});
```

- **audition-home.js** : Xử lý khi load trang chủ sẽ random bật 1 bài nhạc chạy trong nền dựa vào sự kiện load. Mỗi khi người dùng lựa chọn nhạc và kiểu nhảy xong thì sẽ xử lý redirect vào trong giao diện chính của trò chơi.

# 3. Xử lý trò chơi cho chức năng nhảy 8K, 8K reverse

```javascript
const LIST_KEY_HAS_REVERSE_8K = ["right", "up", "down", "left", "right-reverse", "up-reverse", "down-reverse", "left-reverse", "right-up", "left-up", "right-down", "left-down", "right-up-reverse", "left-up-reverse", "right-down-reverse", "left-down-reverse"]
const LIST_KEY_8K = ["right", "up", "down", "left", "right-up", "left-up", "right-down", "left-down"]
const MAP_KEY_8K = new Map([
    ["right", "right"],
    ["up", "up"],
    ["down", "down"],
    ["left", "left"],
    ["right-reverse", "left"],
    ["up-reverse", "down"],
    ["down-reverse", "up"],
    ["left-reverse", "right"],
    ["right-up", "right-up"],
    ["left-up", "left-up"],
    ["right-down", "right-down"],
    ["left-down", "left-down"],
    ["right-up-reverse", "left-down"],
    ["left-up-reverse", "right-down"],
    ["right-down-reverse", "left-up"],
    ["left-down-reverse", "right-up"],
])
```

- LIST_KEY_8K : Danh sách phím bấm gồm 8 nút : lên, xuống, trái, phải, chéo phải lên, chéo phải xuống, chéo trái lên, chéo trái xuống
- LIST_KEY_HAS_REVERSE_8K : Danh sách phím bấm trường hợp nút ngược
- MAP_KEY_8K : Map lưu value nút tương ứng khi người chơi bấm. VD right : right, right-reverse : left,...

```javascript
function initAudio() {
    clearInterval(intervalID)

    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get(''music'') === null || urlParams.get(''type'') === null) {
        window.location.href = "../audition/home.html";
    }

    audio.src = urlParams.get(''music'')
    audio.play().catch(function (error) {
        console.log("Chrome cannot play sound without user interaction first" + error)
    });

    typeDance = urlParams.get(''type'')

    intervalID = setInterval(move, 0)
    initVariable()
}

window.addEventListener("load", initAudio)
```

- **initAudio** : Khởi tạo audio phát nhạc dựa vào giá trị query param trên url

```javascript
setTimeout(function () {
    listKeyRandom = isReverse ?
        (typeDance === "4k" ?
                getListKey(level, LIST_KEY_HAS_REVERSE_4K) : getListKey(level, LIST_KEY_HAS_REVERSE_8K)
        ) :
        (typeDance === "4k" ?
                getListKey(level, LIST_KEY_4K) : getListKey(level, LIST_KEY_8K)
        )
    console.log(listKeyRandom)
    for (let i = 0; i < listKeyRandom.length; i++) {
        setKey(listKeyRandom[i], i + 1)
    }
}, 1000)
```

**listKeyRandom**: Lấy danh sách random key theo từng kiểu nhảy. Nếu:

- Nếu bật reverse và kiểu nhảy 4K => random LIST_KEY_HAS_REVERSE_4K
- Nếu bật reverse và kiểu nhảy 8K => random LIST_KEY_HAS_REVERSE_8K
- Nếu không bật reverse và kiểu nhảy 4K => random LIST_KEY_4K
- Nếu không bật reverse và kiểu nhảy 8K => random LIST_KEY_8K

```javascript
function compareKeyPressAndRandom(key) {
    if (listKeyPress.length === listKeyRandom.length) {
        return
    }
    const mapKey = typeDance === "4k" ? MAP_KEY_4K : MAP_KEY_8K
    if (mapKey.get(listKeyRandom[listKeyPress.length]) === key && !isReverse) {
        listKeyPress.push(key + "-success")
        setKey(key + "-success", listKeyPress.length)
    } else if (mapKey.get(listKeyRandom[listKeyPress.length]) === key && isReverse) {
        listKeyPress.push(key + "-success")
        setKey(key + "-success", listKeyPress.length)
    } else {
        listKeyPress = []
        for (let i = 0; i < listKeyRandom.length; i++) {
            setKey(listKeyRandom[i], i + 1)
        }
    }
}
```

**compareKeyPressAndRandom**: so sánh value phím bấm mỗi khi người chơi bấm. Nếu:

- Kiểu nhảy 4K => tìm trong MAP_KEY_4K
- Kiểu nhảy 8K => tìm trong MAP_KEY_8K Khi value phím người chơi bấm.
- Tồn tại => đánh dấu phím đó người chơi bấm đúng.
- Không có trong list nào => reset những phím người chơi đã bấm.

# 4. Kết luận

Ở phần 2 này mình update mã code thêm nên sẽ có một số chỗ người mới đọc sẽ khó hiểu. Mọi người có thể xem lại bài viết [Phần 1 - xây dựng chức năng cơ bản](https://viblo.asia/p/phan-1-tro-choi-audition-xay-dung-chuc-nang-co-ban-voi-javascript-bJzKmD1E59N) ở đây nhé.

Đây là 1 số hình ảnh và video kết quả sau khi build code xong nhé mọi người ^^

{@embed: https://www.youtube.com/watch?v=us5uUZF5m4M}

Website game: https://nguyenvantuan2391996.github.io/game-development/games/audition/home.html

Source code: https://github.com/nguyenvantuan2391996/game-development/tree/master/games/audition

Bài viết được trích từ blog của mình : https://tuannguyenhust.hashnode.dev/', '2023-02-09T15:10:20.000000Z', '2023-02-28T05:19:03.000000Z', '2023-02-10T03:26:09.000000Z'),
	('Tích hợp ChatGPT for Google Extension vào Google Search - gấp đôi sự mạnh mẽ', 'zOQJwQqbVMP', '2', 'unlisted', 'https://images.viblo.asia/8c65ce5d-8979-43e6-9b57-d2e08312618e.png', 'Chắc hẳn nhiều bạn đã trải nghiệm qua chatGPT và thấy được sự mạnh mẽ của nó. Sau một thời gian tìm hiểu, mình tự hỏi liệu có cách nào hay một Extension có thể tích hợp cả chatGPT vào công cụ tìm kiếm Google hay không, như vậy sẽ rất tiện, tận dụng được sức mạnh của cả hai và dễ dàng tra cứu, so sánh và tiếp nhận thông tin. May mắn thay, có một Extension như vậy, nó là chatGPT for Google.

Điều...', 'Chắc hẳn nhiều bạn đã trải nghiệm qua chatGPT và thấy được sự mạnh mẽ của nó. Sau một thời gian tìm hiểu, mình tự hỏi liệu có cách nào hay một Extension có thể tích hợp cả chatGPT vào công cụ tìm kiếm Google hay không, như vậy sẽ rất tiện, tận dụng được sức mạnh của cả hai và dễ dàng tra cứu, so sánh và tiếp nhận thông tin. May mắn thay, có một Extension như vậy, nó là `chatGPT for Google`.

Điều kiện đầu tiên là bạn phải có một tài khoản chatGPT

# Cài đặt Extension chatGPT for Google
### Bước 1
- Các bạn truy cập link https://github.com/wong2/chat-gpt-google-extension. Kéo xuống phần README.md rồi nhấn vào **Install from Chrome Web Store**.

 ![Screenshot 2023-01-07 at 16.14.00.png](https://images.viblo.asia/8c65ce5d-8979-43e6-9b57-d2e08312618e.png)

 - Hoặc có thể vào thẳng trực tiếp ở link này nhé: https://chrome.google.com/webstore/detail/chatgpt-for-google/jgjaeacdkonaoafenlfkkkmbaopkbilf

- Sau đó chọn **Thêm vào Chrome**

  ![Screenshot 2023-01-07 at 16.17.37.png](https://images.viblo.asia/448b769c-426f-4e00-a550-26e153c67ae8.png)

  ### Bước 2: Đăng nhập chatGPT

  - Lúc này Extension đã được thêm vào Chrome của bạn tuy nhiên vẫn chưa sử dụng được tại vì bạn chưa đăng nhập chatGPT, khi search Google một thứ gì đó, ở bên phải màn hình sẽ xuất hiện khung yêu cầu đăng nhập

  ![Screenshot 2023-01-07 at 16.22.58.png](https://images.viblo.asia/caf17fb6-8169-4b40-a5a9-7212d45de0c5.png)

  - Click vào chat.openai.com rồi đăng nhập là oke.

### Bước 3: Trải nghiệm

Sau khi đăng nhập thành công, giờ bạn thử search bất cứ một thứ gì đó, bên phải màn hình sẽ xuất hiện thêm gợi ý của chatGPT

![Screenshot 2023-01-07 at 16.33.21.png](https://images.viblo.asia/70a53f12-76d9-435b-a93e-a128e6ebf96d.png)

# Một demo nho nhỏ
![](https://images.viblo.asia/7a6c04b7-6119-4f95-b4c7-245c2fd080cc.gif)

Cảm ơn bạn đã theo dõi bài viết.', '2023-02-09T15:04:50.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-09T15:03:34.000000Z'),
	('Hướng dẫn deploy API service trên Google Compute Engine', 'GAWVpdWkV05', '3', 'unlisted', 'https://images.viblo.asia/f2415420-8ecd-49e8-8ef3-a770f55a2ab5.png', 'Trong bài viết này mình sẽ hướng dẫn các bạn deploy một api service cơ bản trên GCP thông qua Google Compute Engine:
- Hosting API service chạy bằng Docker trên máy chủ GCP
- Setup domain, SSL cho API service

I. Prerequisites
- Có sẵn api service trên github/gitlab...
- Full quyền trên GCP để enable các service cần thiết
- Domain, DNS service (ở đây mình dùng Cloudflare)
- Kiến thức cơ bản về ...', 'Trong bài viết này mình sẽ hướng dẫn các bạn deploy một api service cơ bản trên GCP thông qua Google Compute Engine:
- Hosting API service chạy bằng Docker trên máy chủ GCP
- Setup domain, SSL cho API service

## I. Prerequisites
- Có sẵn api service trên github/gitlab...
- Full quyền trên GCP để enable các service cần thiết
- Domain, DNS service (ở đây mình dùng Cloudflare)
- Kiến thức cơ bản về command line

## II. Hướng dẫn

### 0. Tạo compute engine
Vì có sẵn một anh đã hướng dẫn step này nên các bạn follow theo cho tiện nhé: [link](https://blog.cloud-ace.vn/huong-dan-tao-may-ao-virtual-machine-vm-tren-google-compute-engine/)
### 1. Install Git
- Chạy command
```
sudo apt update
sudo apt install git
```
- Kiểm tra Git đã được install thành công
```
git --version
```

### 2. Thêm SSH Key và Clone project
- Thêm SSH key theo [hướng dẫn](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

- Tiếp đến chúng ta chọn thư mục và tiến hành clone project từ Github/Gitlab đã có sẵn trước đó

- Thêm quyền read/write/execute cho folder chứa source code bằng lệnh:
```
sudo chmod -R 777 .
```
### 3.  Install Docker Compose
Vì project của mình chạy bằng docker-compose, nên mình sẽ install chúng.

- Cài đặt docker-compose phiên bản mới nhất:
```
sudo curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

- Thêm quyền thực thi cho docker-compose:
```
sudo chmod +x /usr/local/bin/docker-compose
```

- Kiểm tra docker-compose đã được cài đặt thành công:
```
docker-compose version
```
### 4. Build & Run docker-compose

- Run project:
```
docker-compose up --build
```

- Nếu ta gặp lỗi:
```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: dial unix /var/run/docker.sock: connect: permission denied

```
thì bạn hãy cấp quyền read & write cho user/non-root-process trên docker.sock như sau nhé:
```
sudo chmod 666 /var/run/docker.sock
```
### 5. Mở port ứng dụng trên VMware
Lưu ý khi tạo instance các bạn hãy chọn 2 option này nhé, mục đích để cho traffic HTTP/HTTPS từ bên ngoài internet có thể truy cập qua firewall:
![image.png](https://images.viblo.asia/0782cf4e-20c3-4053-a31c-4e70cf32b437.png)
Vì application port của mình đã chạy ở bước 4 chạy trên port 9000, nên mình cần bổ sung những bước sau để cho phép traffic chỉ định có thể truy cập port mà mình cung cấp

- Mở VPC Network chọn `Firewall`
- Sau đó chọn `CREATE FIREWALL RULE`

![image.png](https://images.viblo.asia/f2415420-8ecd-49e8-8ef3-a770f55a2ab5.png)

- Điền rule name, ở mục target chọn `All instances in the network`
- Source IPv4 ranges nhập: `0.0.0.0/0` (hình dưới)

![image.png](https://images.viblo.asia/a7ec2bde-f59a-44bb-9c11-7bec62bc091f.png)

- Ở mục `Protocols and ports` chọn TCP, sau đó nhập port của ứng dụng, ở đây mình nhập range 7000-9000 chứ không chỉ định 1 port duy nhất:

![image.png](https://images.viblo.asia/134ce866-0cd7-49e0-ad7c-bba1bdfa10e4.png)

- Bấm `Create` để hoàn tất tạo Firewall Rule
- Sau đó vào lại VMware, dựa vào `External IPs` và mở port tương ứng để kiểm tra

![image.png](https://images.viblo.asia/74cab272-0f63-45e7-ad5e-b5712a0a0b4b.png)

- Vậy là chúng ta đã truy cập thành công vào ứng dụng thông qua external IP và port được open (**lưu ý là http không phải https vì chúng ta chưa config ssl cho domain này nhé**)

### 6. Create instance group
- Trước khi config load balancing cho instance, chúng ta cần tạo instance group trước. Ở `Compute Engine`, chọn `Instance groups` sau đó nhấn `CREATE INSTANCE GROUP`:

![image.png](https://images.viblo.asia/7cd9fef4-4ae7-4008-aed0-d9e6ab1b804e.png)

- Điền các thông tin để khởi tạo instance group như bên dưới, lưu ý phần `Port mapping`, chúng ta cần điền đúng port mà ứng dụng đang chạy để LB có thể access được:

![image.png](https://images.viblo.asia/857490c1-5a52-4e26-ab17-9160bfd71278.png)
- Cuối cùng nhấn `Create` để hoàn tất.

### 7. Config Load balancing cho vm
- Vào `Network services` chọn `Load balancing`
- Chọn `Start Configuration` ở mục `HTTP(S) Load Balancing`:

![image.png](https://images.viblo.asia/3b1c597c-2a11-4b02-b6c6-30c3fbb47cf3.png)

- Chọn các cấu hình như sau và tiếp tục:

![image.png](https://images.viblo.asia/e2dd80e2-427a-41c7-b0a6-7d8b18d1c006.png)

- Nhập tên cho Load balancer config, ở phần Frontend Configuration cấu hình như sau:

![image.png](https://images.viblo.asia/cf3bef36-b34d-42fb-a01e-18f75f8e7147.png)

- Phần Backend Configuration chọn:

![image.png](https://images.viblo.asia/cc643f0b-d219-4f6e-9db1-f5e4bfc67d28.png)

- Điền các thông tin cơ bản như sau:

![image.png](https://images.viblo.asia/d8aac0d3-b5f3-4d69-b4b1-ef98ed93d2a9.png)

- Ở phần `health check`, chọn `CREATE A HEALTH CHECK`, nhằm mục đích kiểm tra liệu ứng dụng của bạn còn hoạt động hay không:

![image.png](https://images.viblo.asia/eb6238ba-67de-4a58-b089-0cb02237db93.png)

- Điền `request path`, là đường dẫn health check của ứng dụng, phải nhập port tương ứng với port mà ứng dụng đang chạy. Lưu ý HTTP response code của đường dẫn này phải là 200 nhé. Sau đó nhấn save để lưu cấu hình health check.

![image.png](https://images.viblo.asia/fb292aed-cca8-4829-a32a-2b4ee5a5b431.png)

- Nhập tên cho Load balancing Config và bấm tạo để hoàn tất. Khi hoàn tất, ở màn hình danh sách load balancing config sẽ xuất hiện instance vừa tạo. Click chọn instance để xem detail:

![image.png](https://images.viblo.asia/44a8ef67-86bc-4d38-88e9-0c326e67bec9.png)

- Ở cột `IP:Port` chính là IP load balancing của chúng ta, các bạn hãy mở browser và kiểm tra nhé !!


### 8. Config domain and ssl
Last but not least, mình đang có 1 domain trên Cloudflare và muốn assign cho API service vừa tạo. Các bạn hãy làm như sau

- Ở Cloudflare, tab SSL/TLS, chọn create `Client Certificates` sau đó nhấn `Create Certificate`

![image.png](https://images.viblo.asia/5a5304e6-7308-4434-a585-4287545bd868.png)

- Nhấn Create để tiếp tục:

![image.png](https://images.viblo.asia/05d4dcdb-f31f-48cc-ac03-82e8d8d72bde.png)

- Cloudflare sẽ tạo client cerificate cho chúng ta, lưu ý hãy lưu 2 mã `Certificate` và `Private Key` lại nhé:

![image.png](https://images.viblo.asia/5a16073e-29ff-457d-ba47-fe141df14fb8.png)

- Tiếp theo các bạn mở tab overview, chọn option `Full` cho SSL/TLS encryption mode:

![image.png](https://images.viblo.asia/a138723e-d636-4565-a315-894dbe8782ae.png)

- Quay về load balancing config, các bạn chọn và edit config, thông tin sau sẽ show lên, sau đó các bạn nhấn `ADD FRONTEND IP AND PORT` để thêm config cho protocol https:

![image.png](https://images.viblo.asia/45d1a7e0-25b3-4cee-b920-fad300816505.png)

- Ở field Certificate, chọn `CREATE A NEW CERTIFICATE`, thông tin cho certificate ở đây là `Certificate` và `Private Key` mà các bạn đã tạo từ Cloudflare

- Nhấn Create để tiếp tục

- Click Done sau đó nhấn Update để hoàn tất chỉnh sửa config:

![image.png](https://images.viblo.asia/5dbcd95e-e617-4eaf-8ed1-9740ba77fc25.png)

- Bây giờ vào lại detail của load balancing config và lấy địa chỉ IP của protocol HTTPS vừa tạo, các bạn chỉ copy ip, **không** copy port 443:

![image.png](https://images.viblo.asia/d7952fb8-9f08-4736-8cec-738f29f35f45.png)

- Về lại Cloudflare, ở tab DNS/records, chọn `Add record` và thêm theo hướng dẫn sau:
    + Type: `A`
    + Name: `@`, `www` hoặc subdomain của bạn. Ví dụ domain của bạn là `abc.com` thì có thể tạo subdomain như `api.abc.com`
- Bấm `Save` để hoàn tất


## III. Kết
- Các bạn vào lại domain/sub domain bằng browser để kiểm tra nhé
- Cảm ơn các bạn đã xem bài viết ^^', '2023-02-09T09:40:31.000000Z', '2023-02-28T05:09:04.000000Z', '2023-02-09T09:10:41.000000Z'),
	('[K8S] Phần 21 - Xây dựng luồng Gitops với Jenkins và ArgoCD', 'y3RL1aX7Lao', '4', 'unlisted', 'https://images.viblo.asia/9f75e67d-7bad-43c3-8d39-48f1793bb2c9.png', 'Lời đầu tiên xin chúc tất cả bạn đọc và gia đình năm mới mạnh khỏe, an khang thịnh vượng 🤩

Chúc các bạn đạt được nhiều mục tiêu đề ra và dành được nhiều thành công trong năm mới 2023 này.

Giới thiệu
Hello mọi người. Lâu rồi mình mới có thời gian quay lại với series Kubernetes này. Trong phần 17 của series này, mình đã chia sẻ một mô hình CICD đơn giản sử dụng Jenkins.
Các bạn có thể tham khảo...', '> Lời đầu tiên xin chúc tất cả bạn đọc và gia đình năm mới mạnh khỏe, an khang thịnh vượng 🤩

> Chúc các bạn đạt được nhiều mục tiêu đề ra và dành được nhiều thành công trong năm mới 2023 này.

# Giới thiệu
Hello mọi người. Lâu rồi mình mới có thời gian quay lại với series Kubernetes này. Trong phần 17 của series này, mình đã chia sẻ một mô hình CICD đơn giản sử dụng Jenkins.
Các bạn có thể tham khảo nội dung [***bài viết đó ở đây.***](https://viblo.asia/p/k8s-phan-17-xay-dung-luong-cicd-voi-gitlab-va-jenkins-RnB5pJAGZPG)

**Ý tương triển khai Mô hình CICD đó như sau:**
![image.png](https://images.viblo.asia/5df67387-c99a-42e3-9f92-19db91cfb1a3.png)

Mô hình này đã giúp giải quyết được bài toán tự động hóa luồng cập nhật thay đổi từ source code tới môi trường triển khai (dev/prod..).

**Tuy nhiên nó vẫn còn một số hạn chế như sau:**
- Rủi ro về bảo mật khi CI và CD không được tách biệt. Trong trường hợp nó bị tấn công thì kẻ tấn công cũng có thể truy cập vào hệ thống đang chạy
- Không phát hiện được sự sai khác giữa cấu hình triển khai ta định nghĩa ban đầu và cấu hình triển khai thực tế
- Khó quản lý tính đồng nhất về cấu hình triển khai ứng dụng trong quá trình vận hành
- Luồng CICD này chủ yếu tập trung vào việc đưa các cập nhật của source code lên các môi trường triển khai. Phần cấu hình triển khai thường ít có thay đổi (helmchart/manifest) trừ thông tin image của source code mới build.

Có thể lấy một ví dụ đơn giản là bạn deploy một ứng dụng A sử dụng luồng CICD như bên trên. Ban đầu bạn đặt cấu hình resource với cpu limit là 300m. Nhưng trong quá trình vận hành bạn thấy Pod thường bị restart khi vượt ngưỡng CPU. Do đó để hot fix bạn vào trực tiếp hệ thống để edit deployment tăng giá trị CPU Limit lên thành 600m.

Tuy nhiên khi bạn chạy lại luồng CICD (khi có update về source code và cần deploy lên hệ thống) thì lúc này các giá trị cấu hình của ứng dụng sẽ lại được set về như ban đầu (giá trị CPU limit sẽ được set lại thành 300m). Bạn đã thấy vấn đề bắt đầu xuất hiện ở đây chưa ?

***Vì đây chính là lúc Gitops xuất hiện để giải quyết bài toán trên cho các bạn.***

# Gitops là gì, gitops mang lại lợi ích gì
## Gitops là gì
Ý tưởng chính của GitOps là sử dụng Git để lưu trữ cấu hình toàn bộ cơ sở hạ tầng triển khai hoàn chỉnh cho một ứng dụng. Một tập hợp các file, sử dụng IAC, được sử dụng để phân bổ các tài nguyên cơ sở hạ tầng cần thiết, để cấu hình việc triển khai ứng dụng.

Điều này làm cho thông tin được lưu trữ trên Git trở thành nguồn cơ sở của toán bộ hạ tầng (source of truth) mà các ứng dụng phải tiếp cận và thực hiện xoay quanh nó.

Một ví dụ điển hình là Terraform của Hashicorp. Với Terraform, bạn có thể định nghĩa toàn bộ cơ sở hạ tầng của mình dưới dạng mã code và lưu trữ trên git. Hạ tầng của bạn sẽ luôn được đảm bảo tính nhất quán với các cấu hình bạn đã định nghĩa.

**Một flow về Gitops cho infra::**
![image.png](https://images.viblo.asia/76f6374c-e447-45a8-b029-ac787dace9c3.png)

## Lợi ích khi sử dụng gitops
Lợi ích cốt lõi của GitOps có thể được hiểu ngắn gọn là đảm bảo các thay đổi được cập nhật ở cả tầng hệ thống và tầng ứng dụng, tự động các quy trình sau đó và đảm bảo ứng dụng trong thực tế phản ánh chính xác ứng dụng được miêu tả trong các tệp chứa cấu hình triển khai ứng dụng/hệ thống.

GitOps có thể giúp bạn nâng cấp luồng CICD lên một level cao hơn, nâng cao tính bảo mật, độ tin cậy tối ưu được nguồn lực cho vận hành hệ thống.

# Mô hình Gitops cơ bản với Jenkins và ArgoCD
Các bạn có thể tham khảo một mô hình Gitops cơ bản dùng Jenkins (CI) và ArgoCD (CD) như sau:
![image.png](https://images.viblo.asia/9f75e67d-7bad-43c3-8d39-48f1793bb2c9.png)

## Ý tưởng của nó như sau:
- Source code của dự án được lưu ở một repo riêng, gọi là `source repo`
- Phần cấu hình triển khai ứng dụng (helmchart hay k8s manifest files..) được lưu ở một repo riêng, gọi là `config repo`
- Luồng CICD hoạt động theo trình tự:
    - Dev commit source code
    - Jenkins build source code
    - Jenkins Build Images
    - Jenkins push image lên image registry
    - Jenkins cập nhật thông tin phiên bản ứng dụng vào các file cấu hình triển khai ứng dụng lưu trên config repo
    - ArgoCD phát hiện thay đổi trên config repo thì cập nhật thay đổi về
    - ArgoCD so sánh thông tin cấu hình mới với cấu hình hiện tại trên hệ thống, nếu phát hiện sai khác sẽ cảnh báo và đồng bộ lại theo cấu hình được khai báo và lưu trên config repo

Ví dụ bạn deploy ứng dụng bằng helmchart và nó sẽ tạo ra 1 deployment + 1 service + 1 configmap chẳng hạn. Thì ArgoCD sẽ tìm trên K8S có các resource như mô tả của helmchart + helm-value hay chưa (dựa vào namespace và resource-name).

**Như vậy so với luồng CICD mà mình đã giới thiệu trước đó (ở bài 17) thì chúng ta sẽ có một số việc mới cần giải quyết:**
- Lưu trữ helmchart của ứng dụng lên một `config repo` trên git
- Cập nhật thông tin phiên bản ứng dụng (image:tag) vào file helmchart-value trên `config repo`
- Cài đặt và cấu hình ArgoCD để đồng bộ từ config repo với ứng dụng triển khai thực tế trên k8s

# Triển khai
## Các bước chúng ta cần thực hiện gồm:
- Dựng cụm k8s (đương nhiên) và các thành phần liên quan như Ingress Controller..
 - Tạo `source repo` trên Git (sử dụng Github cho tiện cho bài demo này)
- Tạo `config repo` trên Git (sử dụng Github cho tiện cho bài demo này)
- Tạo repository trên DockerHub để lưu image của ứng dụng
- Cài đặt và cấu hình Jenkins (tích hợp với git chứa `source repo` và `config repo`)
- Cài đặt và cấu hình ArgoCD trên K8S (tích hợp với Github và Dockerhub)
- Tạo job trên Jenkin thực hiện các tác vụ: Pull source code + Build source + Build Image + Push Image + Update Image:tag vào `config repo`
- Tạo ứng dụng trên ArgoCD sử dụng các file manifest trên `config repo` để đồng bộ với ứng dụng triển khai thực tế trên k8s
- Test luồng cập nhật `source repo` và luồng cập nhật `config repo`

## Mô hình triển khai
Mô hình triển khai Lab này như sau:
![image.png](https://images.viblo.asia/2320612a-e937-4036-8917-4b6305b0531d.png)

- K8S được cài trên 3 VM gồm 1 control-plane và 2 worker node
- Jenkins được cài trên VM
- ArgoCD được cài đặt trên K8S ở namespace `argocd`
- Ứng dụng demo được cài ở namespace `demo2`

## Dựng cụm k8s
Mình đã dựng sẵn một cụm k8s gồm 1 master và 2 worker như sau:
```
NAME               STATUS   ROLES           AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
ip-172-31-21-254   Ready    control-plane   28d   v1.26.0   172.31.21.254   <none>        Ubuntu 20.04.5 LTS   5.15.0-1028-aws   containerd://1.6.15
ip-172-31-29-187   Ready    <none>          28d   v1.26.0   172.31.29.187   <none>        Ubuntu 20.04.5 LTS   5.15.0-1028-aws   containerd://1.6.15
ip-172-31-30-194   Ready    <none>          28d   v1.26.0   172.31.30.194   <none>        Ubuntu 20.04.5 LTS   5.15.0-1028-aws   containerd://1.6.15
```
Môi trường Lab này mình cài k8s phiên bản `v1.26.0` và sử dụng CRI là containerd `1.6.15`.

## Tạo `source repo` để lưu trữ source code
###  Tạo `source repo`
Mình sử dụng lại bản source code giống như đã triển khai ở bài hướng dẫn dựng CICD, các bạn có thể download source code ở [link github này](https://github.com/rockman88v/demo-app.git)

Mô tả sơ bộ thì đây là một App viết bằng NodeJs hiển thị một số thông tin về deployment của nó trên k8s như namespace, node, Pod..
![image.png](https://images.viblo.asia/fdd15f32-42ef-474a-ab9d-c569c9b5fc5f.png)

### Tạo access key để truy cập github
Trong mô hình sử dụng gitops này, Jenkin vẫn đóng vai trò CI và nó cần pull được từ `source repo` và `config repo`. Do đó ta cần tạo một  `access token` trên github và cấu hình cho Jenkins sử dụng token đó khi pull từ github.

**Các bạn tạo `access token` theo bước sau:**

Vào thông tin user ở góc trên bên phải chọn Setting ⇒ Developer settings
(Hoặc truy cập thẳng vào link: [https://github.com/settings/tokens](https://github.com/settings/tokens))

Chọn **Generate new token** ⇒ **Generate new token (classic)** ⇒ Đặt tên token và tick chọn vào mục **repo** ⇒ **Generate token** ⇒ Lưu lại token vừa sinh ra để sử dụng.

## Tạo `config repo` để lưu trữ helmchart và file helm-value cho ứng dụng
### Tạo `config repo`
Phần helmchart để triển khai cho ứng này mình sẽ lưu trên một repo riêng, các bạn có thể [***download ở đây***](https://github.com/rockman88v/app-helmchart.git).
Trong thư mục helmchart mình sẽ lưu trữ một file `values.yaml` chứa các cấu hình mặc định cho ứng dụng. Các giá trị cần tùy biến sẽ lưu ở file `app-demo-value.yaml`.  Một số tham số quan trọng như:
- image.repository => Khai báo thông tin image của ứng dụng
- image.tag => Phiên bản đóng gói của ứng dụng
- replicaCount => Số Pod chạy ứng dụng
- service.type => Mình để là `NodePort` để khỏi phải tạo ingress..
### Tạo access key để truy cập github
Nếu `config repo` và `source repo` cùng dùng chung github  thì bạn chỉ cần tạo 1 lần `access token` để dùng chung. Còn nếu là 2 hệ thống khác nhau thì tạo 2 `access token` riêng biệt nhé!

**Ở đây mình dùng chung một account nên chỉ tạo 1 `access token` là đủ.**

## Tạo repository trên Dockerhub để lưu Images
### Tạo repository
Bước này khá đơn giản nên mình không mô tả gì thêm nhiều. Các bạn tạo một repo mới để sau khi build docker image thì sẽ push image đó lên dockerhub repo.
Mình đã tạo sẵn repo trên dockerhub là `rockman88v/demo-app` như sau:
![image.png](https://images.viblo.asia/b7f6cdac-7e32-432d-8015-8cddb145f7e9.png)

### Tạo `access token` để kết nối tới dockerhub
Khi login vào dockerhub bạn chọn vào tên account → Setting → Secutiry → Access Tokens → New Access Token:
![Untitled (1).png](https://images.viblo.asia/a2f91afa-592f-457b-a268-07774e4f8a5f.png)

Chọn tên cho token, quyền là Read & Write và chọn Generate.
Bạn cần lưu lại token mới sinh ra để sử dụng ở các bước sau:
```
dckr_pat_m_ygVxxxxxxxxxxxxxx
```
***Token này sẽ được sử dụng làm credential cho Jenkins khi cần push docker image lên dockerhub.***

## Cài đặt và cấu hình jenkins
### Cài đặt và cấu hình Jenkins
Bước này mình không giới thiệu kỹ vì cài đặt khá đơn giản các bạn gg và làm theo. Phần cài đặt các plugin thì bạn cần cài Git, Docker Pipeline.

### Tạo credentials kết nối github và dockerhub
Trong ví dụ này mình sử dụng github và dockerhub. Trong trường hợp các bạn sử dụng công cụ khác thì cũng làm tương tự là tạo token hoặc user/pass trên các hệ thống SMC và registry tương ứng để tạo credentials cho jenkins.

Để tạo credentials bạn thực hiện trên jenkins web như sau: Vào Manage Jenkins => Manage Credentials => chọn Domain `global` => chọn `Add Credentials` => chọn kind là `Username with password`.

**Ví dụ để tạo credentials cho Jenkins két nối github mình sẽ điền:**
- Username: Là user của bạn trên github
- Password: Là `access token` tạo ở bước trên
- ID: Điền là `github`. ID này sẽ được dùng trong pipeline khi cần pull/commit tới github, bạn đặt tên gì gợi nhớ là dc.

**Tương tự bạn tạo credential cho Jenkins kết nối tới dockerhub:**
- Username: Là user của bạn trên dockerhub
- Password: Là `access token` tạo ở bước trên
- ID: Điền là `dockerhub`. ID này sẽ được dùng trong pipeline khi cần push image lên dockerhub

**Kết quả như sau:**
![image.png](https://images.viblo.asia/c80a2d47-d198-45e5-936a-56fbaca487cb.png)

## Cài đặt và cấu hình ArgoCD
**Các bạn cài đặt ArgoCD lên K8S bằng lệnh sau:**
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Cấu hình service thành loại NodePort:
kubectl patch svc -n argocd argocd-server --patch ''{"spec": {"type": "NodePort"}}''
```

**Kết quả sinh ra các resource ở namespace `argocd` như sau:**
```
ubuntu@base-node:~$ k -n argocd get all
NAME                                                    READY   STATUS    RESTARTS      AGE
pod/argocd-application-controller-0                     1/1     Running   4 (13h ago)   29d
pod/argocd-applicationset-controller-6f8bd46d57-6zlrs   1/1     Running   5 (13h ago)   29d
pod/argocd-dex-server-7b64b5456b-rw858                  1/1     Running   4 (13h ago)   29d
pod/argocd-notifications-controller-6d8d47c47b-7kczx    1/1     Running   4 (13h ago)   29d
pod/argocd-redis-847d5bc57c-sm4g8                       1/1     Running   4 (13h ago)   29d
pod/argocd-repo-server-685bbbf85c-68rjf                 1/1     Running   4 (13h ago)   29d
pod/argocd-server-66fcf976bf-5jt88                      1/1     Running   4 (13h ago)   28d

NAME                                              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/argocd-applicationset-controller          ClusterIP   10.106.171.153   <none>        7000/TCP,8080/TCP            29d
service/argocd-dex-server                         ClusterIP   10.106.88.129    <none>        5556/TCP,5557/TCP,5558/TCP   29d
service/argocd-metrics                            ClusterIP   10.97.2.20       <none>        8082/TCP                     29d
service/argocd-notifications-controller-metrics   ClusterIP   10.98.211.133    <none>        9001/TCP                     29d
service/argocd-redis                              ClusterIP   10.106.47.164    <none>        6379/TCP                     29d
service/argocd-repo-server                        ClusterIP   10.109.251.135   <none>        8081/TCP,8084/TCP            29d
service/argocd-server                             NodePort    10.99.253.77     <none>        80:32656/TCP,443:30671/TCP   29d
service/argocd-server-metrics                     ClusterIP   10.107.240.56    <none>        8083/TCP                     29d

NAME                                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/argocd-applicationset-controller   1/1     1            1           29d
deployment.apps/argocd-dex-server                  1/1     1            1           29d
deployment.apps/argocd-notifications-controller    1/1     1            1           29d
deployment.apps/argocd-redis                       1/1     1            1           29d
deployment.apps/argocd-repo-server                 1/1     1            1           29d
deployment.apps/argocd-server                      1/1     1            1           29d

NAME                                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/argocd-applicationset-controller-6f8bd46d57   1         1         1       29d
replicaset.apps/argocd-dex-server-7b64b5456b                  1         1         1       29d
replicaset.apps/argocd-notifications-controller-6d8d47c47b    1         1         1       29d
replicaset.apps/argocd-redis-847d5bc57c                       1         1         1       29d
replicaset.apps/argocd-repo-server-685bbbf85c                 1         1         1       29d
replicaset.apps/argocd-server-66fcf976bf                      1         1         1       29d

NAME                                             READY   AGE
statefulset.apps/argocd-application-controller   1/1     29d
```

**Để truy cập vào web của ArgoCD bạn cần 2 thứ:**
- Lấy thông tin NodePort được gán cho service `argocd-server`, như bên dưới ta có NodePort https là `30671`:
```
ubuntu@base-node:~$ k -n argocd get svc argocd-server
NAME            TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
argocd-server   NodePort   10.99.253.77   <none>        80:32656/TCP,443:30671/TCP   29d
```
- Lấy thông tin password đăng nhập mặc định sau khi cài (kết quả cho ra `EvmRUhW99524rAfE`):
```
ubuntu@base-node:~$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
EvmRUhW99524rAfE
```
***Lúc này ta có thể truy cập vào Web của ArgoCD thông qua workerIP:NodePort dùng user mặc định là `admin` với password trên.***

`NOTE: Ở bước này mình chưa cài certificate cho Argo nên khi đăng nhập sẽ báo invalid certificate thì các bạn vẫn chọn tiếp tục để bỏ qua lỗi cert nhé!`
## Tạo job CI trên Jenkins
**Tới bước này mình cần định nghĩa Job cho jenkins thực hiện các công việc sau:**
- Pull `source code` từ github
- Build source code
- Build docker image
- Push docker image lên container registry (dockerhub)
- Cập nhật thông tin phiên bản ứng dụng (image.tag) vào file helm-value lưu trong `config repo`

Các bước trên đều không có gì mới so với luồng CICD trước đây mình đã đề cập ở [bài 17 Xây dựng luồng CICD với Gitlab và Jenkins](https://viblo.asia/p/k8s-phan-17-xay-dung-luong-cicd-voi-gitlab-va-jenkins-RnB5pJAGZPG) trừ bước cập nhật thông tin phiên bản ứng dụng.

Ý tưởng của bước này là ở mỗi lần build source code thành docker image, ta sẽ sử dụng tham số BUILD_NUMBER (tăng lần sau mỗi lần build) là thông tin tag của image. Do đó ta cũng cần cập nhật tham số này cho file helm-value để triển khai ứng dụng lên k8s, file này nằm ở `config repo`.

**Để thực hiện được bước này có nhiều phương án, ở đây mình dùng ý tưởng đơn giản như sau:**
- Pull `config repo` về
- Cập nhật giá trị image.tag theo đúng tag mới build
- Commit thay đổi vào repo `config repo`

**Các bạn tham khảo cấu hình job thực hiện các bước nêu trên như sau:**
```java
//pull config repo ok
// update tag in config repo ok
// not yet commit and push
def appSourceRepo = ''https://github.com/rockman88v/demo-app.git''
def appSourceBranch = ''master''

def appConfigRepo = ''https://github.com/rockman88v/app-helmchart.git''
def appConfigBranch = ''master''
def helmRepo = "app-helmchart"
def helmChart = "app-demo"
def helmValueFile = "app-demo/app-demo-value.yaml"

def dockerhubAccount = ''dockerhub''
def githubAccount = ''github''

dockerBuildCommand = ''./''
def version = "v1.${BUILD_NUMBER}"

pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = ''https://registry-1.docker.io''
        DOCKER_IMAGE_NAME = "rockman88v/demo-app"
        DOCKER_IMAGE = "registry-1.docker.io/${DOCKER_IMAGE_NAME}"
    }

    stages {
        stage(''Checkout project'') {
          steps {
            git branch: appSourceBranch,
                credentialsId: githubAccount,
                url: appSourceRepo
          }
        }
        stage(''Build And Push Docker Image'') {
            steps {
                script {
                    sh "git reset --hard"
                    sh "git clean -f"
					app = docker.build(DOCKER_IMAGE_NAME, dockerBuildCommand)
                    docker.withRegistry( DOCKER_REGISTRY, dockerhubAccount ) {
                       app.push(version)
                    }

                    sh "docker rmi ${DOCKER_IMAGE_NAME} -f"
                    sh "docker rmi ${DOCKER_IMAGE}:${version} -f"
                }
            }
        }

        stage(''Update value in helm-chart'') {
            steps {
				withCredentials([usernamePassword(credentialsId: ''github'', passwordVariable: ''GIT_PASSWORD'', usernameVariable: ''GIT_USERNAME'')]) {
				sh """#!/bin/bash
					   [[ -d ${helmRepo} ]] && rm -r ${helmRepo}
					   git clone ${appConfigRepo} --branch ${appConfigBranch}
					   cd ${helmRepo}
					   sed -i ''s|  tag: .*|  tag: "${version}"|'' ${helmValueFile}
					   git add . ; git commit -m "Update to version ${version}";git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/rockman88v/app-helmchart.git
					   cd ..
					   [[ -d ${helmRepo} ]] && rm -r ${helmRepo}
					   """
				}
            }
        }
    }
}
```

Lúc này mỗi khi bạn có thay đổi về source code và build job trên Jenkins thì phiên bản của Docker Image sẽ được cập nhật vào file helm-value (`app-demo-value.yaml`)

**Kết quả build Jenkins:**
![image.png](https://images.viblo.asia/dec6c88d-b833-4ad1-9677-fa3dcbd13556.png)

**Kết quả update lên `config repo`:**
![image.png](https://images.viblo.asia/4e8457bf-73be-434c-88ce-70f3e3b58f0e.png)

***Như vậy là Jenkins đã hoàn thành nhiệm vụ của nó rồi. Phần còn lại là cấu hình tiếp phía ArgoCD để thực hiện luồng CD***

## Tạo Application (ứng dụng) trên ArgoCD
### Khai báo repository chứa `config repo` vào argocd
Từ web của argocd vào Settings → Repositories → Connect repo → via HTTPS và cấu hình các tham số như sau:
- Choose your connection method: => `VIA HTTPS`
- Type => `Git`
- Project => `default`
- Repository URL: Điền thông tin repo đã tạo ở bên trên `https://github.com/rockman88v/app-helmchart.git`
- Username/Password: Điền thông tin account, password là token tạo bên trên.

**Kết quả khi tạo repository thành công:**
![image.png](https://images.viblo.asia/0960bcf5-76ad-4378-a59a-7465b0992ef9.png)

### Khai báo ứng dụng trên ArgoCD
> Khái niệm "Application" (ứng dụng) trên ArgoCD chính là ta khai báo việc theo dõi một tập các resource trên K8S dựa vào một tập file cấu hình định nghĩa các resource đó. Trong trường hợp này ta sẽ định nghĩa ứng dụng demo của chúng ta từ bộ helm-chart và helm-value được lưu trên `config repo`.

**Khai báo application:**
Từ web của argocd vào Applications → New App và điền các tham số như sau:

**GENERAL:**
- Application Name: Điền tên của Application, ví dụ `DEMO-APP3`
- Project Name: `Default`
- SYNC POLICY: `Manual`. Ở đây có 2 option là `Manual` hoặc `Auto-sync`.
    - `Auto-sync`: Khi phát hiện sự bất đồng bộ giữa cấu hình thực tế (trên K8S) so với định nghĩa (trên `config repo` thì Argo thực hiện tự động việc cập nhật cấu hình các resource trên K8S theo đúng cấu hình đã định nghĩa
    - `Manual` Khi phát hiện bất động bộ thì ArgoCD sẽ chỉ cảnh báo lên các resource bị mất đồng bộ (out of sync) và bạn muốn đồng bộ lại thì cần phải chọn vào nút `sync` để đồng bộ lại.

**SOURCE:**
- Repository URL: [`https://github.com/rockman88v/app-helmchart.git`](https://github.com/rockman88v/app-helmchart.git)
- Path: `app-demo` -> Đây là thư mục chứa helmchart của chúng ta

**DESTINATION:**
- Cluster URL: [`https://kubernetes.default.svc`](https://kubernetes.default.svc/)
- Namespace: `demo3`

**Helm:**
- VALUES FILES: Chọn 2 file value theo đúng thứ tự là `values.yaml` và `app-demo-value.yaml`
![image.png](https://images.viblo.asia/145ff318-a49a-4ae0-8571-ca152ded8591.png)

**Sau đó chọn CREATE để tạo application. Kết quả:**
![image.png](https://images.viblo.asia/dc90e1f0-daac-4db0-8c2d-5bf748be7f29.png)

Ở đây khi mới tạo thì ứng dụng của bạn sẽ ở trạng thái "**Missing, OutOfSync**", đơn giản là vì bạn chưa tạo resource trên K8S.
Trong hình trên thì app `demo-app2` là mình đã sync từ trước rồi, còn app `app-demo3` là mình vừa tạo xong tương tự như app-demo2 nhưng ở namespace khác.

> Một lưu ý là bạn cần tạo namespace trước khi khai báo ứng dụng trên ArgoCD nhé!

Khi ấn vào xem chi tiết ứng dụng sẽ thấy ứng dụng này quản lý trạng thái của 3 resource là `service`, `service account` và `deployment`, cả 3 resource này đều chưa được tạo trên namespace `demo3`:
![image.png](https://images.viblo.asia/9b902a9e-4b56-4c8c-8f0c-64bd3d06e163.png)

Chúng ta có thể ấn `SYNC` để đồng bộ trạng thái trên k8s với trên git, nghĩa là sẽ tạo ra các resource trên k8s:
![image.png](https://images.viblo.asia/c9549da2-95ed-44cc-8126-8c01e184cf7d.png)

Kết quả sau khi sync thành công, ứng dụng ở trạng thái "Synced":
![image.png](https://images.viblo.asia/b7484bfc-9e9d-4996-92d9-d1903ed5acd4.png)

## Test luồng cập nhật source code
Thông thường thì phần cấu hình cho ứng dụng sẽ ít khi có thay đổi, trừ khi bạn muốn bổ sung thêm template hay thay đổi scale hoặc các tham số liên quan tới resource limit/request..

Mỗi khi có update về source code thì bạn sẽ cần chạy luồng CICD để deploy lên môi trường thực tế. Khi đó phần duy nhất thay đổi ở phần `config repo` là giá trị image.tag.
Ví dụ ứng dụng hiện tại của mình đang ở phiên bản ứng dụng là `1.33 20230116` như các bạn thấy khi vào web:
![image.png](https://images.viblo.asia/0ce81881-4ed1-48c9-92b9-747fb1928f11.png)

Bây giờ mình sẽ cập nhật giá trị này ở trong source code, file `documents/index.html` thành "This is version 1.40 20230209" và chạy lại luồng CICD này.
![image.png](https://images.viblo.asia/22f3b3b0-2111-4304-a8dd-d2165e8e2903.png)

Sau khi Jenkin build xong sẽ cập nhật thông tin image và ArgoCD sẽ update các resoure tương ứng trên k8s, cụ thể chỉ có deployment cần update (do image.tag thay đổi) còn các resource khác khong ảnh hưởng gì:
![image.png](https://images.viblo.asia/c2f9ebe8-6ed0-4235-b201-d551d8c9697a.png)

**Vào lại web của ứng dụng và verify thông tin cập nhật (hiển thị phiên bản mới `1.41 20230209`):**
![image.png](https://images.viblo.asia/aeae6fe9-f0c6-4dfe-8c50-8dc2852217ea.png)

## Test luồng cập nhật trực tiếp helmchart trên `config repo`
Trong quá trình vận hành ứng dụng, đôi khi chúng ta phải thay đổi các tham số cấu hình cho ứng dụng ví dụ như:
- Thay đổi số lượng Pod (tăng/giảm)
- Thay đổi cấu hình resource (tăng/giảm request/limit cho RAM/CPU)
- Thêm template mới (ví dụ thêm cấu hình Affinity, hay service monitor..)

Những thay đổi này độc lập với thay đổi của source code ứng dụng (tức là về logic nghiệp vụ không đổi, phiên bản đóng gói ứng dụng không đổi).

Lúc này những thay đổi sẽ được thực hiện commit lên `config repo` và đây là nguồn đảm bảo thông tin cấu hình luôn được đồng bộ với mọi thành viên trong team.

**Mình sẽ demo 2 trường hợp điển hình:**
- Cập nhật cấu hình ở `config repo` => Argo đồng bộ các thay đổi đó lên các resource tương ứng trên k8s
- Thay đổi cấu hình resource trên k8s => Argo phát hiện thay đổi và sẽ chiếu theo cấu hình từ trên git để apply ngược lại k8s

### Trường hợp cấu hình ứng dụng trên git
Hiện trạng ứng dụng của mình lúc này đang quản lý 3 tài nguyên là service, service account và deployment với 3 replicas.
> Lưu ý bước này mình sẽ tắt tính năng autosync của Application trên ArgoCD để dễ quan sát sự thay đổi và khác biệt giữa cấu hình thực tế và cấu hình định nghĩa trên git.

**Mình sẽ update cấu hình ứng dụng này ở file helm-value `app-demo-value.yaml` như sau:**
- Tăng số replicas lên thành 4 Pod
- Enable ingress => Sẽ tạo ra một resource mới là ingress

**Thông tin cập nhật:**
```
replicaCount: 4
```

```
ingress:
  enabled: true
  className: "local"
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: demo-helm.prod.viettq.com
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls: []
```

**Sau đó commit thay đổi lên `config repo` và chờ xem kết quả ở ArgoCD**.
![image.png](https://images.viblo.asia/22323dbc-a3a5-409b-a398-2bb1f75c453d.png)

**Argo đã báo cho chúng ta 3 vấn đề:**
- resource ingress `demo-app2-app-demo` có khai báo trên Git nhưng chưa tồn tại trên k8s
- resource deployment `demo-app2-app-demo` đang bị mất đồng bộ.

**Chúng ta có thể kiểm tra chi tiết sự mất đồng bộ ở đây là những tham số nào bằng cách chọn vào resource đó chọn diff:**
![image.png](https://images.viblo.asia/ab70f751-2b39-4e53-bff1-e5e599673ba8.png)

**Ta có thể ấn `SYNC` ở application để cập nhật thay đổi của tất cả resource của hệ thống:**
![image.png](https://images.viblo.asia/3f6ec1da-c418-4a81-8d3e-309b6472c651.png)

Lúc này 1 Pod mới sẽ được tạo ra để đảm bảo đúng số lượng Pod là 4 (như khai báo trên git) và 1 ingress mới được tạo ra:
![image.png](https://images.viblo.asia/5f37c5f7-db6d-4e71-aaff-e49e5218d276.png)

### Trường hợp thay đổi resource trên k8s
Tiếp tục bjo nếu ta thay đổi cấu hình các resource trên k8s thì ArgoCD sẽ phát hiện và cảnh báo.

**Mình sẽ thực hiện như sau:**
- Scale số Pod về 1
```
k -n demo2 scale deployment demo-app2-app-demo --replicas 1
```
- Đổi cấu hình service về ClusterIP

```
kubectl -n demo2 patch svc demo-app2-app-demo --type=''json'' -p ''[{"op":"replace","path":"/spec/type","value":"ClusterIP"},{"op":"replace","path":"/spec/ports/0/nodePort","value":null}]''
```

**Kiểm tra trên ArgoCD sẽ phát hiện ra ngay 2 resource bị mất đồng bộ là service và deployment:**
![image.png](https://images.viblo.asia/dc0493b2-13d3-40fd-a778-b081a2fabfe7.png)

**Chi tiết thay đổi của service:**
![image.png](https://images.viblo.asia/cbf1e395-3e59-4159-ba4d-977fe3aae29c.png)

**Chi tiết thay đổi của deployment:**
![image.png](https://images.viblo.asia/3a5fe42f-4666-4819-8431-992a3f71bcc6.png)

**Và ta chỉ việc đơn giản SYNC lại ứng dụng để đưa hệ thóng về lại đúng trạng thái mà ta mong muốn (là trạng thái theo cấu hình lưu trên Git):**
![image.png](https://images.viblo.asia/b4d43cbf-be27-4d99-8fa7-bb56989a5159.png)

# Tổng kết
Bài viết này khá dài nhưng hy vọng mọi người sẽ có cái nhìn rõ hơn về Gitops cũng như các ý tưởng xử lý trong luồng này. Bởi nó sẽ không bị bó buộc bởi một công cụ cụ thể nào cả, các bạn có thể linh động sử dụng các công cụ khác mà bản thân thấy quen dùng hơn.

**Qua nội dung bài này có thể gợi mở cho các bạn tìm hiểu thêm nhiều chủ đề khác nữa như:**
- Công cụ Gitops tương tự ArgoCD (FluxCD
- Các công cụ CI khác ngoài Jenkins (gitlab..)
- Phân quyền trên ArgoCD
- Quản lý phiên bản, rollback bằng ArgoCD..
- Sử dụng file deployment manifest thay vì dùng helmchart..

***Cảm ơn mọi người đã dành thời gian đọc tới đây. Nếu thấy bài viết hữu ích thì cho mình xin 1 upvote cho bài viết để tiếp tục ra nhiều nội dung mới nhé!***', '2023-02-09T09:40:10.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-10T02:27:30.000000Z'),
	('Blog#138: console.logだけではないconsoleの使い方法', 'qPoL7zDkJvk', '5', 'unlisted', 'https://images.viblo.asia/3c268ab0-7707-4b9a-b055-7fd815a7341c.png', '

この記事の主な目的は、日本語レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために簡単な日本語を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ日本語を学ぶことです。

こんにちは、私はトゥアンと申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

フロントエンド開発では、console.log()はとても便利なツールです。でも、consoleオブジェクトにはもっと便利なメソッドがあります。正しく、効率的にデバッグを行うために、consoleオブジェクトをよく調べてみましょう。

console.logの問題

console.logを使うだけでは、コードがconsole.logだらけになってしまい、ど...', '![image.png](https://images.viblo.asia/3c268ab0-7707-4b9a-b055-7fd815a7341c.png)

> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。
-----
こんにちは、私は[トゥアン](https://tuan-portfolio.web.app/#/)と申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fconsole.jpg%3Fw%3D1280%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=ff552c99ee45fccc06f1457430b1d58f "image_tooltip")](https://camo.qiitausercontent.com/9c0cc3526080307f47ee1bdb65177fdcdf0a43a2/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f636f6e736f6c652e6a70673f773d313238302673736c3d31)

フロントエンド開発では、`console.log()`はとても便利なツールです。でも、`console`オブジェクトにはもっと便利なメソッドがあります。正しく、効率的にデバッグを行うために、`console`オブジェクトをよく調べてみましょう。

# console.logの問題

`console.log`を使うだけでは、コードが`console.log`だらけになってしまい、どのコードが実行されているのかわかりにくくなってしまいます。今日は、`console`を使ってできる９つの方法を紹介します！

# console.table

`console.table`はデータを表の形にして見やすく表示してくれるので、データを読みやすくすることができます。

```js
const sweets = [
  { id: 1, name: "Ichigo Cake" },
  { id: 2, name: "Red Pudding" },
];
console.table(sweets);
```

実行すると、テーブルのような形で結果が返ってきます。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage.png%3Fw%3D546%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=ed4589a937207982fe105991e0239d67 "image_tooltip")](https://camo.qiitausercontent.com/d079043fabba7ebd87e147b9a604d6950d37c609/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652e706e673f773d3534362673736c3d31)

# console.group

`console.group`と`console.groupEnd`を使うと、階層があるデータをアコーディオンのようにグループにして表示できます。これで、階層が違うデータを操作しながら確認することができますよ。

```js
console.group("User Info");
console.log("Name: John Doe");
console.log("Age: 32");
console.groupEnd();
```

このようにクリックしてデータをトグルできるようになりました。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-1.png%3Fw%3D558%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=a127411707da5eeeceb576d9db04de65 "image_tooltip")](https://camo.qiitausercontent.com/786e0456d33f3ba6a71a19b2dad130844386f691/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d312e706e673f773d3535382673736c3d31)

# console.time

`console.time`と`console.timeEnd`を使うと、指定したコードブロックが実行されるまでの時間を計算できます。

特にパフォーマンスを検証するときに便利です。

今回はポケモンAPIのデータ取得にかかった時間をミリ秒で表示してみました。
```js
console.time("Fetching data");
fetch("https://pokeapi.co/api/v2/pokemon/ditto")
  .then((response) => response.json())
  .then((data) => {
    console.timeEnd("Fetching data");
    // Process the data
  });
```

このように`console.time()`と`console.timeEnd()`内のストリングが同じ名前になっている部分を計算してくれます。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-2.png%3Fw%3D558%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=114364a2995ebd99c060049efe2c68a8 "image_tooltip")](https://camo.qiitausercontent.com/64cbc0679abe8e65e231da9d7373c3368a601dd6/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d322e706e673f773d3535382673736c3d31)

# console.assert
`assert`は「断言する」という意味です。つまり、ある状況が常に正しいと想定しておきます。もし、その状況が正しくない場合には、予め記述しておいたメッセージを表示することができます。コードが正しく実行されているかを確認したり、バグを早期に発見するために役立ちます。

```js
function add(a, b) {
  return a + b;
}
// Test the add function
const result = add(2, 3);
console.assert(result === 50, "Expected 2 + 3 = 5");
```

この場合は、`resulet`が`50`で返ってくる想定として、`5`で返ってきたためにメッセージが表示されました。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-3.png%3Fw%3D552%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=87e3bde8d5560a9a4d1bc78b678f9736 "image_tooltip")](https://camo.qiitausercontent.com/e0485a48d75b21e41333d0446843b9e0d142de48/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d332e706e673f773d3535322673736c3d31)

もちろん、`result === 5`にすると関数が正しく作動していると検証されるのでコンソールには何も表示されなくなります。

# console.logのスタイリング
----------------------------------------------------------------------------------------------------

`console.log()`で表示させる内容をCSSでスタイリングすることができます。

```js
console.log("%cHello world!", "color: red; font-weight: bold;");
```

このようにボールドで、赤文字のテキストが表示されました。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-4.png%3Fw%3D557%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=742262d244e4c02bdbd74c8165235763 "image_tooltip")](https://camo.qiitausercontent.com/ec9c7bc776d07298c069ef4d108ca206c0eaa243/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d342e706e673f773d3535372673736c3d31)

# console.trace

`console.trace`はスタックトレースをアウトプットしてくれます。コードが複雑になり、実行される順番を確認したいときに便利になります。

```js
function foo() {
  console.trace();
}
function bar() {
  foo();
}
bar();
```

このように、関数`bar()`を実行した際に発火された`foo()`がどこから呼び出されたか理解することができます。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-5.png%3Fw%3D534%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=7d98e195f3d3042a171e373654acaf4c "image_tooltip")](https://camo.qiitausercontent.com/e7889bba86be0d73e0524b18a0161b70f702a61e/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d352e706e673f773d3533342673736c3d31)

# console.dir

`console.dir`は、オブジェクトを階層ごとで表示することができます。もしオブジェクトをコンソールからみたい場合はこの方法が有効的です。

```js
const obj = {
  id: 1,
  name: "John Doe",
  address: {
    street: "123 Main St",
    city: "New York",
    zip: 10001,
  },
};
console.dir(obj);
```

このようにトグルできるオブジェクトが表示されました。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-6.png%3Fw%3D530%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=8acdb313c8a268702158d4e7638a2c96 "image_tooltip")](https://camo.qiitausercontent.com/7d484fccb2c28e8b992c4cfb85d045d9c7049a09/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d362e706e673f773d3533302673736c3d31)

# console.count

`console.count`メソッドでは、指定したコードが何回実行されたのかトラッキングすることができます。

```js
function foo(x) {
  console.count(x);
}
foo("hello");
foo("world");
foo("hello");
```

このように、`foo(‘hello’)`が2回実行されたことが確認できますね。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-7.png%3Fw%3D557%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=3434cb7840d835b2460a417a8295dced "image_tooltip")](https://camo.qiitausercontent.com/9f07915ecb007247652e0da8abe06d71256dbddb/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d372e706e673f773d3535372673736c3d31)

# console.clear

`console.clear`を実行するとコンソールに表示されるデータがクリア（削除）されます。もし、デバッグのアウトプットが多くて対象のものにフォーカスしたい場合は使ってみるものありですね。

```js
console.log("Hello world!");
console.clear();
console.log("This log message will appear after the console is cleared.");
```

このように、`clear`されたことが表示されて、その後に新しくコンソールを使うことができます。

[![alt_text](https://qiita-user-contents.imgix.net/https%3A%2F%2Fi0.wp.com%2Fasameshicode.com%2Fwp-content%2Fuploads%2F2023%2F02%2Fimage-8.png%3Fw%3D547%26ssl%3D1?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&s=2ade9cae94ea7164ff31577984aaa733 "image_tooltip")](https://camo.qiitausercontent.com/27c7ea24c79c5f838882ce6a62b27440bcee3edc/68747470733a2f2f69302e77702e636f6d2f6173616d65736869636f64652e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032332f30322f696d6167652d382e706e673f773d3534372673736c3d31)

# まとめ

コンソールの使い方を９つ紹介しました。新しいものを覚えて、今日から使えるものはありましたか？ぜひ、活用してみてください！

# 最後

いつもお世話になっています。この記事を楽しんで、新しいことを学べたら嬉しいです。

今度の記事でお会いしましょう！この記事が気に入ったら、私を応援するために「LIKE」を押して登録してください。ありがとうございました。

-----
> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。

# リソース
* https://tuan200tokyo.blogspot.com/2023/02/blog138-consolelogconsole.html', '2023-02-09T08:34:49.000000Z', '2023-02-28T03:24:05.000000Z', '2023-02-09T08:32:14.000000Z'),
	('Blog#137: JavaScriptでのデコレーターデザインパターン', '0gdJzQXn4z5', '6', 'unlisted', 'https://images.viblo.asia/927346bb-36fa-47d9-a282-df05b4ae23b1.png', '

この記事の主な目的は、日本語レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために簡単な日本語を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ日本語を学ぶことです。

こんにちは、私はトゥアンと申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

**この記事では、JavaScriptでのデコレーターデザインパターンとは何か、なぜ有用なのかを学びます。**
デコレーターパターンとは何ですか？
デコレーターデザインパターンとは、既存のオブジェクトの構造を変更せずに、追加の機能を追加する方法です。これは、既存のオブジェクトを外部オブジェクトでラップして、その振る舞いを拡張することで実現します。
デコレータ...', '![image.png](https://images.viblo.asia/927346bb-36fa-47d9-a282-df05b4ae23b1.png)

> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。
-----
こんにちは、私は[トゥアン](https://tuan-portfolio.web.app/#/)と申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

_**この記事では、JavaScriptでのデコレーターデザインパターンとは何か、なぜ有用なのかを学びます。**_
# デコレーターパターンとは何ですか？
デコレーターデザインパターンとは、既存のオブジェクトの構造を変更せずに、追加の機能を追加する方法です。これは、既存のオブジェクトを外部オブジェクトでラップして、その振る舞いを拡張することで実現します。
# デコレーターデザインパターンはなぜ有用なのでしょうか？
デコレーターデザインパターンは、既存のオブジェクトの構造を変更せずに、簡単に追加の機能を追加できるため、有用です。特に、実装するには多くのコードが必要な機能がある場合に特に有用です。

# Javascriptで例

## ロギングデコレーター

この例では、関数が呼び出されるたびにメッセージをログに記録するロギングデコレーターを作成します。

```js
// Create the base function
function getData() {
  // Do something
}

// Create the LoggingDecorator
function LoggingDecorator(fn) {
  return function () {
    console.log(''Logging...'');
    fn();
  }
}

// Decorate the function
let decoratedFn = LoggingDecorator(getData);

// Call the decorated function
decoratedFn(); // Logs ''Logging...''
```

## キャッシュデコレーター

この例では、関数の呼び出しの結果をキャッシュに保存するキャッシュデコレーターを作成します。また、結果がキャッシュに既に存在するかどうかをチェックする機構を追加し、関数を呼び出すことなくその値を返すようにします。

```js
// Create the base function
function getData() {
  // Do something
}

// Create the cache
let cache = {};

// Create the CachingDecorator
function CachingDecorator(fn) {
  return function () {
    // Check if the result is in the cache
    if (cache[fn]) {
      return cache[fn];
    }

    // Call the function and store the result in the cache
    let result = fn();
    cache[fn] = result;
    return result;
  }
}

// Decorate the function
let decoratedFn = CachingDecorator(getData);

// Call the decorated function
decoratedFn();
```

## スロットルデコレーター

この例では、ある時間内に関数を1回しか実行しないように制限するスロットリングデコレーターを作成します。

```js
// Create the base function
function getData() {
  // Do something
}

// Create the ThrottlingDecorator
function ThrottlingDecorator(fn, delay) {
  let lastCallTime;
  return function () {
    // Check if the function was called before
    if (lastCallTime && (Date.now() - lastCallTime) < delay) {
      return;
    }

    // Call the function and store the time
    lastCallTime = Date.now();
    fn();
  }
}

// Decorate the function
let decoratedFn = ThrottlingDecorator(getData, 500);

// Call the decorated function
decoratedFn();
```

# まとめ
デコレーターデザインパターンとは、既存のオブジェクトの機能を拡張する簡単な方法です。コードサンプルを見て、このパターンがオブジェクトに追加機能を簡単に追加することがわかりました。

# 最後

いつもお世話になっています。この記事を楽しんで、新しいことを学べたら嬉しいです。

今度の記事でお会いしましょう！この記事が気に入ったら、私を応援するために「LIKE」を押して登録してください。ありがとうございました。

-----
> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。

# リソース
* https://tuan200tokyo.blogspot.com/2023/02/blog137-javascript.html', '2023-02-09T07:27:55.000000Z', '2023-02-27T03:49:07.000000Z', '2023-02-09T07:27:50.000000Z'),
	('Luyên thuyên về ChatGPT...', 'obA466G04Kv', '7', 'unlisted', 'https://images.viblo.asia/0ced0e5c-8ff3-425b-8f63-de9790f2d330.jpg', 'Đây là góc nhìn cá nhân của mình. Bài này mình viết luyên thuyên nên sẽ dài đó, cần cân nhắc trước khi đọc để không buồn ngủ nhé. Gẹt gô.

1. Mở đầu
Nào, dạo gần đây có gì hot nhỉ? ChatGPT everywhere.

Thật sự là không chỉ có Facebook, mà các trang báo lớn, các blog cũng đều đưa tin về con chatbot được ví như "Siêu AI" này vậy, lướt một tí là thấy, lướt một tí là thấy. Và theo quan điểm của mìn...', 'Đây là góc nhìn cá nhân của mình. Bài này mình viết luyên thuyên nên sẽ dài đó, cần cân nhắc trước khi đọc để không buồn ngủ nhé. Gẹt gô.

# 1. Mở đầu
Nào, dạo gần đây có gì hot nhỉ? ChatGPT everywhere.

![](https://images.viblo.asia/fd0f9678-b045-499f-af5d-a95a16a59cd8.jpeg)

Thật sự là không chỉ có Facebook, mà các trang báo lớn, các blog cũng đều đưa tin về con chatbot được ví như "Siêu AI" này vậy, lướt một tí là thấy, lướt một tí là thấy. Và theo quan điểm của mình, thì có lẽ truyền thông đang thổi phồng hơi quá về con chatbot này rồi thì phải 🤔🤔🤔 Thực ra cơ chế lõi (mà cũng là nền tảng cho các **Large Language Model (LLM)**) được công bố từ lâu rồi. Thế nên, bài viết hôm nay thì mình sẽ tản mạn một chút về con chatbot này, cũng như chia sẻ quan điểm của mình về nó. Oke gẹt gô.

# 2. Siêu AI (Artificial Super-Intelligence) là gì?

Mình thấy một số tờ báo tung hô ChatGPT là một **Siêu AI**, vậy **Siêu AI** là gì, và nó có đúng nó là một Siêu AI không nhỉ?

Trước tiên, nếu dựa vào **khả năng của AI** để phân loại thì chúng ta có thể chia AI làm 3 loại chính:
* **Narrow AI** (hay còn gọi là **Weak AI**, viết tắt là ANI): là những AI có khả năng thực hiện **một** tác vụ nhất định. Các mô hình AI thuộc dạng này sẽ mô phỏng lại một hành vi nào đó của con người thông qua những model được thiết kế sẵn và học từ một tập dữ liệu to. Ngày nay, phần lớn các ứng dụng AI đều thuộc dạng này, từ các *hệ thống gợi ý* (recommendation system) tới các *trợ lí ảo* (như Siri, Alexa, Google Assistant, v.v.) và còn nhiều thứ khác nữa. Những AI này hiện nay vẫn nằm trong tầm kiểm soát của con người, tức là chúng vẫn đang thực hiện những tác vụ cụ thể mà con người đặt ra, chưa có **nhận thức** sâu và chưa có khả năng thực hiện đa tác vụ như một con người.

![](https://images.viblo.asia/0ced0e5c-8ff3-425b-8f63-de9790f2d330.jpg)

* **General AI** (hay còn gọi là **Strong AI**, viết tắt là AGI): là những AI có khả năng thực hiện cùng lúc **nhiều** tác vụ nhất định (như con người vậy đó). Ngoài ra, khi AI đã đạt tới "cảnh giới" này thì AI bắt đầu có **nhận thức** về những gì nó đang làm, cũng như bắt đầu có những hành vi, biểu hiện giống con người (ví dụ như có khả năng tự học, phân tích lựa chọn, trao đổi, đưa ra ý kiến, v.v.). Nói chung là đến mức này thì AI thực sự "thông minh" rồi đấy. Hiện nay, "công dân robot" đầu tiên trên thế giới Sophia đã tiệm cận khả năng này (tất nhiên chưa được trơn tru mượt mà như con người rồi).

![](https://images.viblo.asia/8dcf25ea-3ded-4c88-9216-c0232c2bee7f.png)

* **Super AI** (viết tắt là ASI): là những AI mang tính **siêu việt**, tức là khả năng thực hiện đa tác vụ của chúng vượt trội hơn cả con người nhờ vào nguồn dữ liệu khổng lồ nó thu thập được, cũng như những tiến bộ về khoa học công nghệ. Ngoài ra, khả năng tự học, biểu diễn cảm xúc cũng như suy nghĩ, khả năng quyết định, blablabla của chúng cũng trở nên vượt trội, có thể vượt ra ngoài tầm kiểm soát của con người (Con Ultron trong phim Avengers là một ví dụ điển hình của thể loại này).

![](https://images.viblo.asia/cb8cdb8e-819a-43bd-800c-1812b93b244b.jpeg)

Từ những điều trên, theo mình thì hiện nay, mới chỉ có "công dân robot" Sophia là đang tiệm cận mức **General AI** thôi, còn cả một quá trình dài thật dài nữa mới đạt tới cảnh giới **siêu AI**. ChatGPT thì cũng ghê đấy, nhưng vẫn chưa đạt tới cảnh giới "General AI" đâu. Nếu ChatGPT được gọi là **siêu AI** thì những AI đạt tới cảnh giới **General AI**, hay xa hơn là **super AI** thì sẽ được gọi là gì nhỉ 🤔🤔🤔, siêu AI pro max ultra à?

Và thực ra, cái "gốc" của ChatGPT là một cơ chế đã được công bố từ năm 2015 rồi. Cơ chế đó là......
# 3. Attention, cơ chế lõi của các mô hình LLM, là gì?

## 3.1. Attention

Attention là một bài hát nổi tiếng của ca sĩ Charlie Puth. Xong 🤣

Đùa thôi, Attention (trong Deep Learning) là một cơ chế (mechanism) được ra đời vào năm 2015 bởi [**Bahdanau**](https://arxiv.org/pdf/1409.0473.pdf). Cơ chế này được giới thiệu qua rất nhiều bài blog rồi, vậy nên mình chỉ nói lại sơ lược một chút thôi nhé.

Trước khi cơ chế Attention ra đời, các mô hình **seq2seq** với 2 khối **encoder** và **decoder** (tạo thành từ các lớp RNN) được sử dụng để thực hiện bài toán Neural Machine Translation (NMT). Đã là "dịch" thì phải mã hóa mọt chuỗi từ ngôn ngữ này qua ngôn ngữ khác. Vì vậy:
* **Encoder** sẽ có nhiệm vụ xử lí thông tin đầu vào và mã hóa những thông tin này thành những *feature vectors*. Những feature vectors này sẽ trở thành đầu vào của tầng Decoder.
* **Decoder** sẽ có nhiệm vụ dựa vào đầu ra từ tầng Encoder để tìm ra phân phối xác suất từ các feature vectors, từ đó tìm ra label tương ứng. Nói nôm na là ánh xạ dữ liệu từ miền này qua miền khác.

Sử dụng RNN sẽ rất hiệu quả đối với những câu văn ngắn, tuy nhiên, với những câu văn dài thì sử dụng RNN sẽ dễ bị hiện tượng *vanishing gradient*, chưa kể còn có thể bị bỏ quên thông tin nào đó. Lúc đó thì LSTM lại có thể giải quyết được vấn đề này. Tuy nhiên thì LSTM lại tốn nhiều thời gian để huấn luyện và không thể thực hiện *transfer learning* được. Vì vậy, cơ chế *Attention* ra đời như là "cứu tinh" của bài toán này vậy.

Đúng như tên gọi , cơ chế này sẽ "tập trung" toàn bộ thông tin từ tầng Encoder về một mối để taọ ra một *context vector* thay vì chỉ sử dụng vector trạng thái ẩn của state cuối cùng để tạo ra vector biểu diễn cho decoder. Điều này sẽ khắc phục các nhược điểm của RNN, bao gồm việc bỏ sót thông tin (vì khi encode một lượng lớn thông tin trong một vector biểu diễn nhỏ thì chắc chắn sẽ có sự bỏ sót thông tin rồi). Chi tiết thuật toán thì mọi người có thể tìm đọc trong paper gốc nhé.

![](https://images.viblo.asia/96b5dfd1-546f-404b-ac10-a23e96e04b04.png)

<div align="center">
           Cơ chế Attention
</div>


## 3.2. Transformer, kẻ kế thừa vĩ đại

Sau sự ra đời của cơ chế Attention, thì một model đã ra đời đã tạo ra bước ngoặt biến đổi thế giới NLP. Đó chính là **Transformer**, được giới thiệu trong bài báo với cái tên huyền thoại: [**Attention is all you need**](https://papers.nips.cc/paper/2017/file/3f5ee243547dee91fbd053c1c4a845aa-Paper.pdf). Những đặc điểm sau đã giúp Transformer "một bước lên mây" và trở thành kiến trúc được rất nhiều "hậu bối" áp dụng (trong đó có cả nhân vật chính của bài này):
* Thứ nhất đó là ứng dụng thành công Attention, cụ thể là cơ chế *self-attention*. Theo đó, self-attention là cơ chế giúp cho encoder có thể "nhìn" được các từ xung quanh trong khi đang mã hoá một từ cụ thể, do đó, có thể hiểu được sự liên quan giữa các từ trong 1 câu bất kể khoảng cách có xa tới đâu.

![](https://images.viblo.asia/bc085e0a-1042-4e1c-8888-f53f2bdfeba2.png)

<div align="center">
            Minh hoạ cơ chế Self-Attention
</div>

* Thứ hai đó là sự kết hợp giữa ưu điẻm của CNN và ưu điểm của RNN, đó là tính toán *song song* bằng cách học chuỗi hồi tiếp với cơ chế tập trung, đồng thời mã hoá vị trí của từng phần tử trong chuỗi (thay vì xử lí các phần tử trong chuỗi một cách tuần tự). Điều này giúp Transformer có thể tận dụng được khả năng của GPU và giúp tiết kiệm thời gian huấn luyện hơn.

Kiến trúc cũng như cách thức hoạt động của mô hình này thì mọi người có thể tham khảo lại tại paper gốc, hoặc các blog khác nhé.

![](https://images.viblo.asia/5ed0b3c1-da79-4472-a107-8ff8029500fa.png)

<div align="center">
            Một tầng Transformer
</div>


Có thể nói, cơ chế Attention và kiến trúc Transformer đã mở ra một thời đại mới cho các mô hình LLM. Một trong số đó có thể kể đến GPT-3, mô hình được coi là "bố" của ChatGPT. GPT-3 là thế hệ thứ 3 của "dòng họ" GPT, được phát triển bởi OpenAI. GPT-3 ứng dụng cơ chế Attention để tạo ra mô hình có khả năng sinh ngôn ngữ giống như người thật. Nguyên lí hoạt động của GPT và ChatGPT thì để bài khác nhé.

Nhìn chung, về mặt kĩ thuật, có thể nói ChatGPT không phải là một kiến trúc đủ mới để tạo bước ngoặt hay tiếng vang lớn như "ông tổ" Transformer đã từng. Vậy tại sao con Chatbot này lại hot đến vậy?
# 4. Tại sao ChatGPT lại hot hòn họt đến vậy?

## 4.1. Sao lại hot vậy nhỉ?

Theo góc nhìn của mình thì có những lí do sau:
* Thứ nhất, nó được "thừa hưởng" những tinh hoa của ông bố nó, là GPT-3. Việc được thừa hưởng từ một model có tới 175 tỉ tham số đã đem lại cho ChatGPT một lợi thế đáng kể trong khả năng sinh ngôn ngữ để giao tiếp như người thật.
* Thứ hai, đó là việc OpenAI đã "liều" khi thương mại hoá con chatbot mà ngay cả chính những người trong cuộc coi là một sản phẩm "tình thế" để giải quyết các khó khăn. Tại sao lại gọi là "liều"? Vì các ông lớn, đặc biệt là Google, nơi khai sinh ra kiến trúc Transformers cũng đã có một con chatbot cho riêng mình. Tuy nhiên, họ đã không công bố vì lo ngại vấn đề nội dung độc hại, hoặc độ chính xác của thông tin do con chatbot của họ có thể sinh ra. Cái này giống như là "ông không làm thì để tôi" vậy đó.
* Thứ ba, đó là do yếu tố truyền thông. Mọi người có công nhận là những nội dung về ChatGPT đang xuất hiện dày đặc trên các trang báo không? Và từ lúc ChatGPT trở nên nổi tiếng thì hàng loạt meme được ra đời, làm mình cũng không biết đâu là đoạn chat thật, đâu là sản phẩm của Photoshop nữa. Thế nên, tò mò ắt sẽ phải tìm hiểu, và vô hình chung đã làm cho chatbot này trở nên viral hơn thôi.

**Update**: Ngày 06/02/2023 thì Google đã công bố, chatbot **Bard** của họ (được "thừa hưởng" từ LaMDA, cũng là một LLM do Google xây dựng nên) đang trong quá trình thử nghiệm và đánh giá, sắp tới sẽ được công bố rộng rãi tới người dùng. Đồng thời, Baidu cũng đã công bố kế hoạch phát triển chatbot của riêng họ mang tên **Ernie Bot**. Chà, đại chiến chatbot sắp bùng nổ rồi đây... Thế là AI ngày càng được phổ biến một cách rôngj rãi tới mọi người rồi. Nhưng......

![](https://images.viblo.asia/c9627cb8-04fb-4072-8429-46a9c3262b82.png)

<div align="center">
            Google sắp công bố Bard, chatbot đối trọng với ChatGPT
</div>


## 4.2. ChatGPT và Google Search

Một khía cạnh khác mà mình muốn chia sẻ quan điểm, đó là việc nhiều người coi ChatGPT là công cụ thay thế Google Search. Thừa nhận đi, bạn có cảm thấy kích thích khi thông tin chúng ta tìm kiếm được "trả lời" ngay tức khắc, và đến từ một con chatbot có khả năng nói chuyện một cách khá mượt mà như một người bạn không? (Đúng nhận, sai cãi nào 🤣).

Tuy nhiên cần phải làm rõ, là Google Search sẽ giúp chúng ta *tự chọn lọc thông tin* khi chúng ta tìm hiểu về cái gì đó. Còn khi chúng ta sử dụng ChatGPT để giải đáp thắc mắc, chúng ta thường sẽ có xu hướng ít khi kiểm tra lại thông tin vì chúng ta đã có một niềm tin mãnh liệt, rằng "AI này luôn đúng" và việc một con chatbot có khả năng trò chuyện như người bình thường cung cấp thông tin một cách trực tiếp sẽ làm chúng ta bị "lười" đi đấy.

Điều này nguy hiểm nhé, vì chính những nhà phát triển cũng khuyến cáo rằng thông tin do ChatGPT đưa ra có thể sai, và không nên quá phụ thuộc vào nó, đặc biệt là khi hiện nay có rất nhiều bạn học sinh, sinh viên sử dụng công cụ này để gian lận trong các bài kiểm tra, khóa luận, v.v.

![](https://images.viblo.asia/a9f081aa-6834-488a-a511-b86db145b931.png)


## 4.3 Điểm yếu của ChatGPT

Ai cũng biết về điểm mạnh rồi, thế bây giờ nói về điểm yếu của chatbot này nhé.

Đầu tiên đó là việc chatbot này có thể cung cấp thông tin sai sự thật. Bà Mira Murati, CTO của OpenAI, "nữ tướng" đứng sau thành công của ChatGPT đã thừa nhận điều này. Theo đó, vì dựa trên công nghệ RLHF (Học tăng cường dựa theo phản hồi của người dùng) mà người dùng có thể cung cấp thông tin sai lệch cho chatbot, khiến cho chatbot có thể học theo.

Thứ hai, vốn dĩ ChatGPT vẫn chỉ là một **Narrow AI** như đã nói ở trên, việc cập nhật thông tin theo thời gian thực để huấn luyện mô hình là một trở ngại lớn. Theo đó, nguồn dữ liệu dùng để huấn luyện chatbot này mới được cập nhật đến năm 2021, do đó, nếu bạn hỏi thông tin về chiếc Samsung Galaxy S23 thì chưa chắc nó đã trả lời đúng đâu.

Thứ ba, đó là vấn đề bảo mật thông tin. Các doanh nghiệp muốn dùng ChatGPT thì phải cung cấp thông tin cho chatbot này (vẫn là RLHF), vậy nên, chẳng ai muốn thông tin nhạy cảm của công ti mình bị bại lộ cho toàn thế giới biết cả.

Và còn hàng loạt những điểm yếu khác, vì ChatGPT hiện tại vẫn chưa có khả năng độc lập suy nghĩ như nhiều người vẫn tưởng.

![](https://images.viblo.asia/eec00dfb-9e61-473d-b0dd-d73fcb07086e.png)

<div align="center">
            Ảnh lấy từ blog của OpenAI (https://openai.com/blog/chatgpt/)
</div>

# 5. Kết luận

Nói nhiều nói dài mãi mới đến kết luận 🤣 Tính mình thích nói dài nên viết cũng dài luôn.

Đối với mình, một kỹ sư AI, việc AI được phổ biến rộng rãi tới người dùng là một điều tốt, sẽ giúp cho mọi người có thể ứng dụng những lợi ích của AI vào trong công việc hằng ngày. Tuy nhiên có những điều mình thấy không ổn:
* Thứ nhất là truyền thông đang thổi phồng về những gì ChatGPT đang làm được.
* Nhiều người lại đang phụ thuộc vào con chatbot này, cũng như có nhiều người lợi dụng con chatbot này để làm nhưng việc sai trái. Vì vậy, cần phải có cái nhìn đúng đắn về nó, cũng như các mô hình, ứng dụng AI nói chung để chúng ta sử dụng nó một cách có ích, chứ không phải là phụ thuộc nó và lợi dụng nó.

Vì vậy, hãy có cái nhìn đúng đắn về AI nói chung, và ứng dụng AI một cách thực tế và đúng đắn nhất để AI trở thành "trợ lí" đắc lực cho cuộc sống của chúng ta.

Mọi người có chia sẻ, góp ý gì thì cho mình biết nhé. Cheers.

# Tài liệu tham khảo:

[**Bahdanau 2015**](https://arxiv.org/pdf/1409.0473.pdf)

[**Attention is all you need**](https://papers.nips.cc/paper/2017/file/3f5ee243547dee91fbd053c1c4a845aa-Paper.pdf)

[**Sách: Dive into Deep Learning, chương 10, 11**](https://d2l.ai/)

[**What Are the Types of Artificial Intelligence: Narrow, General, and Super AI Explained**](https://www.spiceworks.com/tech/artificial-intelligence/articles/types-of-ai/#:~:text=While%20narrow%20AI%20refers%20to,function%20just%20as%20humans%20do.)

[**Google: An important next step on our AI journey**](https://blog.google/technology/ai/bard-google-ai-search-updates/)

[**ChatGPT: Optimizing Language Models for Dialogue**](https://openai.com/blog/chatgpt/)', '2023-02-09T07:08:28.000000Z', '2023-02-28T04:02:06.000000Z', '2023-02-09T07:08:22.000000Z');

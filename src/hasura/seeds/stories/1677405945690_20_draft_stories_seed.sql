SET check_function_bodies = false;
INSERT INTO "stories" ("title", "contents", "hashid", "user_id", "preview_image", "preview_content", "created_at", "updated_at") VALUES
	('97 lời khuyên dành cho lập trình viên – Phần 5', 'Bạn có thể xem bài viết gốc của mình tại đây: https://phucluong.com/97-loi-khuyen-danh-cho-lap-trinh-vien-phan-5/

## Điều 21 – Distinguish Business Exceptions from Technical – Tách biệt rạch ròi giữa “lỗi” hệ thống và “lỗi” nghiệp vụ
“Lỗi” hệ thống (tạm dịch từ “technical exception”) ám chỉ những lỗi đến từ phía lập trình viên, hoặc phía hệ thống (không phải lỗi của người dùng). Ví dụ:

* Bạn có một mảng gồm 17 phần tử, nhưng bạn lại cố gắng truy xuất dữ liệu tại phần tử thứ 83.
* Bạn sử dụng sai cú pháp/quy định (contract) của các thư viện, ví dụ như có một hàm của thư viện yêu cầu bạn truyền vào 2 tham số, nhưng bạn chỉ truyền 1, hoặc tham số truyền vào của bạn không đúng với những gì mà hàm đó kì vọng (“wrong type” chẳng hạn).
* Database bị chết hoặc đường truyền có vấn đề khiến dữ liệu không thể truyền đến người dùng.

“Lỗi” nghiệp vụ (tạm dịch từ “business exception”) ám chỉ những lỗi đến từ phía người dùng, khi họ sử dụng sản phẩm không đúng cách hoặc thiếu các bước cần thiết. Ví dụ:

* Người dùng chỉ có 500 nghìn trong tài khoản ngân hàng, nhưng họ lại muốn rút 1 triệu.
* Người dùng nhập dữ liệu nhân viên, nhưng lại nhập thiếu thông tin phòng ban của nhân viên ấy.

Ở góc độ lập trình viên, việc nhập nhằng giữa lỗi hệ thống và lỗi nghiệp vụ sẽ khiến luồng xử lý lỗi của bạn khó bảo trì và mở rộng. Bạn cần thiết kế làm sao để lỗi hệ thống và lỗi nghiệp vụ sẽ được xử lý theo những luồng khác nhau, tránh trộn lẫn với nhau khiến không chỉ người dùng mà cả bạn (và các lập trình viên khác) cảm thấy bối rối. Quay lại với ví dụ “rút tiền” ở trên, thay vì thông báo lỗi nghiệp vụ kiểu như “không đủ tiền trong tài khoản”, hệ thống lại thông báo lỗi hệ thống kiểu như “có lỗi hệ thống, vui lòng thử lại”.

Với lỗi nghiệp vụ, cần thông báo lỗi cụ thể để giúp người dùng biết được lỗi đến từ phía mình, và hướng dẫn họ cách sửa lỗi bằng cách điều chỉnh các thao tác nghiệp vụ. Với lỗi hệ thống, bạn có thể thông báo lỗi chung chung (một cách lịch sự) như “có lỗi hệ thống, vui lòng thử lại hoặc liên hệ admin”, hoặc “có lỗi về kết nối đường truyền”…

## Điều 22 – Do Lots of Deliberate Practice – Thường xuyên làm việc có chủ đích
Làm việc có chủ đích (tạm dịch từ “Deliberate Practice”) là việc thường xuyên thực hành một công việc với mục tiêu là thuần thục kĩ năng hoàn thành công việc ấy. Nếu bạn đặt câu hỏi: “tại sao tôi lại làm công việc này”, và câu trả lời của bạn là “để hoàn thành công việc ấy”, thì đó không phải là “deliberate practice”. Mục tiêu của việc “làm việc có chủ đích” là để thuần thục kĩ năng hoàn thành công việc, chứ không phải chỉ đơn thuần là làm xong công việc.

Hãy tự đặt câu hỏi cho bản thân rằng, bạn đã dành bao nhiêu thời gian cho việc lập trình các sản phẩm của các công ty mà bạn đã và đang làm việc? Và bạn đã dành bao nhiêu thời gian cho việc xây dựng bản thân?

Theo bạn, làm bao lâu thì sẽ đạt được mức thuần thục công việc? Peter Norvig (http://norvig.com/21-days.html) và Mary Poppendieck (tác giả sách Leading Lean Software Development) đều cho rằng bạn cần ít nhất 10,000 giờ lập trình để có thể trở thành một chuyên gia trong lĩnh vực của mình (tương đương khoảng 20 giờ mỗi tuần, liên tục trong 10 năm). Tất nhiên là không phải bạn cứ phải đạt đủ 10,000 giờ thì mới là chuyên gia, mà kĩ năng của bạn đã được tích lũy tăng dần đều qua năm tháng.

Các nhà nghiên cứu cho rằng dù những người có tài năng thiên bẩm thì họ cũng sẽ chạm ngưỡng năng lực của họ nếu không thật sự cố gắng. Ngược lại, thành quả lớn sẽ đến với bất kì ai dù chỉ có một ít khả năng tự nhiên, nhưng nỗ lực không ngừng nghỉ.

Một điểm lưu ý khác nữa, việc “làm việc có chủ đích” không đơn giản là lặp đi lặp lại mãi một việc, mà là phải liên tục thử thách bản thân với những mức độ khó dần, những việc nằm ngoài khả năng chuyên môn hiện tại của bạn. Thử thách chúng, và tự đánh giá bản thân sau khi hoàn thành (hoặc không hoàn thành) các công việc ấy.

Lời kết, “làm việc có chủ đích” xoay quanh một vấn đề duy nhất, đó là việc học hỏi (learning). Chính việc học hỏi không ngừng sẽ thay đổi con người bạn, và thay đổi cả những hành vi của bạn. Chúc bạn thành công.

## Điều 23 – Domain-Specific Languages – Ngôn ngữ chuyên ngành
Bất cứ ngành nghề nào (bác sĩ, giáo viên, kì thủ cờ vua…), đều có những ngôn ngữ đặc thù (chuyên ngành) của ngành nghề đó. Dù bạn là người Việt, nói tiếng Việt, nhưng khi nghe 2 chuyên gia về lĩnh vực bảo hiểm nói chuyện với (bạn không có chuyên môn về bảo hiểm), thì có thể bạn cũng sẽ lùng bùng lỗ tai với những thuật ngữ mới lạ. Đó được gọi là “domain-specific languages” (DSLs): một lĩnh vực chứa các từ ngữ chuyên dụng và đặc trưng để mô tả cho những thứ trong lĩnh vực ấy.

Trong lĩnh vực phần mềm của chúng ta, DSLs là những đoạn lệnh/code/script để thực thi những tác vụ cụ thể, chúng sẽ khác nhau tùy vào ngôn ngữ lập trình. Chúng thường có hạn chế số lượng từ vựng, ngữ pháp so với ngôn ngữ của loài người, và cú pháp của nó cũng khó đọc, khó hiểu, đôi khi những ngôn ngữ ấy chỉ dành cho máy móc chứ không dành cho con người để đọc hiểu chúng.

Bạn phải luôn luôn biết đối tượng mà bạn đang tương tác khi sử dụng các ngôn ngữ chuyên ngành phần mềm của chúng ta. Họ là những lập trình viên, nhà quản lý, khách hàng, hay người dùng cuối? Bạn phải biết linh hoạt lựa chọn từ ngữ để nói chuyện với từng đối tượng khác nhau. Ví dụ:

* Có bao giờ bạn đi nhậu với đám bạn thân, nhưng lại nói chuyện về công việc lập trình của mình, và đám bạn chả hề quan tâm hay thấy hứng thú gì cả?
* Với những câu thông báo lỗi trên màn hình, nếu bạn nhắm đến đối tượng là người dùng không có kiến thức chuyên sâu về IT, thì những câu lỗi hiển thị nên dễ hiểu, phù hợp với họ, để họ hiểu cơ bản nguyên nhân lỗi và cách khắc phục. Hoặc nếu những câu thông báo lỗi dành cho những lập trình viên khác, thì nội dung cũng cần phải thay đổi để thể hiện chi tiết và chuyên sâu hơn.
* Hoặc khi bạn báo cáo vấn đề công việc với sếp của bạn, người sếp của bạn có chuyên môn cao về IT không? Dù có hay không, bạn cần phải trình bày vấn đề linh hoạt làm sao để người sếp của bạn hiểu được vấn đề, có thể ra quyết định hợp lý (và không bị cảm giác “quê” trước nhân viên của mình). Chúng ta không nên tỏ ra xem thường sếp của mình nếu họ không hiểu những vấn đề về kĩ thuật, mà hãy xem lại bản thân đã trình bày vấn đề dễ hiểu hay không.

## Điều 24 – Don’t Be Afraid to Break Things – Đừng sợ phải làm hỏng thứ gì.
Chắc hẳn các bạn đã từng ít nhất một lần làm trong một dự án vô cùng mong manh dễ vỡ. Nó được xây dựng kém ngay từ thời điểm ban đầu, hoặc do qua quá nhiều lần thay da đổi thịt bởi những nhóm lập trình khác nhau, nên việc thay đổi một thứ gì đó có thể sẽ làm một module không liên quan khác bị lỗi. Và khi bạn thêm một module mới, bạn phải cố gắng hạn chế phạm vi ảnh hưởng của nó nhiều nhất có thể để tránh rủi ro, và cầu nguyện cho mọi thứ suôn sẻ khi release.

Lý do là vì hệ thống ấy đang mắc bệnh, và nó cần một người bác sĩ chữa trị cho nó. Nếu không, tình trạng bệnh chỉ có nặng dần lên theo năm tháng mà thôi. Một bác sĩ phẫu thuật có kinh nghiệm, họ biết rằng việc phẫu thuật là cần thiết để cứu lấy bệnh nhân, và kết quả sẽ hoàn toàn xứng đáng với công sức mà vị bác sĩ ấy bỏ ra, đó là việc bệnh nhân khỏe lại sau ca phẫu thuật.

Đừng sợ chính mã nguồn của bạn. Chính nỗi sợ này khiến bạn không dám thay đổi, như hệ thống có bệnh nhưng không có người chữa bệnh, và nó ngày càng trầm trọng hơn. Hãy dành thời gian để đánh giá và tái cấu trúc (nếu cần thiết). Và tương tự, kết quả sẽ xứng đáng với công sức mà bạn đã bỏ ra. Một lợi ích khác nữa là bạn (và nhóm của bạn) sẽ có những kinh nghiệm quý báu trong việc giải quyết những vấn đề của những hệ thống yếu kém, và bạn sẽ nhanh chóng thành những chuyên gia. Nếu vô tình bạn được phân công vào một hệ thống như vậy, đừng trách móc hay chán nản, mà hãy vui lên vì bạn đang có một cơ hội hiếm có để thực hành và phát triển bản thân, cũng như thể hiện năng lực bản thân với mọi người. Thái độ của bạn sẽ truyền cảm hứng cho những người xung quanh cũng muốn làm tương tự, hoặc ít nhất cũng sẽ có những ý niệm trong đầu.

Để tránh việc chán nản hay bỏ cuộc giữa chừng, hãy cố gắng phân nhỏ công việc, hoàn thành từng chút một, và đi kèm với test cẩn thận. Hãy thuyết phục sếp của bạn và nhấn mạnh về tầm quan trọng của công việc ấy. Nó có thể không có kết quả rõ rệt và thấy được trước mắt, nhưng chắc chắn nó sẽ giúp giảm chi phí và công sức cho những lần release tiếp theo.

## Điều 25 – Don’t Be Cute with Your Test Data – Đừng tinh nghịch với dữ liệu kiểm thử
Trong một lần làm việc muộn cuối ngày, tôi đã đưa một số dữ liệu giả để thử nghiệm cho layout mới mà tôi đang phát triển. Dữ liệu này cần có tên người dùng, tên công ty, và mã chứng khoán với 4 kí tự in hoa. Với tên người dùng, tôi chọn tên các thành viên trong ban nhạc The Clash. Với tên công ty, tôi chọn các bài hát của nhóm Sex Pistols. Với mã chứng khoán, tôi đã chọn 4 chữ cái kinh điển mà chắc bạn đã biết là gì. (Mình đoán là từ “F**K”)

Mục đích của tôi chỉ là để giải trí thời điểm ấy, và dự định là ngày mai đồng nghiệp của tôi sẽ giúp kết nối với dữ liệu thật sau. Tuy nhiên, vào sáng hôm sau, người quản lý dự án đã chụp màn hình một số trang ấy cho một buổi thuyết trình.

Lịch sử ngành chúng ta có rất nhiều việc như vậy từng xảy ra. Người lập trình viên, hay người thiết kế nghĩ rằng dữ liệu mẫu này sẽ không có ai thấy được đâu, tuy nhiên vô tình chúng lại bị lọt ra bên ngoài, tìm ẩn những rủi ro kinh khủng về hình ảnh/danh tiếng của một người, một nhóm, hay cả công ty. Ví dụ:

* Trong một buổi họp với khách hàng, khi khách hàng click vào một button (chưa được hoàn thiện phần code bên dưới), một popup hiện ra với nội dung “Đừng click nữa, đồ ngốc”.
* Một lập trình viên được yêu cầu hiển thị một popup thông báo lỗi ở một hệ thống nọ, và người này quyết định lấy log lỗi được lưu trong hệ thống để xuất ra màn hình. Và một ngày nọ, người dùng bất ngờ thấy một thông báo lỗi: “Holy database commit failure, Batman!”
* Một ai đó nghịch ngợm với hệ thống quản lý dữ liệu (admin), và thêm một sản phẩm “cho vui” và hệ thống bán hàng online: “Máy mát xa cá nhân hình Bill Gates”.

Ngay cả mã nguồn của bạn cũng cần phải cẩn thận. Vào năm 2004, khi mã nguồn của Window 2000 bị lộ trên mạng, một số người đã phát hiện ra những câu comment “thú vị” của các lập trình viên trong mã nguồn của họ.

Nói tóm lại, khi viết bất kì một từ gì trong code của bạn, dù cho nó là comment, log, popup, hay dữ liệu mẫu (test data), hãy cân nhắc trước khi viết, và thử tưởng tượng nếu những từ ngữ này bị lộ ra ngoài thì sẽ như thế nào. Tốt nhất là bạn hãy luyện bản thân mình luôn luôn tỉnh táo và không đùa nghịch quá trớn khi làm việc.', '2oKLnNx1LQO', '1', 'https://images.viblo.asia/bb643888-c636-4d07-9e27-8d46256ddbc5.jpg', 'Bạn có thể xem bài viết gốc của mình tại đây: https://phucluong.com/97-loi-khuyen-danh-cho-lap-trinh-vien-phan-5/

Điều 21 – Distinguish Business Exceptions from Technical – Tách biệt rạch ròi giữa “lỗi” hệ thống và “lỗi” nghiệp vụ
“Lỗi” hệ thống (tạm dịch từ “technical exception”) ám chỉ những lỗi đến từ phía lập trình viên, hoặc phía hệ thống (không phải lỗi của người dùng). Ví dụ:

* Bạn có ...', '2023-02-27T03:13:00.000000Z', '2023-02-27T04:24:06.000000Z'),
	('Trò chơi cờ Caro - Xây dựng game chơi với Human và Computer bằng JavaScript', '**Tháng ba bất chợt một ngày trắng tinh hoa sưa về đây... Hà Nội, Chủ Nhật 26/02/2023...**

*Ta vội bước trên phố phường Hà Nội*
*Bỗng gặp hàng sưa trắng một màu hoa*
*Trắng cả góc trời níu bước chân qua*
*Lưu luyến qúa chùm hoa sưa lặng lẽ*

*Hương hoa không nồng nàn như hoa sữa*
*Không sắc màu tím biếc cánh bằng lăng*
*Không vàng thẫm một màu hoa điệp lan*
*Mà nhẹ nhàng nét duyên sưa trắng muốt...*

![image.png](https://images.viblo.asia/03aefef6-4bec-4dfa-a187-db0b168152b8.png)

# 1\. Giới thiệu

## 1.1. Tổng quan

Trò chơi cờ caro cũng không quá xa lạ với tuổi thơ của các bạn đúng không? Chúng ta có thể chơi cờ caro ở chế độ người vs người với nhau. Hoặc nâng cao hơn một chút sẽ chơi người với máy. Và trở nên fancy hơn nữa là chúng ta tạo ra 2 máy cho chúng tự chơi với nhau. Ở bài viết này cùng mình xây dựng trò chơi caro với 3 chế độ nhé:

* Human vs Human

* Human vs Computer

* Computer vs Computer


## 1.2. Giới thiệu trò chơi

Cờ ca-rô (hay sọc ca-rô) là một trò chơi dân gian. Cờ ca-rô trong tiếng Triều Tiên là omok (오목) và trong tiếng Nhật là 五目並べ (gomoku narabe); tiếng Anh, sử dụng lại tiếng Nhật, gọi là gomoku. Ban đầu loại cờ này được chơi bằng các quân cờ vây (quân cờ màu trắng và đen) trên một bàn cờ vây (19x19). Quân đen đi trước và người chơi lần lượt đặt một quân cờ của họ trên giao điểm còn trống. Người thắng là người đầu tiên có được một chuỗi liên tục gồm 4 quân hàng ngang, hoặc dọc, hoặc chéo không bị chặn đầu nào. Một khi đã đặt xuống, các quân cờ không thể di chuyển hoặc bỏ ra khỏi bàn, do đó loại cờ này có thể chơi bằng giấy bút. Ở Việt Nam, cờ này thường chơi trên giấy tập học sinh (đã có sẵn các ô ca-rô), dùng bút đánh dấu hình tròn (O) và chữ X để đại diện cho 2 quân cờ.

## 1.3. Luật chơi

Theo các giải thi đấu quốc tế hiện tại, Gomoku được chơi theo luật Swap2 để đáp ứng công bằng. Người đi trước xếp 3 quân cờ đầu tiên lên bàn theo ý muốn và để người đi sau chọn:

* Nếu đồng ý với thế cờ, người đi sau chỉ cần chơi tiếp từ nước thứ 4 như thường lệ.

* Nếu không đồng ý với thế cờ, người đi sau có thể đổi bên hoặc đặt thêm 2 quân cờ tiếp theo (tạo thế mới) để người đi trước chọn màu (quân cờ đầu tiên luôn là màu đen), ván cờ tiếp tục như thường lệ từ thế cờ đó.


Theo luật Standard gomoku, một hàng có nhiều hơn 5 quân liên tiếp cùng màu (overline) không được coi là thắng lợi, trận đấu vẫn tiếp tục cho đến khi một bên có đúng 5 quân trong hàng hoặc kết quả sẽ là hòa, nếu không có ai đáp ứng điều kiện đó. Biến thể Free gomoku thì chỉ cần có từ 5 quân thẳng hàng trở lên, không cần cố định phải là đúng 5 quân như luật Standard. Trong thi đấu quốc tế, luật thi đấu dựa trên hình thức: người nào ăn 5 trên 9 ván cờ trước thì thắng.

# 2\. Cấu trúc game project

![image.png](https://images.viblo.asia/4f7739a6-b1a5-44f8-adc3-00656fb6a768.png)

* **css**: Thư mục lưu các file css để căn chỉnh, làm đẹp giao diện.

* **images**: Thư mục sẽ lưu các hình ảnh của trò chơi : Phím bấm, ảnh nền,...

* **js**: Thư mục chứa các file JavaScript để xử lý các chức năng của game.

* **caro.html, home.html**: Giao diện trò chơi.


# 3\. Xây dựng trò chơi

## 3.1. Giao diện trò chơi

* **home.html** : Giao diện trang chủ game Ca-rô


```html
<!DOCTYPE html>
<html lang="en">

<link rel="stylesheet" href="../common/css/home.css">
<link rel="stylesheet" href="css/caro.css">

<head>
    <meta charset="UTF-8">
    <title>Home game tic tac toe</title>
</head>
<body>
<div>
    <div class="options">
        <label for="list-type-play"></label><select id="list-type-play" class="hide-option option">
        <option selected="selected" disabled="disabled" value="">Select type play</option>
        <option value="2-players">2 players</option>
        <option value="player-computer">Player and computer</option>
        <option value="computer-computer">Computer and computer</option>
    </select>
    </div>

    <div class="options" style="margin-top: 30px">
        <label for="list-row"></label><select id="list-row" class="hide-option option">
        <option selected="selected" disabled="disabled" value="">Select amount of rows</option>
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="30">30</option>
        <option value="40">40</option>
        <option value="50">50</option>
        <option value="60">60</option>
    </select>
    </div>

    <div class="options" style="margin-top: 30px">
        <label for="list-column"></label><select id="list-column" class="hide-option option">
        <option selected="selected" disabled="disabled" value="">Select amount of columns</option>
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="30">30</option>
        <option value="40">40</option>
        <option value="50">50</option>
        <option value="60">60</option>
    </select>
    </div>
</div>

<div class="button" id="button" onclick="handleLetGo()">Let''s go!</div>
</body>
</html>

<script type="text/javascript" src="js/caro-home.js"></script>
```

* **caro.html**: Giao diện trò chơi


```html
<!DOCTYPE html>
<html lang="en">

<link rel="stylesheet" href="css/caro.css">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game caro</title>
    <link href="https://fonts.googleapis.com/css?family=Indie+Flower" rel="stylesheet">
</head>
<body>

<h1>Game caro X-O</h1>
<table id="table_game">
</table>

</body>
</html>

<script type="text/javascript" src="js/constants.js"></script>
<script type="text/javascript" src="js/caro-main.js"></script>
```

* **caro.css**: Thêm style vào các phần tử HTML đó như đổi bố cục, màu sắc trang, đổi màu chữ cho trang home và giao diện trò chơi


```css
body {
    background-color: rgb(32, 32, 32);
    background-image: url("https://janschreiber.github.io/img2/black-chalk.jpg");
    color: rgb(230, 230, 230);
    text-align: center;
    font-family: ''Indie Flower'', ''Comic Sans'', cursive;
    font-size: 0.7em;
}
h1 {
    line-height: 1em;
    margin-bottom: 0;
    padding-bottom: 5px;
    font-size: 2.8em;
    font-weight: bold;
}
h2 {
    font-size: 1.3em;
    font-weight: bold;
    padding: 0;
    margin: 0;

}
h3 {
    font-size: 1.1em;
    text-decoration: underline;
    text-decoration-style: dashed;
    padding: 0;
    margin: 10px 0 2px 0;
}
table {
    margin: 2% auto;
    border-collapse: collapse;
}
#table_game {
    position: relative;
    font-size: 120px;
    margin: 1% auto;
    border-collapse: collapse;
}
.td_game {
    border: 4px solid rgb(230, 230, 230);
    width: 90px;
    height: 90px;
    padding: 0;
    vertical-align: middle;
    text-align: center;
}
.fixed {
    width: 90px;
    height: 90px;
    line-height: 90px;
    display: block;
    overflow: hidden;
    cursor: pointer;
}
.td_list {
    text-align: center;
    font-size: 1.3em;
    font-weight: bold;
}
.th_list {
    font-size: 1.3em;
    font-weight: bold;
    text-align: center;
    text-decoration: underline;
}
#restart {
    font-size: 3em;
    width: 1em;
    height: 0.9em;
    cursor: pointer;
    margin: 0 auto;
    overflow: hidden;
}
.x {
    color: darksalmon;
    position: relative;
    top: -8px;
    font-size: 1.2em;
    cursor: default;
}
.o {
    color: aquamarine;
    position: relative;
    top: -7px;
    font-size: 1.0em;
    cursor: default;
}

/* modal background */
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto; /* enable scroll if needed */
    background-color: black; /* fallback color */
    background-color: rgba(0, 0, 0, 0.6);
}

/* modal content */
.modal-content {
    background-color: rgb(240, 240, 240);
    color: rgb(32, 32, 32);
    font-size: 2em;
    font-weight: bold;
    /* 16 % from the top and centered */
    margin: 16% auto;
    padding: 20px;
    border: 2px solid black;
    border-radius: 10px;
    width: 380px;
    max-width: 80%;
}
.modal-content p {
    margin: 0;
    padding: 0;
}

/* close button for modal dialog */
.close {
    color: rgb(170, 170, 170);
    float: right;
    position: relative;
    top: -25px;
    right: -10px;
    font-size: 34px;
    font-weight: bold;
}
.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.win-color {
    background-color: rgb(240, 240, 240);
}
```

Vì phần giao diện html và css cũng không có gì quá phức tạp nên các bạn có thể tự đọc hiểu nó nhé! 😄😄😄 Sau khi html và css 1 chút chúng ta sẽ được giao diện như thế này.

![image.png](https://images.viblo.asia/c97ce61a-0211-4a57-98a7-0f047696f907.png)

![image.png](https://images.viblo.asia/39a546c5-ae75-44c6-90f3-a2528c250f54.png)

## 3.2. Xử lý các chức năng của trò chơi

**caro-home.js**: Xử lý các sự kiện, chức năng ở trang home. Ở trang này đơn giản chỉ có 1 sự kiện là click button **Let''s go**. Ở chức năng này đơn giản ta chỉ cần truyền các tham số: *chế độ chơi*, *số dòng*, *số cột* của trò chơi.

```javascript
function handleLetGo() {
    let typePlay = document.getElementById("list-type-play").value;
    let rows = document.getElementById("list-row").value;
    let columns = document.getElementById("list-column").value;

    if (typePlay === "" || rows === "" || columns === "") {
        alert("Vui lòng chọn kiểu chơi");
        return
    }
    window.location.href = "/game-development/games/caro/caro.html?type=" + typePlay + "&rows=" + rows + "&columns=" + columns;
}
```

**caro-main.js**: Xử lý các sự kiện của trò chơi. Sẽ có rất nhiều sự kiện, chức năng chúng ta cần xây dựng. Cùng mình đi từng dòng code xem nó làm gì nhé 😁😁😁

Đương nhiên rồi, trò chơi gì đầu tiên cũng phải khởi tạo các biến, các sự kiện, nhạc, hình ảnh,... **function init** sẽ lấy thông tin *chế độ chơi*, *số dòng*, *số cột* từ trang home truyền qua. Dựa vào các thông tin đó chúng ta tạo ra 1 ma trận *số dòng* x *số cột* để lưu thông tin trạng thái của trò chơi và vẽ bảng ma trận này bằng thẻ table

```javascript
let tableXO = document.getElementById("table_game");
tableXO.innerHTML = tableContent
```

Full source code function init

```javascript
function init() {
    player = X;
    matrixGame = [];
    typeGame = TWO_PLAYER;
    const urlParams = new URLSearchParams(window.location.search);
    let rows = urlParams.get("rows");
    let columns = urlParams.get("columns");

    if (rows === "" || columns === "" || (urlParams.get("type") !== TWO_PLAYER && urlParams.get("type") !== COMPUTER && urlParams.get("type") !== COMPUTER_COMPUTER)) {
        window.location.href = "/game-development/games/caro/home.html";
    }

    typeGame = urlParams.get("type")

    // Data table
    let tableXO = document.getElementById("table_game");
    let tableContent = "";

    for (let row = 0; row < rows; row++) {
        let arr = [];
        let rowHTML = "<tr>";
        for (let col = 0; col < columns; col++) {
            arr.push("");
            rowHTML += `<td class="td_game"><div id="` + row.toString() + "-" + col.toString() + `" onclick="handleClick(this.id)" class="fixed"></div></td>`
        }
        rowHTML += "</tr>";

        tableContent += rowHTML;
        matrixGame.push(arr);
    }

    tableXO.innerHTML = tableContent
}

window.addEventListener("load", (event) => {
    init();
});
```

Việc xử lý kiểm tra trạng thái hoà và chiến thắng sau mỗi nước đi của từng người cũng không quá khó:

* Nếu trạng thái hoà: Chúng ta sẽ loop tất cả các element ma trận trạng thái trò chơi *số dòng* x *số cột*. Chúng ta kiểm tra mà thấy phần tử nào có giá trị = "" tức là chưa có nước đi ở phần từ đó =&gt; trò chơi chưa kết thúc và ngược lại nếu các phần tử của ma trận mà đều != "" =&gt; trò chơi hoà.

* Nếu trạng thái chiến thắng: Chúng ta kiểm tra hàng ngang, dọc, chéo phải, chéo trái. Nếu có lớn hơn hoặc bằng 5 nước chơi liên tiếp giống nhau =&gt; Người chơi đó dành chiến thắng trò chơi.


Source code:

*Draw*

```javascript
function checkDraw() {
    for (let i = 0; i < matrixGame.length; i++) {
        for (let j = 0; j < matrixGame[0].length; j++) {
            if (matrixGame[i][j] === "") {
                return false
            }
        }
    }

    return true
}
```

*Win*

```javascript
function getHorizontal(x, y, player) {
    let count = 1;
    for (let i = 1; i < 5; i++) {
        if (y + i < matrixGame[0].length && matrixGame[x][y + i] === player) {
            count++;
        } else {
            break
        }
    }

    for (let i = 1; i < 5; i++) {
        if (y - i >= 0 && y - i < matrixGame[0].length && matrixGame[x][y - i] === player) {
            count++;
        } else {
            break
        }
    }

    return count;
}

function getVertical(x, y, player) {
    let count = 1;
    for (let i = 1; i < 5; i++) {
        if (x + i < matrixGame.length && matrixGame[x + i][y] === player) {
            count++;
        } else {
            break
        }
    }

    for (let i = 1; i < 5; i++) {
        if (x - i >= 0 && x - i < matrixGame.length && matrixGame[x - i][y] === player) {
            count++;
        } else {
            break
        }
    }

    return count;
}

function getRightDiagonal(x, y, player) {
    let count = 1;
    for (let i = 1; i < 5; i++) {
        if (x - i >= 0 && x - i < matrixGame.length && y + i < matrixGame[0].length && matrixGame[x - i][y + i] === player) {
            count++;
        } else {
            break
        }
    }

    for (let i = 1; i < 5; i++) {
        if (x + i < matrixGame.length && y - i >= 0 && y - i < matrixGame[0].length && matrixGame[x + i][y - i] === player) {
            count++;
        } else {
            break
        }
    }

    return count;
}

function getLeftDiagonal(x, y, player) {
    let count = 1;
    for (let i = 1; i < 5; i++) {
        if (x - i >= 0 && x - i < matrixGame.length && y - i >= 0 && y - i < matrixGame[0].length && matrixGame[x - i][y - i] === player) {
            count++;
        } else {
            break
        }
    }

    for (let i = 1; i < 5; i++) {
        if (x + i < matrixGame.length && y + i < matrixGame[0].length && matrixGame[x + i][y + i] === player) {
            count++;
        } else {
            break
        }
    }

    return count;
}

function checkWin(points) {
    return getHorizontal(Number(points[0]), Number(points[1]), player) >= 5
    || getVertical(Number(points[0]), Number(points[1]), player) >= 5
    || getRightDiagonal(Number(points[0]), Number(points[1]), player) >= 5
    || getLeftDiagonal(Number(points[0]), Number(points[1]), player) >= 5
}
```

## 3.3. Chế độ người-người

Ở 3.2 chúng ta xây dựng source code để xử lý các chức năng: khởi tạo game, kiểm tra trạng thái game: hoà, chiến thắng. Ở 3.3 này chúng ta sẽ xử lý sự kiện khi người chơi đi nước chơi của mình trên ma trận trò chơi.

* Nếu function **processClick** trả về win =&gt; thông báo 1 message người chơi X/O dành chiến thắng =&gt; khởi tạo lại trò chơi.

* Nếu function **processClick** trả về draw =&gt; thông báo 1 message 2 người chơi hoà =&gt; khởi tạo lại trò chơi.


```javascript
function handleClick(id) {
    switch (processClick(id)) {
        case WIN:
            setTimeout(function () {
                alert("Player: " + player + " is winner");

                // reset game
                init();
            }, 100);
            break;
        case DRAW:
            setTimeout(function () {
                alert("Draw");

                // reset game
                init();
            }, 100);
            break;
    }
}
```

**function processClick**: Xử lý sự khi người chơi đánh nước cờ của mình ở chế độ người-người. Chúng ta thực hiện các kiểm tra sau:

* Step 1: Nếu vị trí đó trong ma trận trò chơi có giá trị "X" hoặc "O" rồi =&gt; đã có nước đánh =&gt; return void luôn.

* Step 2: Nếu người chơi là X =&gt; Set giá trị vị trí đó trên ma trận trò chơi là "x" =&gt; vẽ hình X trên giao diện `html document.getElementById(id).innerHTML = XText;`

* Step 3: Nếu người chơi là O =&gt; Set giá trị vị trí đó trên ma trận trò chơi là "o" =&gt; vẽ hình X trên giao diện `html document.getElementById(id).innerHTML = OText;`

* Step 4: Kiểm tra trạng thái game hoà hay win. Nếu hoà return "draw", win return "win".

* Step 5: Chuyển lượt chơi `javascript player = player === X ? O : X;`


```javascript
function processClick(id) {
    let points = id.split("-");

    switch (typeGame) {
        case TWO_PLAYER:

            if (matrixGame[Number(points[0])][Number(points[1])] === X || matrixGame[Number(points[0])][Number(points[1])] === O) {
                return
            }

            if (player === X) {
                matrixGame[Number(points[0])][Number(points[1])] = X;
                document.getElementById(id).innerHTML = XText;
            }

            if (player === O) {
                matrixGame[Number(points[0])][Number(points[1])] = O;
                document.getElementById(id).innerHTML = OText;
            }

            if (checkWin(points)) {
                return WIN;
            }

            // check draw
            if (checkDraw()) {
                return DRAW;
            }

            player = player === X ? O : X;
            break;
        case COMPUTER:
            // source code to process play with computer
    }
}
```

## 3.4. Chế độ người-computer

Có rất nhiều thuật toán: minimax, leo đồi, hàm lượng giá,... để áp dụng vào trò chơi để lựa chọn ra nước đi tối ưu nhất. Ví dụ về thuật toán minimax

*Giải thuật Minimax Hai người chơi trong game được đại diện là MAX và MIN. MAX đại diện cho người chơi luôn muốn chiến thắng và cố gắng tối ưu hóa ưu thế của mình còn MIN đại diện cho người chơi cố gắng cho người MAX giành số điểm càng thấp càng tốt. Giải thuật Minimax thể hiện bằng cách định trị các Node trên cây trò chơi: Node thuộc lớp MAX thì gán cho nó giá trị lớn nhất của con Node đó. Node thuộc lớp MIN thì gán cho nó giá trị nhỏ nhất của con Node đó. Từ các giá trị này người chơi sẽ lựa chọn cho mình nước đi tiếp theo hợp lý nhất.*

![image.png](https://images.viblo.asia/477bdf96-eec4-4bd7-bdec-da4e128ab4e2.png)

Ở đây để đơn giản hoá chúng ta dựa vào kinh nghiệm, chiến lược của người chơi để dành chiến thắng chứ chưa cần phải áp dụng các thuật toán hay là trí tuệ nhân tạo

Các bạn có thể tham khảo thêm paper ở đây:

See this paper: [L. Victor Allis, H. J. van den Herik, M. P. H. Huntjens, 1993. Go-Moku and Threat-Space Search](https://web.archive.org/web/20140411074912/http://chalmersgomoku.googlecode.com/files/allis1994.pdf)

Vậy để áp dụng kinh nghiệm, chiến lược đó vào trò chơi như thế nào. Cùng mình xây dựng nhé 😘😘😘

Trước hết chúng ta tạo ra 2 hằng số: *MAP\_SCORE\_COMPUTER*, *MAP\_POINT\_HUMAN*

* *MAP\_SCORE\_COMPUTER*: Chúng ta sẽ kiểm tra nước đánh đó nếu có đủ 5 nước chơi của máy giống liền kề nhau =&gt; giành chiến thắng =&gt; điểm số cho nước đánh đó là dương vô cùng Infinity. Tương tự: 4 nước liền nhau =&gt; 2000 points, 3 nước liền nhau =&gt; 500 points, 2 nước liền nhau =&gt; 300 points, 1 nước liền nhau =&gt; 100 points. Số điểm này đại diện cho việc *tấn công*.

* *MAP\_POINT\_HUMAN*: Chúng ta sẽ kiểm tra nước đánh đó nếu có đủ 4 nước chơi của người giống liền kề nhau =&gt; cần ưu tiên đánh vào đây để *phòng thủ* =&gt; điểm số cho nước đánh đó là 999999. Tương tự: 3 nước liền nhau =&gt; 1000 points, 2 nước liền nhau =&gt; 400 points, 1 nước liền nhau =&gt; 10 points, 0 nước liền nhau =&gt; 0 points. Số điểm này đại diện cho việc *phòng thủ*.


```javascript
const MAP_SCORE_COMPUTER = new Map([
    [5, Infinity], [4, 2000], [3, 500], [2, 300], [1, 100]
])
const MAP_POINT_HUMAN = new Map([
    [4, 999999], [3, 1000], [2, 400], [1, 10], [0, 0]
])
```

**function getPointsComputer**: Lấy vị trí đánh của máy

* Step 1: *maxScore* =&gt; số điểm lớn nhất nếu máy đánh vào vị trí đó, *listScorePoint* =&gt; danh sách điểm theo từng theo từng vị trí có thể trên ma trận trò chơi, *pointsComputer* =&gt; danh sách các vị trí có điểm số cao nhất nếu máy đánh vào vị trí đó.

* Step 2: Loop ma trận trò chơi và kiểm tra nếu vị trí đó giá trị = "" ( chưa có nước đi ở đó ) =&gt; lấy số nước liền kề tối đa theo chiều ngang, dọc, chéo trái, chéo phải =&gt; số điểm nếu đánh vào vị trí đó = **MAP\_SCORE\_COMPUTER\[số nước liền kề lớn nhất\] + MAP\_POINT\_HUMAN\[số nước liền kề lớn nhất\]**

* Step 3: Loop danh sách điểm theo từng theo từng vị trí có thể trên ma trận trò chơi =&gt; push vị trí mà có điểm = maxScore ( số điểm tối đa ) vào danh sách các vị trí có điểm số cao nhất nếu máy đánh vào vị trí đó ( *pointsComputer* )

* Step 4: Vì mỗi trạng thái game đều sẽ có nhiều nước đi khác nhau mà có cùng số điểm tối đa =&gt; để khách quan và công bằng hơn thì chúng ta sẽ random trong pointsComputer.


```javascript
function getPointsComputer() {
    let maxScore = -Infinity
    let pointsComputer = []
    let listScorePoint = []
    for (let i = 0; i < matrixGame.length; i++) {
        for (let j = 0; j < matrixGame[0].length; j++) {
            if (matrixGame[i][j] === "") {
                let score = MAP_SCORE_COMPUTER.get(Math.max(getHorizontal(i, j, O),getVertical(i, j, O),getRightDiagonal(i, j, O),getLeftDiagonal(i, j, O))) +
                    MAP_POINT_HUMAN.get(Math.max(getHorizontal(i, j, X),getVertical(i, j, X),getRightDiagonal(i, j, X),getLeftDiagonal(i, j, X)) - 1)
                if (maxScore <= score) {
                    maxScore = score
                    listScorePoint.push({
                        "score": score,
                        "point": [i,j],
                    })
                }
            }
        }
    }

    // get list max score
    for (const element of listScorePoint) {
        if (element.score === maxScore) {
            pointsComputer.push(element.point)
        }
    }
    return pointsComputer[Math.floor(Math.random()*pointsComputer.length)]
}
```

## 3.5. Chế độ computer-computer

Chế độ này thật thú vị, fancy phải không mọi người 😄😄😄 Ở chế độ này chúng ta clone tương tự cách chơi human-computer. Thế chỗ lượt chơi của human bằng 1 computer khác. Chúng ta vẫn sử dụng hàm getPointsComputer để lấy vị trí đánh. Chúng ta delay 100ms cho có cảm giác máy suy nghĩ đánh nhé 😄😄😄

```javascript
async function ComputerAndComputer(sumPoints) {
    for (let i = 0; i < sumPoints; i++) {
        await delay(100);
        // computer A
        let pointsComputerA = getPointsComputer()
        matrixGame[pointsComputerA[0]][pointsComputerA[1]] = X;
        document.getElementById(pointsComputerA[0].toString() + "-" + pointsComputerA[1].toString()).innerHTML = XText;

        // check win
        if (checkWin(pointsComputerA)) {
            return WIN;
        }

        // check draw
        if (checkDraw()) {
            return DRAW;
        }

        player = player === X ? O : X;

        await delay(100);
        // computer B
        let pointsComputerB = getPointsComputer()
        matrixGame[pointsComputerB[0]][pointsComputerB[1]] = O;
        document.getElementById(pointsComputerB[0].toString() + "-" + pointsComputerB[1].toString()).innerHTML = OText;

        // check win
        if (checkWin(pointsComputerB)) {
            return WIN;
        }

        // check draw
        if (checkDraw()) {
            return DRAW;
        }

        player = player === X ? O : X;
    }
}
```

Ở function xử lý sự kiện load chúng ta kiểm tra nếu ở chế độ *comuter-computer* thì sẽ call function **ComputerAndComputer** để 2 máy tự chơi.

Note : *let sumPoints = matrixGame.length \* matrixGame\[0\].length* tổng số nước tối đa mà 2 máy có thể đi được. Nếu đi hết mà không ai thắng thì cờ sẽ hoà.

```javascript
window.addEventListener("load", (event) => {
    init();

    if(typeGame === COMPUTER_COMPUTER) {
        let sumPoints = matrixGame.length * matrixGame[0].length
        ComputerAndComputer(sumPoints).then(state => {
            switch (state) {
                case WIN:
                    setTimeout(function () {
                        alert("Player: " + player + " is winner");

                        // reset game
                        init();
                        location.reload();
                    }, 100);
                    break;
                case DRAW:
                    setTimeout(function () {
                        alert("Draw");

                        // reset game
                        init();
                        location.reload();
                    }, 100);
                    break;
            }
        })
    }
});
```

# 4\. Kết luận

Đây là 1 số hình ảnh và video kết quả sau khi build code xong nhé mọi người ^^

{@embed: https://www.youtube.com/watch?v=jm5ieVDNo8g}

* Website game: https://nguyenvantuan2391996.github.io/game-development/games/caro/home.html

* Source code: https://github.com/nguyenvantuan2391996/game-development/tree/master/games/caro

Bài viết được trích từ blog của mình : https://tuannguyenhust.hashnode.dev/', '0gdJzQ7g4z5', '2', 'https://images.viblo.asia/f152a7ae-37ff-4b83-954c-aadbcd8602b2.png', 'Tháng ba bất chợt một ngày trắng tinh hoa sưa về đây... Hà Nội, Chủ Nhật 26/02/2023...

Ta vội bước trên phố phường Hà Nội
Bỗng gặp hàng sưa trắng một màu hoa
Trắng cả góc trời níu bước chân qua
Lưu luyến qúa chùm hoa sưa lặng lẽ

Hương hoa không nồng nàn như hoa sữa
Không sắc màu tím biếc cánh bằng lăng
Không vàng thẫm một màu hoa điệp lan
Mà nhẹ nhàng n...', '2023-02-27T03:10:32.000000Z', '2023-02-27T04:19:07.000000Z'),
	('5 Reasons Why Svelte Should Be Your Next JavaScript Framework', 'As web development continues to grow in popularity, developers have more options for choosing a JavaScript framework to build their applications. Svelte is one such framework that has gained a lot of attention in recent years. In this post, we will explore the top 5 reasons why Svelte should be your next JavaScript framework.

If you''re curious about how SolidJS compares to Svelte, you might be interested in reading our write-up on [SolidJS vs Svelte](https://www.frontendmag.com/insights/solidjs-vs-svelte/). In this article, we will explore the differences between these two frameworks and help you decide which one is best suited for your next web application project.

## Simple Syntax
One of the most significant advantages of Svelte is its simple syntax. Unlike other frameworks that use complex syntax, Svelte uses a mix of HTML, CSS, and JavaScript to create components. This approach makes it easy for developers to understand and use Svelte.

Svelte''s syntax is also very clean and concise, making it easy to read and maintain. With Svelte, developers can focus on building applications, rather than learning a new framework. This simplicity also makes it easier for developers to onboard and train new team members on Svelte.

## Built-In Reactivity
Svelte''s built-in reactivity is another feature that sets it apart from other frameworks. Reactivity refers to the ability of a framework to automatically update the DOM when data changes. With Svelte, developers don''t have to manually update the DOM every time data changes. Instead, Svelte automatically updates the DOM when data changes, making the development process faster and more efficient.

This feature is especially useful when dealing with large datasets, as it eliminates the need for manual updates, which can be time-consuming and error-prone. With Svelte''s reactivity, developers can write less code and focus more on building their application.

## Fast Performance
Svelte''s fast performance is another feature that sets it apart from other frameworks. Unlike React or Vue, Svelte doesn''t use a virtual DOM to update the DOM when data changes. Instead, Svelte compiles the template into highly optimized JavaScript code during the build process. This results in a faster and more efficient rendering process, even on slower devices.

## Smaller Bundle Sizes
Svelte''s compilation process moves a lot of work to build-time, resulting in much smaller bundle sizes than other frameworks. This means your application will load faster, reducing the time your users spend waiting for it to render. Smaller bundle sizes also mean less data usage, which can be a significant benefit for users with limited data plans.

The smaller bundle sizes also make Svelte an excellent choice for building progressive web applications (PWAs). PWAs are web applications that have native app-like features, such as offline functionality and push notifications. With Svelte''s small bundle sizes, PWAs built with Svelte are faster and more efficient, providing a better user experience.

## Excellent Documentation
Svelte has excellent documentation that covers everything from the basics to advanced topics. The documentation is easy to understand, and it provides clear examples that make it easy to implement Svelte in your project. With excellent documentation, developers can easily learn how to use Svelte and take advantage of its many features.

Svelte''s documentation is also updated frequently, reflecting changes to the framework and its best practices. This ensures that developers always have access to the most up-to-date information and resources.

## Conclusion

Svelte is a powerful and efficient framework that offers many benefits for developers who want to build fast and scalable web applications. With its simple syntax, built-in reactivity, fast performance, smaller bundle sizes, and excellent documentation, Svelte is an excellent choice for your next JavaScript framework.

Svelte''s ease of use and strong community support make it an excellent choice for building modern web applications. Whether you''re an experienced developer or just starting, its simplicity and performance make it a framework worth considering.', 'obA4663w4Kv', '3', '', 'As web development continues to grow in popularity, developers have more options for choosing a JavaScript framework to build their applications. Svelte is one such framework that has gained a lot of attention in recent years. In this post, we will explore the top 5 reasons why Svelte should be your next JavaScript framework.

If you''re curious about how SolidJS compares to Svelte, you might be...', '2023-02-27T03:05:25.000000Z', '2023-02-27T04:23:03.000000Z'),
	('Cấu Trúc Dữ Liệu Và Giải Thuật - Graph Algorithms - Breadth First Search (BFS)', 'Các thuật toán dựa trên cây được sử dụng để truy cập từng nút hoặc đỉnh trong đồ thị. Chúng ta có thể truy cập từng nút trong đồ thị bằng cách lặp qua tất cả các nút của đồ thị bằng cách sử dụng thuật toán trên từng nút chưa được duyệt. Hai thuật toán thường được sử dụng để duyệt đồ thị là tìm kiếm theo chiều rộng (BFS) và tìm kiếm theo chiều sâu (DFS), nhưng ở đây chúng ta hiểu là tìm kiếm theo chiều rộng. Tìm kiếm theo chiều rộng (BFS) được sử dụng để giải quyết nhiều vấn đề, bao gồm tìm đường đi ngắn nhất trong biểu đồ hoặc giải các trò chơi giải đố như Khối Rubik.

## 1. BFS là gì?
Tìm kiếm theo chiều rộng (BFS) là một thuật toán để duyệt đồ thị hoặc cây. BFS áp dụng cho cây và đồ thị gần như giống nhau. Sự khác biệt duy nhất là đồ thị có thể chứa các chu trình, vì vậy chúng ta có thể duyệt lại cùng một nút. Để tránh xử lý lại cùng một nút, chúng ta sử dụng mảng boolean đã truy cập, mảng này sẽ đánh dấu các đỉnh đã truy cập. BFS sử dụng cấu trúc dữ liệu hàng đợi (queue) để tìm đường đi ngắn nhất trong biểu đồ.

## 2. Thuật toán BFS
 triển khai BFS tiêu chuẩn sẽ đặt mỗi đỉnh của đồ thị vào một trong hai loại: visited, not visited. Mục đích của thuật toán là đánh dấu mỗi đỉnh là đã thăm để tránh các chu trình.

 Cách thuật toán hoạt động như sau:
1.  Lấy một đỉnh bất kỳ trong đồ thị thêm vào cuối hàng đợi.
2.  Lấy phân tử đầu tiên của hàng đợi và thêm nó vào danh sách đã duyệt.
3.  Tạo một danh sách các đỉnh liền kề của đỉnh đang xét. Thêm những đỉnh không có trong danh sách đã duyệt vào cuối hàng đợi.
4.  Tiếp tục lặp lại bước 2 và 3 cho đến khi hàng đợi trống.

Lưu ý: Đồ thị có thể chứa hai thành phần không liên kết khác nhau, vì vậy để đảm bảo rằng mọi đỉnh đều đã được thăm, chúng ta cũng có thể chạy thuật toán BFS trên mọi đỉnh.

## 3. Ví dụ về BFS

Hãy xem cách hoạt động của thuật toán Tìm kiếm theo chiều rộng với một ví dụ. Ta dùng đồ thị vô hướng có 5 đỉnh.
![](https://images.viblo.asia/2ca3ea92-a7c4-4ddf-89ac-f3dce00e8e7c.png)
Chúng ta bắt đầu từ đỉnh 0, thuật toán BFS bắt đầu bằng cách đặt nó vào danh sách đã duyệt và đặt tất cả các đỉnh liền kề của nó vào hàng đợi.
![](https://images.viblo.asia/bda4b468-3e01-483c-8ef3-031b0f6e4a81.png)
Tiếp theo, chúng tôi truy cập phần tử đầu của hàng đợi, tức là 1 và đi đến các nút liền kề của nó. Vì 0 đã được truy cập, thay vào đó, chúng tôi truy cập 2.
![](https://images.viblo.asia/9b5eb0cd-066d-41e0-ba3c-30ca0ced8648.png)
Đỉnh 2 có một đỉnh liền kề chưa được thăm là 4, vì vậy chúng tôi thêm đỉnh đó vào cuối hàng đợi và thăm 3, ở đầu hàng đợi.
![](https://images.viblo.asia/dffe8a99-abc0-4379-a2fe-17f20471aaf4.png)
![](https://images.viblo.asia/7903ee8d-7e62-46de-aa13-5a4256c3eace.png)
Chỉ còn lại 4 trong hàng đợi vì nút liền kề duy nhất của 3 tức là 0 đã được truy cập. Chúng ta đến thăm nó.
![](https://images.viblo.asia/5096157a-488c-4219-bd1e-349cb39c2d14.PNG)
Vì hàng đợi trống, chúng ta đã hoàn thành việc tìm kiếm theo chiều rộng trên đồ thị.

## 4. Cài đặt BFS
```
// BFS algorithm in Java

import java.util.*;

public class Graph {
  private int V;
  private LinkedList<Integer> adj[];

  // Create a graph
  Graph(int v) {
    V = v;
    adj = new LinkedList[v];
    for (int i = 0; i < v; ++i)
      adj[i] = new LinkedList();
  }

  // Add edges to the graph
  void addEdge(int v, int w) {
    adj[v].add(w);
  }

  // BFS algorithm
  void BFS(int s) {

    boolean visited[] = new boolean[V];

    LinkedList<Integer> queue = new LinkedList();

    visited[s] = true;
    queue.add(s);

    while (queue.size() != 0) {
      s = queue.poll();
      System.out.print(s + " ");

      Iterator<Integer> i = adj[s].listIterator();
      while (i.hasNext()) {
        int n = i.next();
        if (!visited[n]) {
          visited[n] = true;
          queue.add(n);
        }
      }
    }
  }

  public static void main(String args[]) {
    Graph g = new Graph(4);

    g.addEdge(0, 1);
    g.addEdge(0, 2);
    g.addEdge(1, 2);
    g.addEdge(2, 0);
    g.addEdge(2, 3);
    g.addEdge(3, 3);

    System.out.println("Following is Breadth First Traversal " + "(starting from vertex 2)");

    g.BFS(2);
  }
}
```
## 5. Độ phức tạp của BFS
Độ phức tạp thời gian của thuật toán BFS được biểu diễn dưới dạng O(V + E), trong đó V là số nút và E là số cạnh.

Độ phức tạp không gian của thuật toán là O(V).

## 6. Ứng dụng của BFS
Tìm kiếm theo chiều rộng là một phương pháp duyệt đồ thị đơn giản có phạm vi ứng dụng cao. Một số ứng dụng của BFS:
* **Trình thu thập dữ liệu trong Công cụ Tìm kiếm**:  Tìm kiếm theo chiều rộng là thuật toán chính được sử dụng để lập chỉ mục các trang web. Thuật toán BFS bắt đầu từ trang nguồn và đi theo tất cả các liên kết được liên kết với nó.
* **Mạng peer-to-peer**: Tìm kiếm theo chiều rộng có thể được sử dụng để tìm tất cả các nút lân cận trong mạng peer-to-peer. Ví dụ: BitTorrent sử dụng BFS để giao tiếp peer-to-peer.
* **Hệ thống định vị GPS**: Thuật toán tốt nhất để xác định đường đi ngắn nhất từ vị trí này đến vị trí khác là tìm kiếm theo chiều rộng.
* **Thuật toán Ford-Fulkerson**: Để tìm luồng cực đại trong mạng, hãy sử dụng thuật toán Ford-Fulkerson.
* **Đường đi ngắn nhất & cây khung tối thiểu cho đồ thị không trọng số**: Tìm kiếm theo chiều rộng được sử dụng để tìm đường đi ngắn nhất & cây khung tối thiểu cho đồ thị không trọng số.

## 7. Kết luận
* **Tìm kiếm theo chiều rộng (BFS)** được sử dụng để giải quyết nhiều vấn đề, bao gồm tìm đường đi ngắn nhất trong biểu đồ hoặc giải các trò chơi giải đố như Khối Rubik.
* BFS sử dụng cấu trúc dữ liệu **hàng đợi** để tìm đường đi ngắn nhất trong biểu đồ.
* Để tránh xử lý lại cùng một nút, chúng ta sử dụng **mảng boolean đã duyệt**, mảng này sẽ đánh dấu các đỉnh đã truy cập.
* Đồ thị có thể chứa **hai thành phần không liên kết khác nhau**, vì vậy để đảm bảo rằng mọi đỉnh đều đã được duyệt, chúng ta cũng có thể **chạy thuật toán BFS trên mọi đỉnh**.
* Độ phức tạp thời gian của thuật toán tìm kiếm theo chiều rộng là **O(V+E)** và độ phức tạp không gian là **O(V).**

Nguồn:
* https://www.programiz.com/dsa/graph-bfs
* https://www.scaler.com/topics/breadth-first-search-python/', 'gwd43kMM4X9', '4', '', 'Các thuật toán dựa trên cây được sử dụng để truy cập từng nút hoặc đỉnh trong đồ thị. Chúng ta có thể truy cập từng nút trong đồ thị bằng cách lặp qua tất cả các nút của đồ thị bằng cách sử dụng thuật toán trên từng nút chưa được duyệt. Hai thuật toán thường được sử dụng để duyệt đồ thị là tìm kiếm theo chiều rộng (BFS) và tìm kiếm theo chiều sâu (DFS), nhưng ở đây chúng ta hiểu là tìm kiếm the...', '2023-02-27T03:01:35.000000Z', '2023-02-27T04:22:05.000000Z'),
	('Tìm hiểu về Delegate trong C#', 'Hi anh em, Đầu tuần chúc anh em một ngày làm việc hiệu quả và đầy năng lượng. Hôm nay mình sẽ giới thiệu về delegate trong C#, một tính năng khá phổ biến.
Không để anh em chờ lâu, cùng bắt đầu vào bài viết nào. Bài viết này mình sẽ nói về định nghĩa, các cách sử dụng và ví dụ đơn giản về delegate trong c#.

### 1. Delegate là gì?

- Delegate là một kiểu dữ liệu đặc biệt trong C# được sử dụng để khai báo tham chiếu tới các hàm hoặc phương thức (Có thể hiểu là con trỏ trỏ tới hàm). Khi gán một hàm hoặc phương thức cho delegate thì delegate sẽ trỏ tham chiếu tới hàm, phương thức đó. Sau đó thay vì ta gọi hàm trực tiếp, ta có thể thông qua delegate để gọi mà không cần biết rõ tên hàm đó. Delegate giúp cho việc gọi hàm trở nên linh hoạt hơn.
```csharp
using System;

delegate int CalculatorDelegate(int num1, int num2);

class Program {
    static void Main(string[] args) {
        // Khởi tạo delegate
        CalculatorDelegate calculatorDelegate = new CalculatorDelegate(MaxNumber);

        // Gọi phương thức thông qua delegate
        int result = calculatorDelegate(10, 20);

        // In ra giá trị lớn nhất của hai số
        Console.WriteLine("Max number: " + result);
    }

    static int MaxNumber(int num1, int num2) {
        return (num1 > num2) ? num1 : num2;
    }
}

```

- Ở ví dụ trên thay vì gọi trực tiếp hàm MaxNumber để tìm số lớn nhất trong 2 số, ta gọi tới biến delegate calculatorDelegate.

### 2. Sử dụng delegate gọi tới các hàm khác nhau
```csharp
using System;

// Khai báo delegate
delegate int Calculator(int a, int b);

class Program {
    static int Add(int a, int b) {
        return a + b;
    }

    static int Subtract(int a, int b) {
        return a - b;
    }

    static void Main(string[] args) {
        // Tạo instance của delegate, truyền phương thức Add vào delegate
        Calculator calculator = new Calculator(Add);

        // Sử dụng delegate để tính tổng của 2 số
        int result = calculator(10, 5);
        Console.WriteLine("10 + 5 = " + result);

        // Truyền phương thức Subtract vào delegate
        calculator = new Calculator(Subtract);

        // Sử dụng delegate để tính hiệu của 2 số
        result = calculator(10, 5);
        Console.WriteLine("10 - 5 = " + result);

        Console.ReadKey();
    }
}

```

- Ở trên ví dụ trên ta sử delegate calculator để gọi tới phương thức Add nếu ta gán calculator = new Calculator(Add); gọi tới phương thức Subtract nếu ta gán  calculator = new Calculator(Subtract);.
- Qua việc sử dụng cùng 1 delegate để gọi tới các hàm khác nhau ta thấy việc gọi hàm rất linh hoạt và dễ dàng.

### 3. Sử dụng delegate để tạo ra một callback
```csharp
using System;

delegate void Callback(string message);

class Program
{
    static void Main(string[] args)
    {
        CallMethodWithCallback("Hello, world!", DisplayMessage);
    }

    static void CallMethodWithCallback(string message, Callback callback)
    {
        Console.WriteLine("Method called with message: " + message);
        callback(message);
    }

    static void DisplayMessage(string message)
    {
        Console.WriteLine("Callback called with message: " + message);
    }
}
```

- Ở ví dụ trên ta thấy ta sẽ khai báo một callback với delegate delegate void Callback(string message);. Khi ta gọi function CallMethodWithCallback ta có thể truyền function vào như một tham số: CallMethodWithCallback("Hello, world!", DisplayMessage);
- Ví dụ trên sẽ ra kết quả:
```csharp
Method called with message: Hello, world!
Callback called with message: Hello, world!
```

### 4. Sử dụng delegate trong Lambda Expression
```csharp
delegate int Operation(int a, int b); // Khai báo delegate

class Program
{
    static void Main(string[] args)
    {
        // Sử dụng delegate trong lambda expression
        Operation sum = (a, b) => a + b;
        Operation product = (a, b) => a * b;

        int x = 5, y = 3;
        Console.WriteLine($"Tổng của {x} và {y} là {sum(x, y)}"); // Kết quả: Tổng của 5 và 3 là 8
        Console.WriteLine($"Tích của {x} và {y} là {product(x, y)}"); // Kết quả: Tích của 5 và 3 là 15
    }
}

```

```csharp
class Program
{
    static int Sum(int x, int y)
    {
        return x + y;
    }

    static void Main(string[] args)
    {
        Func<int,int, int> add = Sum;

        int result = add(10, 10);

        Console.WriteLine(result);
    }
}
```

- Func<int, int, int> là một delegate có kiểu int với 2 tham số truyền vào kiểu int.

### 5. Tổng kết
- Còn rất nhiều cách sử dụng delegate trong c#, ở đây mình chỉ giới thiệu khái niệm và ví dụ đơn giản để anh em có thể hiểu delegate là gì và cách sử dụng đơn giản.
- Cảm ơn mọi người đã xem bài viết. Chúc mọi người một cuối tuần vui vẻ.
- Nếu có thắc mắc về các phần trong bài này mọi người có thể inbox qua facebook:https://www.facebook.com/FriendsCode-108096425243996 Mình sẽ giải đáp thắc mắc trong tầm hiểu biết. Cảm ơn mọi người!
- Hoặc liên hệ mình qua facebook cá nhân: https://www.facebook.com/Flamesofwars/



### 6. Tham khảo:
- https://www.tutorialsteacher.com/csharp/csharp-func-delegate
- https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/delegates/
- https://www.geeksforgeeks.org/c-sharp-delegates/
- Chat GPT, Microsoft bing chat. ^^', 'aNj4vQzxV6r', '5', '', 'Hi anh em, Đầu tuần chúc anh em một ngày làm việc hiệu quả và đầy năng lượng. Hôm nay mình sẽ giới thiệu về delegate trong C#, một tính năng khá phổ biến.
Không để anh em chờ lâu, cùng bắt đầu vào bài viết nào. Bài viết này mình sẽ nói về định nghĩa, các cách sử dụng và ví dụ đơn giản về delegate trong c#.

1. Delegate là gì?

- Delegate là một kiểu dữ liệu đặc biệt trong C# được sử dụng để kha...', '2023-02-27T02:46:46.000000Z', '2023-02-27T04:13:07.000000Z'),
	('90 ngày DevOps - Ngày 11 - Biến, hằng số & kiểu dữ liệu', 'Trước khi đi vào chủ đề ngày hôm nay, tôi muốn gửi lời cảm ơn tới [Techworld with Nana](https://www.youtube.com/watch?v=yyUHQIec83I) với video đi hết những kiến thức cơ bản về Go.

Vào [ngày 8](https://vntechies.dev/courses/90-ngay-devops/ngay-8-thiet-lap-moi-truong-devops-cho-go-hello-world), chúng ta thiết lập môi trường, vào [ngày 9](https://vntechies.dev/courses/90-ngay-devops/ngay-9-giai-thich-ma-hello-world), chúng ta đã xem qua mã Hello #90DaysOfDevOps và vào [ngày 10](https://vntechies.dev/courses/90-ngay-devops/ngay-10-khong-gian-lam-viec-cua-go)), chúng ta đã tìm hiểu về không gian làm việc Go và đi sâu hơn một chút vào biên dịch và chạy mã.

Hôm nay chúng ta sẽ tìm hiểu về Biến, Hằng số và Kiểu dữ liệu trong khi viết một chương trình mới.

## Biến và Hằng số trong Go

Hãy bắt đầu bằng cách lên kế hoạch cho ứng dụng của chúng ta. Tôi nghĩ một chương trình cho bạn biết số ngày còn lại trong thử thách #90DaysOfDevOps sẽ là một ý tưởng hay.

Đầu tiên là khi chúng ta xây dựng ứng dụng, nó chào mừng người tham gia và nhận phản hồi từ người dùng về số ngày đã hoàn thành. Chúng ta có thể sử dụng thuật ngữ #90DaysOfDevOps nhiều lần trong suốt chương trình và đây là trường hợp hoàn hảo để #90DaysOfDevOps trở thành một biến trong chương trình.

- Các biến được sử dụng để lưu trữ các giá trị.
- Giống như một hộp nhỏ chứa thông tin hoặc giá trị của chúng ta.
- Biến này có thể được sử dụng trong suốt chương trình và cũng có ưu điểm là nếu bạn muốn thay đổi tên thử thách hoặc biến này, bạn chỉ phải thay đổi nó ở một nơi. Nói cách khác, bằng cách thay đổi một giá trị của biến này, nó có thể được chuyển sang các tên các thử thách khác trong cộng đồng.

Để khai báo điều này trong Go, hãy sử dụng **từ khóa** cho các biến. Khai báo này sẽ được sử dụng trong khối mã `func main` mà chúng ta sẽ nhắc tới sau. Giải thích chi tết về **Từ khoá** tại [đây](https://go.dev/ref/spec#Keywords).

Hãy nhớ rằng tên biến có tính mô tả. Nếu bạn khai báo một biến, bạn phải sử dụng nó hoặc bạn sẽ gặp lỗi, điều này để tránh có thể có mã chết (mã không bao giờ được sử dụng). Điều này cũng tương tự cho các gói (packages) không được sử dụng.

```go:main.go
var challenge = "#90DaysOfDevOps"
```

Với khai báo ở trên, bạn có thể thấy chúng ta đã sử dụng một biến khi in ra chuỗi ký tự ở đoạn mã dưới đây.

```go:main.go
package main

import "fmt"

func main() {
    var challenge = "#90DaysOfDevOps"
    fmt.Println("Welcome to", challenge, "")
}
```

Bạn có thể tìm thấy đoạn mã trên tại [day11_example1.go](https://github.com/vntechies/90DaysOfDevOps/blob/main/2022/Days/Go/day11_example1.go)

Sau đó, chúng ta xây dựng mã của với ví dụ trên và nhận được kết quả hiển thị như dưới đây.

![Day11_Go1.png](https://images.viblo.asia/446463a3-f157-4764-b3cc-b1311158a039.png)

Chúng ta cũng biết rằng thử thách này kéo dài ít nhất 90 ngày, nhưng với thử thách tiếp theo, nó có thể là 100 ngày, chính vì thế, chúng ta cũng cần một biến ở đây. Tuy nhiên, với chương trình này, chúng ta muốn khai báo nó như một hằng số. Các hằng số cũng giống như các biến, ngoại trừ việc giá trị của chúng không thể thay đổi trong đoạn mã (chúng ta vẫn có thể tạo một ứng dụng mới với mã được giữ nguyên và thay đổi hằng số này nhưng giá trị 90 sẽ không thay đổi khi chúng ta chạy ứng dụng của mình)

Thêm `const` vào mã và thêm một dòng mã khác để in ra kết quả.

```go:main.go
package main

import "fmt"

func main() {
    var challenge = "#90DaysOfDevOps"
    const daystotal = 90

    fmt.Println("Welcome to", challenge, "")
    fmt.Println("This is a", daystotal, "challenge")
}
```

Bạn có thể tìm thấy đoạn mã trên tại [day11_example2.go](https://github.com/vntechies/90DaysOfDevOps/blob/main/2022/Days/Go/day11_example2.go)

Nếu chúng ta thực hiện lại câu lệnh `go build` và chạy lại, bạn sẽ thấy kết quả bên dưới.

![Day11_Go2.png](https://images.viblo.asia/0cc08593-0545-4e75-90f7-77e4351af333.png)

Đây sẽ không phải là phần cuối của chương trình, chúng ta sẽ quay lại vào [ngày 12](https://vntechies.dev/courses/90-ngay-devops/ngay-12-nhan-thong-tin-dau-vao-su-dung-con-tro-va-chuong-trinh-hoan-thien) để thêm các chức năng khác. Bây giờ ta sẽ thêm một biến khác cho số ngày đã hoàn thành trong thử thách.

Bên dưới, tôi đã thêm biến `dayscomplete` với số ngày đã hoàn thành.

```go:main.go
package main

import "fmt"

func main() {
    var challenge = "#90DaysOfDevOps"
    const daystotal = 90
    var dayscomplete = 11

    fmt.Println("Welcome to", challenge, "")
    fmt.Println("This is a", daystotal, "challenge and you have completed", dayscomplete, "days")
    fmt.Println("Great work")
}
```

Bạn có thể tìm thấy đoạn mã trên tại [day11_example3.go](https://github.com/vntechies/90DaysOfDevOps/blob/main/2022/Days/Go/day11_example3.go)

Hãy chạy lại lệnh `go build` hoặc có thể sử dụng `go run`

![Day11_Go3.png](https://images.viblo.asia/404e90f6-ab5d-4593-b021-77ea47ded623.png)

```go:main.go
package main

import "fmt"

func main() {
	var challenge = "#90DaysOfDevOps"
	const daystotal = 90
	var dayscomplete = 11

	fmt.Printf("Welcome to %v\n", challenge)
	fmt.Printf("This is a %v challenge and you have completed %v days\n", daystotal, dayscomplete)
	fmt.Println("Great work")
}
```

Đây là một số ví dụ khác để làm cho mã dễ đọc và chỉnh sửa hơn. Hiện giờ, chúng ta vẫn đang sử dụng hàm `Println` nhưng nó có thể được đơn giản hóa bằng cách sử dụng` Printf` với `%v`, có nghĩa là các biến theo sẽ được xác định ở cuối dòng mã. Chúng ta cũng có thể sử dụng `\n` để xuống dòng.

Tôi đang sử dụng `%v` vì nó là giá trị mặc định, các tùy chọn khác có ở đây trong [tài liệu của gói fmt](https://pkg.go.dev/fmt), bạn có thể đoạn mã ví dụ tại [day11_example4.go](https://github.com/vntechies/90DaysOfDevOps/blob/main/2022/Days/Go/day11_example4.go)

Các biến cũng có thể được khai bảo một cách đơn giản hơn trong mã của bạn. Thay vì xác định rằng đó là `var` và` type`, bạn có thể viết mã này như sau để có cùng kết quả nhưng đoạn mã sẽ gọn, đẹp và đơn giản hơn. Cách này chỉ áp dụng được với các biến, không sử dụng với hằng số.

```go:main.go
func main() {
    challenge := "#90DaysOfDevOps"
    const daystotal = 90
```

## Kiểu dữ liệu

Trong các ví dụ trên, chúng ta chưa xác định kiểu dữ liệu của biến, điều này là do chúng ta đã gán cho nó một giá trị và Go đủ thông minh để biết kiểu dữ liệu đó là gì hoặc ít nhất có thể suy ra nó là gì dựa trên giá trị bạn đã gán. Tuy nhiên, nếu chúng ta muốn người dùng nhập dữ liệu, chúng ta phải sử dụng một kiểu dữ liệu cụ thể.

Cho đến giờ, chúng ta đã sử dụng Chuỗi và Số nguyên trong mã của mình. Số nguyên cho số ngày và chuỗi là tên của thử thách.

Điều quan trọng cần lưu ý là mỗi kiểu dữ liệu có thể làm những việc khác nhau và hoạt động khác nhau. Ví dụ: số nguyên có thể nhân lên trong khi chuỗi thì không.

Có bốn loại:

- **Loại cơ bản - Basic type**: Số, chuỗi và boolean (Numbers, strings, booleans)
- **Loại tổng hợp - Aggregate type**: Mảng và cấu trúc (Array, structs)
- **Loại tham chiếu -Reference type**: Con trỏ, lát cắt, bản đồ, chức năng và kênh (Pointers, slices, maps, functions, and channels)
- **Loại giao diện - Interface type**

Kiểu dữ liệu là một khái niệm quan trọng trong lập trình. Kiểu dữ liệu chỉ định kích thước và kiểu của các giá trị biến.

Go được nhập tĩnh, có nghĩa là khi một kiểu dữ liệu của biến được xác định, nó chỉ có thể lưu trữ dữ liệu của kiểu đó.

Go có ba kiểu dữ liệu cơ bản:

- **bool**: đại diện cho một giá trị boolean hoặc đúng hoặc sai
- **Numeric**: đại diện cho kiểu số nguyên, giá trị dấu phẩy động và kiểu phức tạp
- **string**: đại diện cho một giá trị chuỗi

Tôi thấy đây là nguồn tài liệu rất chi tết về các kiểu dữ liệu [Golang by example](https://golangbyexample.com/all-data-types-in-golang-with-examples/)

Tôi cũng sẽ đề xuất video [Techworld with Nana](https://www.youtube.com/watch?v=yyUHQIec83I&t=2023s). Tại thời điểm này, video đề cập chi tiết rất nhiều về các loại dữ liệu trong Go.

Chúng ta có thể làm như sau khi cần khai báo kiểu cho biến của mình:

```go
var TwitterHandle string
var DaysCompleted uint
```

Bởi vì Go ngụ ý các biến trong đó một giá trị được đưa ra, chúng ta có thể in ra các giá trị đó như sau:

```go
fmt.Printf("challenge is %T, daystotal is %T, dayscomplete is %T\n", conference, daystotal, dayscomplete)
```

Có nhiều kiểu số nguyên và kiểu float khác nhau, các liên kết ở trên sẽ trình bày chi tiết về những kiểu này.

- **int** = số nguyên
- **unint** = số nguyên dương
- **các loại dấu phẩy động** = các số có chứa thành phần thập phân

## Tài liệu tham khảo

- [StackOverflow 2021 Developer Survey](https://insights.stackoverflow.com/survey/2021)
- [Why we are choosing Golang to learn](https://www.youtube.com/watch?v=7pLqIIAqZD4&t=9s)
- [Jake Wright - Learn Go in 12 minutes](https://www.youtube.com/watch?v=C8LgvuEBraI&t=312s)
- [Techworld with Nana - Golang full course - 3 hours 24 mins](https://www.youtube.com/watch?v=yyUHQIec83I)
- [**NOT FREE** Nigel Poulton Pluralsight - Go Fundamentals - 3 hours 26 mins](https://www.pluralsight.com/courses/go-fundamentals)
- [FreeCodeCamp - Learn Go Programming - Golang Tutorial for Beginners](https://www.youtube.com/watch?v=YS4e4q9oBaU&t=1025s)
- [Hitesh Choudhary - Complete playlist](https://www.youtube.com/playlist?list=PLRAV69dS1uWSR89FRQGZ6q9BR2b44Tr9N)

Ở phần sau, chúng ta sẽ thêm một số chức năng nhập liệu của người dùng vào chương trình để người dùng có thể trả lời câu hỏi đã hoàn thành bao nhiêu ngày.

Hẹn gặp lại tại [ngày 12](https://vntechies.dev/courses/90-ngay-devops/ngay-12-nhan-thong-tin-dau-vao-su-dung-con-tro-va-chuong-trinh-hoan-thien).

## VNTechies Dev Blog 🇻🇳 - Kho tài nguyên về Cloud ☁️ / DevOps 🚀
![](https://images.viblo.asia/1712f084-ee0f-47e8-b2a3-9af6cddf56f6.png)

- Website: https://vntechies.dev/
- Github repository: https://github.com/vntechies/blog
- Facebook: https://facebook.com/vntechies

Anh chị em hãy follow/ủng hộ VNTechies  để cập nhật những thông tin mới nhất về Cloud và DevOps nhé!

## License

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

Các bài viết là bản tiếng Việt của tài liệu [90DaysOfDevOps](https://github.com/MichaelCade/90DaysOfDevOps/tree/main/Days) của [Micheal Cade](https://twitter.com/MichaelCade1) và có qua sửa đổi, bổ sung. Tất cả đều có license [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

> License này chỉ cho phép người khác có thể thực hiện đăng tải lại, chỉnh sửa và xây dựng dựa trên nội dung gốc cho mục đích phi thương mại kèm theo điều kiện ghi công cho tác giả chẳng hạn như: nêu tên tác giả, dẫn link tới tác phẩm gốc hoặc theo yêu cầu riêng của tác giả;
> Ngoài ra, các bản phân phối, sửa đổi bắt buộc phải gắn cùng license với tác phẩm gốc.

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg', '5OXLAoYv4Gr', '6', 'https://images.viblo.asia/b9cb4eee-06bf-43af-a10f-0008ccbe4955.png', 'Trước khi đi vào chủ đề ngày hôm nay, tôi muốn gửi lời cảm ơn tới Techworld with Nana với video đi hết những kiến thức cơ bản về Go.

Vào ngày 8, chúng ta thiết lập môi trường, vào ngày 9, chúng ta đã xem qua mã Hello #90DaysOfDevOps và vào ngày 10), chúng ta đã tìm hiểu về không gian làm việc Go và đi sâu hơn một chút vào biên dịch và chạy mã.

Hôm nay chúng ta sẽ tìm hiểu về Biến, Hằng số và ...', '2023-02-27T02:42:00.000000Z', '2023-02-27T04:12:08.000000Z'),
	('90 ngày DevOps - Ngày 10 - Không gian làm việc của Go', '## Không gian làm việc của Go

Vào [ngày 8](https://vntechies.dev/courses/90-ngay-devops/ngay-8-thiet-lap-moi-truong-devops-cho-go-hello-world), chúng ta đã giới thiệu qua về không gian làm việc của Go, khởi động và demo bằng chương trình `Hello #90DaysOfDevOps`. Tuy nhiên cũng nên tìm hiểu kỹ hơn về không gian làm việc Go.

Hãy nhớ rằng chúng ta đã chọn các giá trị mặc định khi cài đặt Go và sau đó đã tạo các thư mục Go trong GOPATH mặc định đó nhưng trên thực tế, GOPATH có thể được thay đổi thành bất cứ nơi nào bạn muốn.

Nếu bạn chạy

```shell
echo $GOPATH
```

Đầu ra sẽ tương tự như thế này (tên người dùng có thể sẽ khác):

```shell
/home/michael/projects/go
```

Sau đó, ở đây, chúng ta đã tạo 3 thư mục. **src**, **pkg** and **bin**

![](https://images.viblo.asia/45921044-093e-449f-b843-1c31084bfbae.png)

**src** là nơi lưu trữ tất cả các chương trình và dự án Go. Điều này xử lý việc quản lý không gian tên của các gói (packages) cho tất cả các kho lưu trữ (repositories) Go. Ở đây bạn có thể thấy rằng máy trạm của tôi có thư mục Hello cho dự án Hello #90DaysOfDevOps.

![Day10_Go2.png](https://images.viblo.asia/cb5c1cb7-b94d-408b-9c05-19ea961a3ede.png)

**pkg** là một tệp lưu trữ của các gói đã hoặc đang được cài đặt trong chương trình. Điều này giúp tăng tốc quá trình biên dịch dựa trên việc các gói được sử dụng có thay đổi hay không.![Day10_Go1.png](https://images.viblo.asia/ae60b25a-5857-441e-bead-ab22959edace.png)

![Day10_Go3.png](https://images.viblo.asia/a713f1e8-70cd-4f17-b8e8-8605aae6e38b.png)

**bin** là nơi lưu trữ tất cả các tệp nhị phân đã được biên dịch.

![Day10_Go4.png](https://images.viblo.asia/3a3f0322-4180-42d5-b2d6-962b1f991b9d.png)

Hello #90DaysOfDevOps không phải là một chương trình phức tạp, đây là một ví dụ về chương trình Go phức tạp hơn được lấy từ một tài nguyên tuyệt vời khác [GoChronicles](https://gochronicles.com/)

![Day10_Go5.png](https://images.viblo.asia/967a6df9-d34f-4ee8-92b2-c25f8f915438.png)

Bạn cũng có thể đi sâu vào một số chi tiết về lý do và cách tổ chức một dự án Go. Nó cũng đi sâu hơn một chút về các thư mục khác mà chúng ta chưa đề cập đến [GoChronicles](https://gochronicles.com/project-structure/)

### Biên dịch & Chạy mã

Chúng ta cũng đã giới thiệu sơ qua về việc biên dịch mã ở [ngày 9](/courses/90-ngay-devops/ngay-9-giai-thich-ma-hello-world), nhưng hãy đi sâu hơn một chút.

Cần phải **biên dịch** mã trước khi chạy mã. Có 3 cách để làm vậy với Go

- go build
- go install
- go run

Trước khi đến giai đoạn biên dịch ở trên, chúng ta cần xem xét những gì nhận được sau khi cài đặt Go.

Khi cài đặt Go vào ngày 8, chúng ta đã cài đặt một thứ được gọi là công cụ Go bao gồm một số chương trình cho phép xây dựng và xử lý các tệp mã nguồn Go của mình. Một trong số những công cụ đó là `go`

Điều đáng chú ý là bạn có thể cài đặt thêm các công cụ không có trong bản cài đặt Go tiêu chuẩn.

Nếu bạn mở dấu nhắc lệnh của mình và nhập `go`, bạn sẽ thấy như hình ảnh dưới đây và sau đó bạn sẽ thấy "một số những câu lệnh khác" phía bên dưới, tuy nhiên không chưa cần phải quan tâm tới chúng.

![Day10_Go6.png](https://images.viblo.asia/11b13093-2616-4f11-91ee-6747bc237d51.png)

Bạn cũng có thể nhớ rằng chúng ta đã sử dụng ít nhất hai công cụ vào ngày 8.

![Day10_Go7.png](https://images.viblo.asia/2047b4f0-ea1b-42cf-a4c7-df812583b005.png)

Những thứ chúng ta muốn tìm hiểu thêm là build, install and run.

![Day10_Go8.png](https://images.viblo.asia/9edf0c7e-c8a4-4917-b28b-057ac01757e3.png)

- `go run` - Lệnh này biên dịch và chạy gói chính bao gồm các tệp .go được chỉ định trên dòng lệnh. Các file biên dịch được lưu trữ trong một thư mục tạm thời.
- `go build` - Để biên dịch các gói và phần phụ thuộc trong thư mục hiện tại. Nếu là gói `main`, sẽ đặt tệp thực thi trong thư mục hiện tại, nếu không, tệp thực thi sẽ được đặt trong thư mục `pkg`. `go build` cũng cho phép bạn tạo một tệp thực thi cho bất kỳ nền tảng, hệ điều hành được hỗ trợ bởi của Go.
- `go install` - Tương tự như go build nhưng sẽ đặt tệp thi hành vào thư mục `bin`

Chúng ta đã chạy qua go build và go run nhưng vui lòng chạy lại chúng ở đây nếu bạn muốn, `go install` như đã nêu ở trên đặt tệp thực thi vào thư mục bin của chúng ta.

Chúng ta đã sử dụng go build và go run nhưng hãy thử lại nếu bạn muốn, `go install` như đã trình bày ở trên, sẽ đặt tệp thực thi trong thư mục `bin`.

![Day10_Go9.png](https://images.viblo.asia/6b6e36e4-2181-42cc-9896-a5fd0e95e0a7.png)

Hy vọng rằng bạn vừa theo dõi nội dung các ngày qua cùng lúc với xem một trong những video bên dưới. Tôi ghi lại và tóm tắt những thứ này thành ghi chú của bản thân để có thể hiểu được kiến thức nền tảng về Golang. Các tài nguyên dưới đây có thể giúp bạn hiểu rõ hơn về nhiều kiến thức tổng thể khác mà bạn cần khi học Golang, nhưng tôi sẽ chia sẻ một số điều thú vị mà tôi tìm thấy trong hành trình 7 ngày hay 7 giờ của mình.

## Tài liệu tham khảo

- [StackOverflow 2021 Developer Survey](https://insights.stackoverflow.com/survey/2021)
- [Why we are choosing Golang to learn](https://www.youtube.com/watch?v=7pLqIIAqZD4&t=9s)
- [Jake Wright - Learn Go in 12 minutes](https://www.youtube.com/watch?v=C8LgvuEBraI&t=312s)
- [Techworld with Nana - Golang full course - 3 hours 24 mins](https://www.youtube.com/watch?v=yyUHQIec83I)
- [**NOT FREE** Nigel Poulton Pluralsight - Go Fundamentals - 3 hours 26 mins](https://www.pluralsight.com/courses/go-fundamentals)
- [FreeCodeCamp - Learn Go Programming - Golang Tutorial for Beginners](https://www.youtube.com/watch?v=YS4e4q9oBaU&t=1025s)
- [Hitesh Choudhary - Complete playlist](https://www.youtube.com/playlist?list=PLRAV69dS1uWSR89FRQGZ6q9BR2b44Tr9N)

Hẹn gặp lại tại [ngày 11](https://vntechies.dev/courses/90-ngay-devops/ngay-11-bien-hang-so-kieu-du-lieu).

## VNTechies Dev Blog 🇻🇳 - Kho tài nguyên về Cloud ☁️ / DevOps 🚀
![](https://images.viblo.asia/1712f084-ee0f-47e8-b2a3-9af6cddf56f6.png)

- Website: https://vntechies.dev/
- Github repository: https://github.com/vntechies/blog
- Facebook: https://facebook.com/vntechies

Anh chị em hãy follow/ủng hộ VNTechies  để cập nhật những thông tin mới nhất về Cloud và DevOps nhé!

## License

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

Các bài viết là bản tiếng Việt của tài liệu [90DaysOfDevOps](https://github.com/MichaelCade/90DaysOfDevOps/tree/main/Days) của [Micheal Cade](https://twitter.com/MichaelCade1) và có qua sửa đổi, bổ sung. Tất cả đều có license [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

> License này chỉ cho phép người khác có thể thực hiện đăng tải lại, chỉnh sửa và xây dựng dựa trên nội dung gốc cho mục đích phi thương mại kèm theo điều kiện ghi công cho tác giả chẳng hạn như: nêu tên tác giả, dẫn link tới tác phẩm gốc hoặc theo yêu cầu riêng của tác giả;
> Ngoài ra, các bản phân phối, sửa đổi bắt buộc phải gắn cùng license với tác phẩm gốc.

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg', 'MkNLrOkbVgA', '7', 'https://images.viblo.asia/6696470a-88af-445e-b4e9-5e038c5426ff.png', 'Không gian làm việc của Go

Vào ngày 8, chúng ta đã giới thiệu qua về không gian làm việc của Go, khởi động và demo bằng chương trình Hello #90DaysOfDevOps. Tuy nhiên cũng nên tìm hiểu kỹ hơn về không gian làm việc Go.

Hãy nhớ rằng chúng ta đã chọn các giá trị mặc định khi cài đặt Go và sau đó đã tạo các thư mục Go trong GOPATH mặc định đó nhưng trên thực tế, GOPATH có thể được thay đổi thành ...', '2023-02-27T02:32:40.000000Z', '2023-02-27T04:18:06.000000Z'),
	('Điểm tin AI tuần qua: 20/02/2023 - 26/02/2023', 'Chương trình điểm tin hàng tuần của AI Research được xây dựng nhằm mục đích giúp bạn cập nhật các xu hướng mới nhất. Nội dung của chương trình bao gồm các nội dung như sau:

# Các hoạt động đáng chú ý trong tuần:
- Harvard CS197 AI Research Experiences @ https://docs.google.com/document/d/1uvAbEhbgS_M-uDMTzmOWRlYxqCkogKRXdbKYYT98ooc/edit#heading=h.o3hogvl0ayc1
- Ask-Me-Anything: Open & Reproducible Data Science @ https://heidiseibold.ck.page/posts/ask-me-anything-open-reproducible-data-science?utm_source=substack&utm_medium=email
- InstructGPT generalized to follow instructions in non-English even though we almost exclusively trained on English. @ https://twitter.com/janleike/status/1625207251630960640?utm_source=substack&utm_medium=email

# Các bài viết nổi bật:
- Incredible PyTorch Ecosystem @ https://github.com/ritchieng/the-incredible-pytorch
- Blueprints for recommender system architectures: 10th anniversary edition @ https://amatriain.net/blog/RecsysArchitectures
- A Categorical Archive of ChatGPT Failures @ https://arxiv.org/abs/2302.03494
-  Multimodal Chain-of-Thought Reasoning in Language Models @ https://www.linkedin.com/feed/update/urn:li:activity:7033581931879440384/
- ML Serving @ https://hamel.dev/notes/serving/?utm_source=substack&utm_medium=email
- Prioritizing Home Attributes Based on Guest Interest @ https://medium.com/airbnb-engineering/prioritizing-home-attributes-based-on-guest-interest-3c49b827e51a

# Các sự kiện sắp diễn ra:
- Generative AI Conference Sessions @ https://register.nvidia.com/events/widget/nvidia/gtcspring2023/1674855518111001o2Ur/?nvid=nv-int-bnr-463583#new_tab', '5pPLkPxdVRZ', '8', 'https://img.youtube.com/vi/4Yd_BARFgac/hqdefault.jpg', 'Chương trình điểm tin hàng tuần của AI Research được xây dựng nhằm mục đích giúp bạn cập nhật các xu hướng mới nhất. Nội dung của chương trình bao gồm các nội dung như sau:

Các hoạt động đáng chú ý trong tuần:
- Harvard CS197 AI Research Experiences @ https://docs.google.com/document/d/1uvAbEhbgS_M-uDMTzmOWRlYxqCkogKRXdbKYYT98ooc/edit#heading=h.o3hogvl0ayc1
- Ask-Me-Anyt...', '2023-02-27T02:25:27.000000Z', '2023-02-27T04:16:07.000000Z'),
	('Cấu Trúc Dữ Liệu Và Giải Thuật - Graph Algorithms - Depth First Search (DFS)', 'Để giải các bài toán trên đồ thị, chúng ta cần một cơ chế duyệt đồ thị. Giống như thuật toán duyệt cây (Inorder, Preorder, Postorder và Level-Order traverse), các thuật toán tìm kiếm đồ thị bắt đầu từ một số đỉnh nguồn trong đồ thị và tìm kiếm đồ thị bằng cách đi qua các cạnh và đánh dấu các đỉnh. Bây giờ, chúng ta sẽ thảo luận về thuật toán tìm kiếm theo chiều sâu (Depth First Search - DFS),

## 1. Giới thiệu
Tìm kiếm theo chiều sâu (DFS) là một thuật toán để duyệt qua hoặc tìm kiếm cấu trúc dữ liệu dạng cây hoặc đồ thị. Thuật toán bắt đầu tại nút gốc (chọn một số nút tùy ý làm nút gốc trong trường hợp đồ thị) và kiểm tra từng nhánh càng xa càng tốt trước khi quay lui.

Kết quả của một DFS là một cây bao trùm (spanning tree). Cây bao trùm (spanning tree) là một đồ thị không có vòng lặp. Để thực hiện duyệt theo DFS, chúng ta cần sử dụng cấu trúc dữ liệu ngăn xếp có kích thước tối đa bằng tổng số đỉnh trong biểu đồ.
## 2. Thuật toán

Để cài đặt DFS, ta cần thực hiện các bước sau:
1. Lấy một đỉnh bất kỳ trong đồ thì đưa vào ngăn xếp.
2. Lấy top value của ngăn xếp để duyệt và thêm vào visited list.
3. Tạo một list bao gồm các đỉnh liền kề của đỉnh đang xét, thêm những đỉnh không có trong visited list vào ngăn xếp.
4. Tiếp tục lặp lại bước 2 và bước 3 đến khi ngăn xếp rỗng.

### **Ví dụ:**

Hãy xem thuật toán Tìm kiếm theo chiều sâu hoạt động như thế nào với một ví dụ. Chúng ta dùng đồ thị vô hướng có 5 đỉnh.
![](https://images.viblo.asia/3b071ecc-04b5-4afd-920a-9951d9bc0868.png)
Chúng ta bắt đầu từ đỉnh 0, thuật toán DFS bắt đầu bằng cách đứa nó vào danh sách Visited và đưa tất cả các cạnh liền kề đỉnh đang xét vào ngăn xếp.
![](https://images.viblo.asia/fb73067a-1217-4a60-b4a8-0b75518332fc.png)
Tiếp theo, chúng ta truy cập phần tử ở đầu ngăn xếp tức là 1 và đi đến các nút liền kề của nó. Vì 0 đã được truy cập, nên 2 là số được xét.
![](https://images.viblo.asia/d038238c-50ed-4a50-bacd-9a36b9f6a133.png)
Đỉnh 2 có một đỉnh liền kề chưa được thăm là 4, vì vậy chúng ta thêm đỉnh đó vào vị trí đầu của ngăn xếp và duyệt nó.
![](https://images.viblo.asia/c929e290-abe3-4122-9c00-2656d7f4ec22.png)
![](https://images.viblo.asia/ad3136c8-a305-492f-ae0f-2878d136adca.png)
Sau khi chúng ta duyệt phần tử 3 cuối cùng, nó không có bất kỳ nút liền kề nào chưa được duyệt, vì vậy chúng tôi đã hoàn thành tìm kiếm theo chiều sâu trong đồ thị trên.
![](https://images.viblo.asia/cc87184f-ab26-47a3-9017-d07cf0111ec0.png)
## 3. Cài đặt
```
// DFS algorithm in Java

import java.util.*;

class Graph {
  private LinkedList<Integer> adjLists[];
  private boolean visited[];

  // Graph creation
  Graph(int vertices) {
    adjLists = new LinkedList[vertices];
    visited = new boolean[vertices];

    for (int i = 0; i < vertices; i++)
      adjLists[i] = new LinkedList<Integer>();
  }

  // Add edges
  void addEdge(int src, int dest) {
    adjLists[src].add(dest);
  }

  // DFS algorithm
  void DFS(int vertex) {
    visited[vertex] = true;
    System.out.print(vertex + " ");

    Iterator<Integer> ite = adjLists[vertex].listIterator();
    while (ite.hasNext()) {
      int adj = ite.next();
      if (!visited[adj])
        DFS(adj);
    }
  }

  public static void main(String args[]) {
    Graph g = new Graph(4);

    g.addEdge(0, 1);
    g.addEdge(0, 2);
    g.addEdge(1, 2);
    g.addEdge(2, 3);

    System.out.println("Following is Depth First Traversal");

    g.DFS(2);
  }
}
```

## 4. Độ phức tạp

Độ phức tạp thời gian của thuật toán DFS được biểu diễn dưới dạng O(V + E), trong đó V là số nút và E là số cạnh.
Độ phức tạp không gian của thuật toán là O(V).
## 5. Ứng dụng

* Giải các câu đố mê cung.
* Tìm đường đi.
* Để kiểm tra xem đồ thi có phải là hai hướng.
* Phát hiện chu trình cho đồ thị

Nguồn: https://www.programiz.com/dsa/graph-dfs', 'qPoL7zyXJvk', '9', '', 'Để giải các bài toán trên đồ thị, chúng ta cần một cơ chế duyệt đồ thị. Giống như thuật toán duyệt cây (Inorder, Preorder, Postorder và Level-Order traverse), các thuật toán tìm kiếm đồ thị bắt đầu từ một số đỉnh nguồn trong đồ thị và tìm kiếm đồ thị bằng cách đi qua các cạnh và đánh dấu các đỉnh. Bây giờ, chúng ta sẽ thảo luận về thuật toán tìm kiếm theo chiều sâu (Depth First Search - DFS), ...', '2023-02-26T16:53:57.000000Z', '2023-02-27T03:49:07.000000Z'),
	('10 Techniques quan trọng của Business Analyst (Phần 1)', '*Có thể các bạn đã biết, trong cuốn sách gối đầu của BA tụi mình là cuốn BABOK, có đến tận 50 techniques để BA tham khảo. Tuy nhiên để thích nghi với từng hoàn cảnh cũng như từng giai đoạn phát triển của một BA, chúng ta cần phải chắt lọc ra những techniques quan trọng và có thể áp dụng được ngay vào công việc của mình.*

*Dưới đây là 5 techniques đầu tiên mà mình muốn giới thiệu đến các bạn. Cùng mình tìm hiểu nhé 😎*
## 1. Document Analysis
Document Analysis là quá trình phân tích các tài liệu liên quan đến một dự án hoặc quá trình kinh doanh nhằm tìm hiểu và đánh giá các thông tin cần thiết để làm dự án. Tài liệu có thể bao gồm như các báo cáo, hợp đồng, biểu mẫu, tài liệu pháp lý,...
![](https://images.viblo.asia/6cf8a3fa-7151-455d-ad82-3d81001427f9.gif)

Mục đích của Document Analysis là để thu thập thông tin, tìm ra các vấn đề, tìm hiểu các yêu cầu của dự án để đưa ra các giải pháp. Quá trình này thường được thực hiện trong giai đoạn phân tích yêu cầu.

## 2. Brainstorming
Brainstorming là một phương pháp tập trung nhóm để tạo ra các ý tưởng mới và sáng tạo trong một môi trường không bị giới hạn. Nó thường được sử dụng trong các dự án hoặc quá trình kinh doanh để tạo ra các giải pháp hoặc ý tưởng mới.
![](https://images.viblo.asia/082fa22e-a5ed-4a12-8548-10f0aa60a529.gif)
Trong quá trình brainstorming, nhóm sẽ tập trung vào một chủ đề cụ thể và thảo luận về nó một cách tự do và không bị ràng buộc. Các thành viên của nhóm được khuyến khích để đưa ra những ý tưởng mới mà không bị đánh giá hoặc chê bai. Các ý tưởng này được ghi lại và sau đó được đánh giá và sàng lọc để tìm ra những ý tưởng tiềm năng nhất.

## 3. Workshops
Workshop là một hoạt động nhóm tập trung vào một chủ đề cụ thể nhằm đạt được mục tiêu nhất định. Có thể là phát triển ý tưởng mới, giải quyết các vấn đề khó khăn trong doanh nghiệp hay là chia sẻ về chủ đề nào đó. Workshop cho phép các chuyên gia tương tác với nhau để tạo ra các ý tưởng mới, thúc đẩy sự tham gia tích cực và đạt được kết quả chính xác và đáng tin cậy.

![](https://images.viblo.asia/05c1ada9-5335-4c11-bfd1-b85238164911.gif)

Để thực hiện một buổi Workshops hiệu quả. BA cần chuẩn bị những thứ quan trọng sau:
* Xác định mục tiêu và phạm vi của workshop
* Lập danh sách và lựa chọn các thành viên trong workshop
* Chuẩn bị các tài liệu cần thiết cho workshop
* Thiết kế cấu trúc của workshop
* Thực hiện workshop
* Đánh giá và xử lý các ý tưởng thu thập được

## 4. Process Analyst
Kỹ thuật Process Analyst là một phương pháp sử dụng để phân tích và cải tiến các quy trình kinh doanh hiện tại. Kỹ thuật này tập trung vào việc hiểu và đánh giá quy trình kinh doanh thông qua các hoạt động, nguồn lực và sản phẩm của quy trình.

![](https://images.viblo.asia/292f0403-efe7-4669-a37b-3295224a100c.gif)

Để cải tiến quy trình, BA phải tìm ra các khuất mắc và nguyên nhân gây ra các vấn đề trong quy trình hiện tại. Từ đó đề xuất một quy trình mới từ kết quả đã phân tích được, nhưng phải đảm bảo rằng quy trình mới phải tối ưu hóa hơn về mặt thời gian, chi phí và chất lượng, hiệu suất kinh doanh tốt hơn so với quy trình cũ.

## 5. Process Modelling
Process Modelling là một phương pháp để mô hình hóa quy trình kinh doanh bằng cách sử dụng các biểu đồ và biểu đồ luồng dữ liệu để đưa ra một hình ảnh rõ ràng về các bước, quy trình và thông tin trong quy trình. Kỹ thuật này giúp BA hiểu rõ hơn về quy trình kinh doanh hiện tại và đưa ra các cải tiến cho quy trình.
![](https://images.viblo.asia/5a9f3078-61b4-443d-a7c3-c2848a2ad0dc.gif)
Một vài biểu đồ được sử dụng phổ biến nhất:
* Flowcharts
* Data Flow diagrams and Unified Modelling Language™ (UML®) diagrams
* Business Process Model and Notation

## Lời kết
Để tránh tình trạng bài viết dài lê thê nên 5 techniques còn lại mình sẽ up vào bài sau nhé ^^ Nếu thấy bài viết này mang lại giá trị gì đó cho bạn, hãy up vote cho mình nhé.

Đừng quên follow mình trên Viblo để nhận được thông báo về các bài viết mới. Hoặc follow mình trên:

**Blog cá nhân**: [tothanhdat.com](https://tothanhdat.com) (thiệt zui khi có ai đó ghé blog của mình > <)

**Facebook**: [Tô Thành Đạt](https://www.facebook.com/TOTHANHDAT.TTD/)

**LinkedIn**: [To Dat](https://www.linkedin.com/in/tothanhdat/)', 'W13VMge7JY7', '10', 'https://images.viblo.asia/6f659245-1d9b-4540-a326-9155a99d12cc.png', 'Có thể các bạn đã biết, trong cuốn sách gối đầu của BA tụi mình là cuốn BABOK, có đến tận 50 techniques để BA tham khảo. Tuy nhiên để thích nghi với từng hoàn cảnh cũng như từng giai đoạn phát triển của một BA, chúng ta cần phải chắt lọc ra những techniques quan trọng và có thể áp dụng được ngay vào công việc của mình.

Dưới đây là 5 techniques đầu tiên mà mình muốn giới thiệu đến các bạn. Cùng...', '2023-02-26T16:47:59.000000Z', '2023-02-27T03:45:04.000000Z'),
	('Xây dựng chức năng quản lý phiên đăng nhập trên nhiều thiết bị sử dụng NestJS và JWT', 'Trong bài viết trước, mình đã mô tả các lỗi bảo mật cơ bản phía Backend API qua các ví dụ cụ thể. Ở bài viết này, mình sẽ xây dựng một chức năng quản lý phiên đăng nhập trên nhiều thiết bị sử dụng [JWT](https://viblo.asia/p/json-web-token-la-gi-aWj533go56m). Các hệ thống lớn như Google, Facebook... Một trong những điều kiện tiên quyết sống còn về bảo mật của một tài khoản phải có ít nhất những thứ sau đây. Đầu tiên là cảnh báo khi có thiết bị lạ đăng nhập dựa trên fingerprint như địa chỉ IP mới, deviceId mới. Điều thứ 2 là cũng là quan trọng nhất đó là quản lý được các phiên đăng nhập hiện hành mà tài khoản đó đang đăng nhập trên các thiết bị và tất nhiên là điều này sẽ đúng luôn với cả việc 1 ai đó sử dụng tài khoản của bạn trên một thiết bị khác, có thể do sơ hở của bạn mà đánh mất mật khẩu trên một trang phishing nào đó chẳng hạn.

Tuy nhiên khi đã sử dụng token để xác thực có nghĩa rằng phía client và phía server sẽ không lưu trữ trạng thái của nhau cho đến khi yêu cầu cuối cùng được client gửi lên server thông quan giao thức http/ https và gắn token trong header để server biết bạn là ai và đang sử dụng thiết bị nào.

Câu hỏi được đặt ra là "Điều gì sẽ xảy ra khi có sự tranh chấp tài khoản". Bởi vì các phiên đăng nhập hợp lệ được cấp dựa trên tài khoản và mật khẩu chính xác của một tài khoản được định danh duy nhất thông qua trường userId, và rõ ràng là user thì cũng có thể đăng nhập ở nhiều nơi và thậm chí người dùng đôi khi còn quên đăng xuất. Kể lại một chút câu chuyện ngày xưa hồi nhỏ đi chơi net, ông nào đi về mà quên thoát nick facebook ở quán net thì xác định luôn là bị đăng hoặc nhắn tin bậy bạ lên facebook :) Nhưng kẻ xấu thì chỉ có thể sử dụng phiên đó cho đến khi bị đăng xuất từ xa, hoặc ông nào vọc vạch một chút thì có thể export cái cookies ở máy đó rồi đem về nhà import vào máy mình và sử dụng tiếp cái nick kia. Cái trò này bây giờ các trang buff like, comment vẫn đang làm. Mình cũng có thể tạm gọi đây là trường hợp "Tài khoản đang trong quá trình tranh chấp".

Để xử lý vấn đề này thì mình sẽ chia làm 3 cấp độ ưu tiên để xác minh đâu là chủ tài khoản. Một là dựa trên việc có mật khẩu thật, tiếp theo nếu cả 2 cùng có mật khẩu thật thì sẽ tính đến các yếu tố như email, thiết bị thường xuyên đăng nhập, nếu bước 2 mà vẫn không thu hồi được tài khoản thì buộc khóa tài khoản và xác minh danh tính. Dưới đây mình sẽ không đi sâu về nghiệp vụ về bảo vệ tài khoản cho người dùng mà Google, Facebook đã làm, nhưng mình sẽ xây dựng cách mà quản lý phiên đăng nhập sử dụng JWT, làm sao để thu hồi 1 JWT đã cấp cho 1 device. Và code được mình viết trên NestJS

Để bắt đầu mình sẽ tóm tắt lại các phần mình sẽ làm như sau
1. Xây dựng các bảng trong cơ sở dữ liệu liên quan đến quản lý user và device sessions. Quan hệ giữa user và device session là quan hệ một nhiều. Vì 1 user có thể đăng nhập nhiều thiết bị
2. Xử lý logic đăng nhập
3. Xử lý và lưu trữ phiên khi đăng nhập
4. Đăng xuất trên một/ nhiều thiết bị
5. ReAuth với refresh token

> Mục tiêu của hệ thống này là quản lý được phiên đăng nhập. Một thiết bị đăng nhập hợp lệ được nhận dạng thông qua 4 yếu tố đó là: userId, deviceId, secretKey(=> token jwt), refresh token. Điều này giúp đảm bảo token đã cấp cho 1 thiết bị thì sẽ không thể đem sang thiết bị khác sử dụng được, đó cũng là 1 phần để tránh việc bị lộ token trong quá trình truyền tin.

## Xây dựng 2 bảng cơ sở dữ liệu cho chức năng này bằng TypeORM
```perl
@Entity(''user'')
export class UserEntity {
  @PrimaryColumn({ type: ''uuid'' })
  @Generated(''uuid'')
  id: string;
  @Column({ unique: true })
  email: string;
  @Column()
  password: string;
  @Column()
  salt: string;
  @Column({ type: ''timestamp'', default: () => ''CURRENT_TIMESTAMP'' })
  createdAt: Date;
  @UpdateDateColumn()
  updatedAt: Date;
  @OneToMany(() => DeviceSessionEntity, (deviceSessions) => deviceSessions.id)
  deviceSessions: DeviceSessionEntity[];

@Entity(''device-session'')
export class DeviceSessionEntity {
  @PrimaryColumn({ type: ''uuid'' })
  @Generated(''uuid'')
  id: string;
  @Column({ unique: true })
  deviceId: string;
  @Column({ nullable: true })
  name: string;
  @Column()
  ua: string;
  @Column()
  secretKey: string;
  @Column()
  refreshToken: string;
  @Column()
  expiredAt: Date;
  @Column()
  ipAddress: string;
  @Column({ type: ''timestamp'', default: () => ''CURRENT_TIMESTAMP'' })
  createdAt: Date;
  @UpdateDateColumn()
  updatedAt: Date;
  @ManyToOne(() => UserEntity, (user) => user.id)
  user: string;
}
```

## Xây dựng chức năng đăng nhập
Khi xác thực email và mật khẩu thành công, hệ thống tiến hành tạo một phiên đăng nhập mới và trả về cho client token, refreshToken và expiredAt

Đoạn controler đăng nhập này là tiền xử lý các body payload và meta data từ phía client gửi lên để nhận dạng thiết bị và người dùng đang gửi yêu cầu:
```javascript
  @Post(''login'')
  async login(
    @Req() req,
    @Body() loginDto: LoginDto,
    @Headers() headers: Headers,
  ) {
    const fingerprint = req.fingerprint;
    const ipAddress = req.connection.remoteAddress;
    const ua = headers[''user-agent''];
    const deviceId = fingerprint.hash;
    const metaData: LoginMetadata = { ipAddress, ua, deviceId };
    return this.usersService.login(loginDto, metaData);
  }
```

Khi validate đầy đủ các dữ liệu đầu vào, tiến trình sẽ gọi tiếp đến hàm service để xử lý email và mật khẩu người dùng gửi lên trong body payload:
```javascript
 async login(loginDto: LoginDto, metaData: LoginMetadata) {
    const { email, password } = loginDto;
    const user = await this.repository.findOne({
      where: { email },
    });
    if (
      !user ||
      user.password !== (await this.hashPassword(password, user.salt))
    ) {
      throw new UnauthorizedException(''Email or password incorect'');
    } else {
      return await this.deviceSessionsService.handleDeviceSession(
        user.id,
        metaData,
      );
    }
  }
```

Khi xác thực đúng tài khoản mật khẩu thì sẽ đến phần tạo phiên đăng nhập bằng cách tạo 1 bản ghi trong bảng "device_sessions". Trong logic dưới đây đã kiểm tra xem deviceId đã tồn tại hay chưa. Nếu tồn tại rồi thì ghi đè lên phiên cũ với thời gian hết hạn mới là `expiredAt = addDay(EXP_SESSION)` còn không thì tạo mới bản ghi với 1 UUID ngẫu nhiên. Lưu ý 1 chút đoạn mình sử dụng UUID làm khóa chính cho bảng. Khác với ID tự tăng là phải khi nào ghi vào cơ sở dữ liệu mới sinh ra ID thì UUID có thể tạo ra trước khi ghi vào cơ sở dữ liệu vẫn được coi là hợp lệ. Ở đây mình đang cho cứ nếu thiết bị gọi yêu cầu đăng nhập thì đều cập nhật lại secret key và refresh token để đảm bảo tính toàn vẹn của phiên đăng nhập trước đó và cũng coi đó như là một bước để thu hồi token đã cấp.

```javascript
  async handleDeviceSession(
    userId: string,
    metaData: LoginMetadata,
  ): Promise<LoginRespionse> {
    const { deviceId } = metaData;
    const currentDevice = await this.repository.findOne({
      where: { deviceId },
    });

    const expiredAt = addDay(EXP_SESSION);
    const secretKey = this.generateSecretKey();

    const payload = {
      id: userId,
      deviceId,
    };
    const [token, refreshToken] = [
      JwtStrategy.generate(payload, secretKey),
      randomatic(''Aa0'', 64),
    ];

    const deviceName = metaData.deviceId;
    const newDeviceSession = new DeviceSessionEntity();
    newDeviceSession.user = userId;
    newDeviceSession.secretKey = secretKey;
    newDeviceSession.refreshToken = refreshToken;
    newDeviceSession.expiredAt = expiredAt;
    newDeviceSession.deviceId = deviceId;
    newDeviceSession.ipAddress = metaData.ipAddress;
    newDeviceSession.ua = metaData.ua;
    newDeviceSession.name = deviceName;

    // update or create device session
    await this.repository.save({
      id: currentDevice?.id || randomUUID(),
      ...newDeviceSession,
    });
    return { token, refreshToken, expiredAt };
  }
```
![image.png](https://images.viblo.asia/54bb91bc-554f-40ec-ab80-258fe66170bc.png)

Mình cũng có thêm 1 UserId decorator để lấy userId từ token ở các controler như sau.

```javascript
import { createParamDecorator, ExecutionContext } from ''@nestjs/common'';
import { JwtStrategy } from ''src/auth/guard/jwt.strategy'';

export const UserId = createParamDecorator(
  (data: string, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();
    return JwtStrategy.getPayload(request.headers)[''id''];
  },
);
```

## Máy chủ nhận dạng thiết bị và token như thế nào

Trong khi code mình đã sử dụng 1 thư viện để lấy được mã fingerprint của request đó là  [express-fingerprint](https://www.npmjs.com/package/express-fingerprint) và sử dụng nó như một Middleware của NestJS. Điều này cho ta dễ dàng hơn khi có thể lấy được mã hash nhận dạng thiết bị thông qua `request.fingerprint.hash`

```javascript
const Fingerprint = require(''express-fingerprint'');
  app.use(
    Fingerprint({
      parameters: [
        Fingerprint.useragent,
        Fingerprint.acceptHeaders,
        Fingerprint.geoip,
      ],
    }),
  );
```

Để đảm bảo được rằng token cấp cho thiết bị đang được sử dụng bởi chính thiết bị đó thì sẽ viết hàm Guard như sau:

```javascript
export class JwtAuthGuard implements CanActivate {
  constructor(private reflector: Reflector, private authService: AuthService) {}

  private async validateRequest(request): Promise<boolean> {
    const headers = request.headers;
    const token = headers.authorization || null;
    if (!token) return false;
    const checkDeviceId = request.fingerprint.hash;
    const deviceId = JwtStrategy.getPayload(request.headers)[''deviceId''];

    if (checkDeviceId !== deviceId) {
      throw new UnauthorizedException(''Token not issued for this device'');
    }
    try {
      const secretKey = await this.authService.getSecretKey(request);
      return !!JwtStrategy.verify(token, secretKey);
    } catch (e) {
      return false;
    }
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    if (this.reflector.get(keyPublicRoute, context.getHandler())) return true;

    const request = context.switchToHttp().getRequest();

    if (!(await this.validateRequest(request))) {
      throw new UnauthorizedException();
    }
    return true;
  }
}
```
Một mặt chúng ta lấy deviceId từ fingerprint và so sánh với deviceId ở trong token. Điều này giúp chắc chắn rằng phiên đăng nhập này không bị đánh cắp và sử dụng ở thiết bị khác, bởi vì như đã nói ở trên, deviceId và secret key sinh ra token là một cặp ngẫu nhiên khớp nhau cho mỗi phiên trên một thiết bị.
## Lấy những phiên đã đăng nhập
Hàm này thì khá cơ bản, chủ yếu chỉ là lấy userId để truy vấn vào database lấy ra các phiên đã đăng nhập của user đó
```javascript
async getDeviceSessions(userId: string) {
    return this.repository.find({
      where: {
        user: userId,
      },
      select: [
        ''id'',
        ''deviceId'',
        ''createdAt'',
        ''ipAddress'',
        ''name'',
        ''ua'',
        ''expiredAt'',
        ''updatedAt'',
      ],
    });
  }
```
![image.png](https://images.viblo.asia/19f5fd55-7228-43d0-b722-6be59b80d497.png)

## Cấp lại token bằng phương thức reAuth với refresh token
Cũng như các hệ thống khác, mình cấp token có thời hạn rất ngắn, thường chỉ tính bằng phút và một refresh token có thời hạn khoảng 1 tuần. Điều này cũng là 1 cách để đảm bảo an toàn thông tin cho hệ thống xác thực của Backend API. Điều cần làm là gửi refresh token lên và hệ thống sẽ kiểm tra xem refresh token này trong cơ sở dữ liệu có đúng là của thiết bị đã được cấp trước đó hay không. Cụ thể code như sau:

```javascript
async reAuth(
    deviceId: string,
    _refreshToken: string,
  ): Promise<LoginRespionse> {
    const session: any = await this.repository
      .createQueryBuilder(''session'')
      .select(''session'', ''user.id'')
      .leftJoinAndSelect(''session.user'', ''user'')
      .where(''session.refreshToken = :_refreshToken'', { _refreshToken })
      .andWhere(''session.deviceId = :deviceId'', { deviceId })
      .getOne();

    if (
      !session ||
      new Date(session.expiredAt).valueOf() < new Date().valueOf()
    ) {
      throw new UnauthorizedException(''Refresh token invalid'');
    }

    const payload = {
      id: session.user.id,
      deviceId,
    };

    const secretKey = this.generateSecretKey();
    const [token, refreshToken, expiredAt] = [
      JwtStrategy.generate(payload, secretKey),
      randomatic(''Aa0'', 64),
      addDay(7),
    ];

    await this.repository.update(session.id, {
      secretKey,
      refreshToken,
      expiredAt,
    });
    return { token, refreshToken, expiredAt };
  }
```

Về bản chất thì hàm reAuth sẽ trả về các thông tin như một hàm login. Và cũng lần lượt các bước kiểm tra thông tin deviceId và refresh token, thời gian hợp lệ. Khi token mới được cấp thì cũng tiến hành cập nhật secret key mới và refresh token mới vào trong database.
![image.png](https://images.viblo.asia/8946b521-db2e-4cb5-b0bc-ced3478b1341.png)

## Đăng xuất một thiết bị chỉ định
Và chúng ta có thêm một hàm để xử lý việc đăng xuất một thiết bị chỉ định thông qua `sessionId` và `userId`. Trong đoạn code dưới đây thực ra chỉ cần sessionId là đã có thể xóa được phiên rồi. Tuy nhiên để đảm bảo về an toàn bảo mật thì cần phải có thêm userId nữa để tránh bị lỗi IDOR mà user khác có thể gửi request chéo. Có nghĩa là chỉ tự đăng xuất các thiết bị trên chính tài khoản của mình. Điều này cũng đúng với việc đăng xuất trên nhiều thiết bị.

```javascript
  async logout(userId: string, sessionId: string) {
    const session: any = await this.repository
      .createQueryBuilder(''session'')
      .leftJoinAndSelect(''session.user'', ''user'')
      .select([''session'', ''user.id''])
      .where(''session.id = :sessionId'', { sessionId })
      .getOne();

    if (!session || session.user.id !== userId) {
      throw new ForbiddenException();
    }
    const keyCache = this.authService.getKeyCache(userId, session.deviceId);

    await this.cacheManager.set(keyCache, null);
    await this.repository.delete(sessionId);
    return {
      message: ''Logout success'',
      status: 200,
      sessionId,
    };
  }
```

## Cách làm trên đã vi phạm vào 1 điều kiện tuyệt vời của JWT
JWT sinh ra là để giúp cho việc xác thực không cần truy vấn database. Mỗi lần xác thực chỉ cần cầm token và secret key là xong. Tuy nhiên cách trên đã phải lưu secrey key vào database. Điều đó đồng nghĩa rằng tất cả các request mà có xác thực thì đều phải truy vấn database hay sao? Hmm, không phải như thế mà sẽ có hướng giải quyết khác bằng cách lưu secret key vào **Memory Cache** với TTL bằng thời gian sống của Token. Cách làm này giúp giảm được phần lớn query vào database chỉ để lấy token. Và nó cũng sẽ bị mất đi khi token hết hạn, khi user call refresh token để cấp lại 1 token mới với secret key mới thì hệ thống lại tạo 1  value cache tương ứng với key là `sk_${userId}_${deviceId}`

```rust
@Injectable()
export default class AuthService {
  constructor(
    @Inject(CACHE_MANAGER)
    private cacheManager: Cache,
    @InjectRepository(DeviceSessionEntity)
    private deviceSessionsRepository: Repository<DeviceSessionEntity>,
  ) {}

  async getSecretKey(request): Promise<string> {
    const headers = request.headers;
    const payload = JwtStrategy.decode(headers.authorization);
    const { deviceId, id, exp } = payload;

    const keyCache = this.getKeyCache(id, deviceId);
    const secretKeyFromCache: string = await this.cacheManager.get(keyCache);

    if (secretKeyFromCache) return secretKeyFromCache;

    const { secretKey } = await this.deviceSessionsRepository
      .createQueryBuilder(''deviceSessions'')
      .where(''deviceSessions.deviceId = :deviceId'', { deviceId })
      .andWhere(''deviceSessions.userId = :id'', { id })
      .getOne();

    await this.cacheManager.set(
      keyCache,
      secretKey,
      (exp - Math.floor(Date.now() / 1000)) * 1000,
    );
    return secretKey;
  }

  getKeyCache(userId, deviceId): string {
    return `sk_${userId}_${deviceId}`;
  }
}
```

## Kết luận
Trên đây là code minh họa về chức năng quản lý phiên đăng nhập trên nhiều thiết bị. Đó là code cơ bản nhất và trên thực tế thì có thể phức tạp hơn. Vì vậy code ví dụ chỉ mang tính tham khảo không nên sử dụng khi chưa được kiểm thử kỹ càng. Cảm ơn các bạn đã đọc bài của mình. Hẹn gặp lại các bạn trong các bài viết sau trong các bài viết về  Secure Coding sắp tới.', 'Ny0VGEp8JPA', '1', 'https://images.viblo.asia/31582ac8-be84-4cc1-9f02-1f65a3b54cc8.png', 'Trong bài viết trước, mình đã mô tả các lỗi bảo mật cơ bản phía Backend API qua các ví dụ cụ thể. Ở bài viết này, mình sẽ xây dựng một chức năng quản lý phiên đăng nhập trên nhiều thiết bị sử dụng JWT. Các hệ thống lớn như Google, Facebook... Một trong những điều kiện tiên quyết sống còn về bảo mật của một tài khoản phải có ít nhất những thứ sau đây. Đầu tiên là cảnh báo khi có thiết bị lạ đăng...', '2023-02-26T15:36:13.000000Z', '2023-02-27T04:22:08.000000Z'),
	('Cấu Trúc Dữ Liệu Và Giải Thuật - Graph Algorithms - Giới thiệu', 'Trong thế giới thực, nhiều vấn đề được biểu diễn dưới dạng các đối tượng và các kết nối giữa chúng.  Ví dụ: trong bản đồ đường bộ Việt Nam, chúng ta có thể quan tâm đến các câu hỏi như: “Cách nhanh nhất để đi từ Cần Thơ đến TPHCM là gì?” hoặc “Tuyến đường ngắn nhất đi từ Cần Thơ đến TPHCM?” Để trả lời những câu hỏi này, chúng tôi cần thông tin về các kết nối (tuyến đường) giữa các đối tượng (thành phố). Đồ thị (graph) là cấu trúc dữ liệu được sử dụng để giải quyết các loại vấn đề này.

## 1. Định nghĩa đồ thị
**Đồ thị** là một cặp (V,E) trong đó V là tập hợp các nút hay còn gọi là các đỉnh (vertices) và E là tập hợp các cạnh (edges) nối giữa hai đỉnh với nhau.

Môt số định nghĩa trong đồ thị:

* **Cạnh có hướng** (Directed edge): Đỉnh được sắp xếp theo thứ tự (u, v), trong đó đỉnh u là gốc và đỉnh v là đích. Ví dụ: giao thông đường một chiều

![](https://images.viblo.asia/c96a1412-a555-4765-ace7-1f0338ae7c8c.png)

* **Cạnh vô hướng** (Undirected edge): Đỉnh không được sắp xếp theo thứ tự (u, v). Ví dụ: tuyến đường sắt.

![](https://images.viblo.asia/c074d2bd-4aab-4cae-9776-9ac1edd2bbc8.png)

* **Đồ thị có hướng** (Directed graph): Tât cả các cạnh đều là cạnh có hướng. Ví dụ: tuyến đường mạng.

![](https://images.viblo.asia/6b071e65-fa54-43c6-9834-7de703d09e7d.png)

* **Đồ thị vô hướng** (Undirected graph): Tất cả các cạnh đều là cạnh vô hướng. Ví dụ: đường hàng không.

![](https://images.viblo.asia/97536ae7-715d-4237-936e-4f2b5d8915e1.png)

* **Bậc của một đỉnh** là số cạnh của đỉnh đó.
* **Đường đi trong đồ thị** là một dãy các đỉnh kề nhau mà không có đỉnh lặp lại.
* **Chu trình** là đường đi có đỉnh đầu và đỉnh cuối trùng nhau, không có đỉnh hoặc cạnh lặp lại.
* **Đồ thị liên thông** là đồ thị có đường đi từ mọi đỉnh đến mọi đỉnh khác.
* **Đồ thị tuần hoàn có hướng** là đồ thị có hướng nhưng không có chu trình.
* **Đồ thị có trọng số** là đồ thị mà trên mỗi cạnh được gán giá trị để biểu diễn khoảng cách hoặc chi phí.

## 2. Ứng dụng của đồ thị
* Biểu diễn mối quan hệ giữa các linh kiện trong mạch điện tử.
* Mạng máy tính: mạng cục bộ, internet, web.
* Mạng lưới giao thông: đường bộ, đường hàng không.
* Cơ sở dữ liệu: Để biểu diễn sơ đồ ER (mối quan hệ thực thể) trong cơ sở dữ liệu, để biểu thị sự phục thuộc của các bảng trong cơ sở dữ liệu.

## 3. Biểu diễn đồ thị

### Sử dụng ma trận liền kề
Trong phương pháp này, chúng ta sử dụng một ma trận có kích thước V x V. Các giá trị của ma trận là boolean. Giả sử ma trận là A. Giá trị A[u, v] được đặt thành 1 nếu có một cạnh từ đỉnh u đến đỉnh v và 0 nếu ngược lại.
![](https://images.viblo.asia/6b071e65-fa54-43c6-9834-7de703d09e7d.png)
Ma trận liền kề biểu thị cho đồ thị dưới dạng như sau:

![](https://images.viblo.asia/a8d65d2f-35ea-4712-96ea-8523d5449a88.PNG)
Cài đặt ma trận liền kề:

```java
class Graph {
    private boolean matrix[][];
    private int vertexCount;

    public Graph(int numVertex) {
        this.vertexCount = numVertex;
        matrix = new boolean[numVertex][numVertex];
    }

    public void addEdge(int u, int v) {
        if (u >= 0 && u < vertexCount && v >= 0 && v < vertexCount) {
            matrix[u][v] = true;
            matrix[v][u] = true;
        }
    }

    public void removeEdge(int u, int v) {
        if (u >= 0 && u < vertexCount && v >= 0 && v < vertexCount) {
            matrix[u][v] = false;
            matrix[v][u] = false;
        }
    }

    public boolean isEdge(int v, int u) {
        if (u >= 0 && u < vertexCount && v >= 0 && v < vertexCount) {
            return matrix[u][v];
        }
        return false;
    }
}
```


### Sử dụng danh sách liền kề

Trong cách biểu diễn này, đối với mỗi đỉnh v chúng ta sử dụng một danh sách liên kết và các nút trong danh sách liên kết đại diện cạnh kết nối giữa đỉnh v và các đỉnh khác. Tổng số danh sách liên kết bằng số đỉnh của đồ thị.

![](https://images.viblo.asia/a3a1dfbf-bd29-4e51-adec-11643b574453.png)

Xem xét ví dụ tương tự như ví dụ ma trận liền kề ở trên, biểu diễn danh sách liền kề có thể được đưa ra như hình trên. Vì đỉnh A có cạnh của B và D nên chúng ta đã thêm chúng vào danh sách liền kề của A. Tương tự với cách đỉnh khác.

```java
import java.util.ArrayList;

class Graph {
    static void addEdge(ArrayList<ArrayList<Integer>> adj, int s, int d) {
        adj.get(s).add(d);
        adj.get(d).add(s);
    }

    public static void main(String[] args) {
        int V = 5;
        ArrayList<ArrayList<Integer>> adj = new ArrayList<ArrayList<Integer>>(V);
        for (int i = 0; i < V; i++)
            adj.add(new ArrayList<Integer>());
        // Add edges
        addEdge(adj, 0, 1);
        addEdge(adj, 0, 2);
        addEdge(adj, 0, 3);
        addEdge(adj, 1, 2);

        printGraph(adj);
    }

    static void printGraph(ArrayList<ArrayList<Integer>> adj) {
        for (int i = 0; i < adj.size(); i++) {
            System.out.println("\nVertex " + i + ":");
            for (int j = 0; j < adj.get(i).size(); j++) {
                System.out.print(" -> " + adj.get(i).get(j));
            }
            System.out.println();
        }
    }
}
```

Nguồn:  Data Structures And Algorithms Made Easy In JAVA', '2oKLnNxgLQO', '2', 'https://images.viblo.asia/a3a1dfbf-bd29-4e51-adec-11643b574453.png', 'Trong thế giới thực, nhiều vấn đề được biểu diễn dưới dạng các đối tượng và các kết nối giữa chúng.  Ví dụ: trong bản đồ đường bộ Việt Nam, chúng ta có thể quan tâm đến các câu hỏi như: “Cách nhanh nhất để đi từ Cần Thơ đến TPHCM là gì?” hoặc “Tuyến đường ngắn nhất đi từ Cần Thơ đến TPHCM?” Để trả lời những câu hỏi này, chúng tôi cần thông tin về các kết nối (tuyến đường) giữa các đối tượng (th...', '2023-02-26T11:50:31.000000Z', '2023-02-27T04:14:07.000000Z'),
	('Nên học ngôn ngữ lập trình nào trong năm 2023 để dễ tìm kiếm việc làm, lương cao?', 'Có hơn 600 ngôn ngữ lập trình trên thế giới hiện nay. Mỗi ngôn ngữ đều mang 1 ý nghĩa và nhiệm vụ riêng của nó. Vì thế, bạn không cần phải học hết chúng mà mỗi người nên theo đuổi từ 3-4 ngôn ngữ lập trình nhất định. Tuy nhiên, có rất nhiều người mới thắc mắc nên học ngôn ngữ lập trình nào đầu tiên?

Dựa vào các số liệu MindX thu thập được từ các nguồn uy tín trong nước và quốc tế (Topdev, ITviec, DevJob Scanner, Glassdoor,..), bạn có thể tham khảo 5 ngôn ngữ lập trình nên học trong năm 2023 dưới đây.

![](https://images.viblo.asia/fdc04231-67db-4911-80b6-6371bccdf08c.jpeg)


## Nên học ngôn ngữ lập trình nào trong năm 2023?

Dựa theo tiêu chí dễ học với người mới và được tuyển dụng nhiều nhất hiện nay, javascript (JS), Python, Java, C# là top ngôn ngữ lập trình nên học đầu tiên.

### Javascript

Javascript có lẽ được đánh giá là ngôn ngữ lập trình dễ học nhất cho người mới, luôn xếp đầu trong danh sách câu trả lời khi được hỏi nên học ngôn ngữ lập trình nào.

Theo DevJob Scanner - Một trang web cung cấp việc làm IT đã tiến hành nghiên cứu hơn 12 triệu việc làm liên quan đến nhà phát triển phần mềm, trong thời gian từ tháng 10 năm 2021 đến tháng 12 năm 2022 và đưa ra được danh sách những ngôn ngữ lập trình được tuyển dụng nhiều nhất năm 2022.

Trong đó, JavaScript tiếp tục thống trị vị trí đầu. DevJobSanner tìm thấy 801.000 lời mời làm việc yêu cầu biết Javascript hoặc TypeScript, chiếm khoảng 31% công việc. Python chiếm 20% và Java chiếm 17.21%.

Sự phổ biến của Javascript đến từ 2 lý do chính: hầu hết các trình duyệt web đều sử dụng ngôn ngữ này và nó cũng là một trong những ngôn ngữ dễ học nhất dành cho người mới với nhiều cú pháp linh hoạt, thư viện framework lớn. Ngoài ra, lập trình viên cũng có thể sử dụng Javascript để lập trình web/app với vai trò Frontend, Backend và Full Stack Website. Javascript cũng là ngôn ngữ được trả lương cao nhất hiện nay.

Bên cạnh đó, sự xuất hiện của TypeScript (một siêu tập hợp JavaScript an toàn) cũng có thể giúp đạt được cột mốc quan trọng này. Mức độ phổ biến của TypeScript chỉ tăng lên trong những năm gần đây. Nhiều khung JavaScript mới được viết hoàn toàn bằng TypeScript, như Angular hoặc NestJS.

![](https://images.viblo.asia/94a50b6e-e2f2-412f-83c6-bc60190f7a98.png)


### Python

Cũng theo bảng xếp hạng của DevJob Scanner về danh sách những ngôn ngữ lập trình được tuyển dụng nhiều nhất năm 2022 trên toàn thế giới, Python đứng ở vị trí thứ 2 với 515.428 job (trong tổng số 2 triệu job), chiếm 20%. Tại Việt Nam, Python cũng đứng top 3 công việc được tuyển dụng nhiều nhất với 48,50%, top 6 công nghệ được trả lương cao nhất, khoảng 1.389$ cho lập trình viên 3 năm kinh nghiệm (Theo Topdev - Vietnam IT market report 2022).

Python dễ học và dễ hiểu đối với người mới, cú pháp rõ ràng và ít phức tạp hơn các ngôn ngữ lập trình khác. Đây cũng là ngôn ngữ được các “ông lớn” trong ngành công nghệ ưu ái sử dụng như Amazon, Facebook, Google, Dropbox.

Python được sử dụng rộng rãi trong nhiều lĩnh vực, phát triển web nhanh với Django và Flask; Khoa học dữ liệu (Data Science); Học máy (Machine Learning). Nó còn có khả năng tích hợp với các ngôn ngữ khác như C/C++, Java, Javascript giúp đơn giản hoá việc lập trình các ứng dụng phức tạp.

### Java

Java xếp hạng 3 trong danh sách top công nghệ được tuyển dụng nhiều nhất của DevJob với 443.508 job (trong tổng số 2 triệu job), chiếm 17.21%. Tại Việt Nam, Java đứng thứ 2 chỉ sau Javascript về mức độ tuyển dụng phổ biến nhất, chiếm 49.4% (Theo Topdev - Vietnam IT market report 2022).

Java cũng thuộc top danh sách trả lời khi được hỏi nên học ngôn ngữ lập trình nào năm 2023. Công nghệ này được sử dụng rộng rãi trong nhiều lĩnh vực, từ phát triển web, mobile app cho đến các hệ thống điều khiển và máy tính nhúng. Đây là ngôn ngữ lập trình đa nền tảng, có thể chạy trên nhiều hệ điều hành khác nhau như Windows, Linux và macOS.

Cú pháp của Java rất đơn giản và dễ hiểu, vì vậy người học có thể nhanh chóng làm quen với nó.

### C#

C# là một ngôn ngữ lập trình đa năng, hiện đại, được biết đến là phiên bản hiện đại hơn, linh hoạt hơn của ngôn ngữ gốc C. C# đứng thứ 4 trong danh sách công nghệ được tuyển dụng nhiều nhất trên toàn thế giới của DevJob, chiếm 11,83%. Tại Việt Nam, mức độ tuyển dụng phổ biến của C# là 43,3% (Theo Topdev - Vietnam IT market report 2022).

C# có cấu trúc đơn giản, ít phức tạp hơn và được sử dụng rộng rãi trong nhiều lĩnh vực, từ phát triển ứng dụng máy tính, trò chơi, thiết bị di động, hệ thống điều khiển đến các hệ thống nhúng và truyền thông.

Hi vọng các thông tin trên đây sẽ giúp bạn tìm được câu trả lời cho câu hỏi “**nên học ngôn ngữ lập trình nào năm 2023**”.

Nếu muốn bắt đầu nghề lập trình với Javascript - Công nghệ phổ biến và được tuyển dụng nhiều nhất hiện nay, bạn có thể tham khảo KHÓA HỌC LẬP TRÌNH tại MindX với lộ trình đào tạo từ cơ bản đến chuyên sâu trong 12 tháng, CÓ CAM KẾT VIỆC LÀM.', '0gdJzQ7e4z5', '3', '', 'Có hơn 600 ngôn ngữ lập trình trên thế giới hiện nay. Mỗi ngôn ngữ đều mang 1 ý nghĩa và nhiệm vụ riêng của nó. Vì thế, bạn không cần phải học hết chúng mà mỗi người nên theo đuổi từ 3-4 ngôn ngữ lập trình nhất định. Tuy nhiên, có rất nhiều người mới thắc mắc nên học ngôn ngữ lập trình nào đầu tiên?

Dựa vào các số liệu MindX thu thập được từ các nguồn uy tín trong nước và quốc tế (Topdev, ITvi...', '2023-02-26T11:45:16.000000Z', '2023-02-27T04:14:03.000000Z'),
	('[Declarative Programming + Elm] Bài 18 - Simplicity SPA Elm', 'Đây là `mini project` thứ ba trên hành trình tự học code mà mình chia sẻ tại nền tảng blog Viblo ở đây và mình hy vọng rằng vẫn còn nhiều người quan tâm tới Sub-Series này. Lý do là mình đã phải bỏ quãng khá lâu không thể đăng bài viết theo kiểu vừa code vừa chia sẻ kiến thức, bởi các công cụ được `Elm` cung cấp mặc định vẫn có phần rất mới mẻ đối với mình. Việc vừa code một `mini project` và vừa đăng tải các bài viết chia sẻ song song với tiến trình cập nhật vốn kiến thức cá nhân khiến mình cảm thấy có phần hơi cập dập. Bởi rất có thể mình sẽ phải liên tiếp quay trở lại chỉnh sửa các bài viết đã qua khi chạm tới một kĩ thuật xử lý code mới mà mình mới Google được.

Tuy nhiên thì sau khi code xong một trang blog đơn giản bằng `Elm` và đăng tải lên `GitHub Page` thì mình nhận ra là để xây dựng một ứng dụng trang đơn kiểu này cũng không hẳn yêu cầu một kiến trúc code phức tạp. Thực tế thì tất cả những gì mình đã cần sử dụng không hề nằm ngoài so với các kiến thức căn bản về ngôn ngữ và `framework Elm` đã được nhắc đến trong các bài viết trước đó.

Nếu như bạn đã đồng hành cùng Series Tự Học Lập Trình đầu tiên cho tới hết bài viết gần nhất về `Elm` trước khi mình bỏ quãng thì rất có thể hiện tại bạn đã viết xong một vài SPA xịn bằng `Elm` rồi. Tuy nhiên, mình vẫn muốn đăng một vài bài viết về tiến trình xây dựng trang blog cá nhân đơn giản mà mình đã thực hiện với `Elm` và `GitHub Page` để dành cho việc tự đọc tham khảo lại sau này nếu bản thân cần tới; Lý do là bởi sau Sub-Series này thì hành trình tự học của mình vẫn sẽ tiếp tục với các ngôn ngữ khác nữa và sẽ phải tạm biệt `Elm` một thời gian không rõ bao lâu.

`Blog:` [`https://thinhtranhnvn.github.io`](https://thinhtranhnvn.github.io)

`Source Code:` [`GitHub.com -> thinhtranhnvn.github.io`](https://github.com/thinhtranhnvn/thinhtranhnvn.github.io)

## Data Service

Ở đây mình trông chờ hoàn toàn vào cơ chế đáp ứng yêu cầu dữ liệu đơn giản của `GitHub` khi chúng ta nhấn vào nút xem nội dung tệp gốc `raw` trên giao diện của `GitHub`. Ví dụ:

[`https://raw.githubusercontent.com/thinhtranhnvn/thinhtranhnvn.github.io/main/data/topic-list.json`](https://raw.githubusercontent.com/thinhtranhnvn/thinhtranhnvn.github.io/main/data/topic-list.json)

Trong đường dẫn này thì bắt đầu từ sau tên nhánh chính `branch: main` dữ liệu trong một thư viện `repository` bất kỳ trên `GitHub` sẽ có thể được truy xuất theo đường dẫn có cấu trúc thư mục tương tự như lưu trữ trên máy tính. Từ thư mục gốc `/` chúng ta đang trỏ tới thư mục `data` rồi sau đó chọn tệp `topic-list.json`. Và như vậy chúng ta sẽ có thể cứ thế tạo ra các thư mục lưu trữ dữ liệu theo cấu trúc phù hợp với nhu cầu sắp xếp các bài viết blog.

Trang blog mà mình xây dựng như bạn thấy trong liên kết ở trên có các bài viết được nhóm theo hai cấp độ: đầu tiên là chủ đề `Topic`, và sau đó là các `Series` thuộc mỗi chủ dề. Như vậy để gửi yêu cầu truy vấn tới một tệp `.txt` chứa nội dung của một bài viết thì dạng đường dẫn mà mình sử dụng có dạng thế này:

`Post:` `/data/topic-id/series-id/post-slug.txt`

Và liên kết trỏ tới bài viết có dạng `domain + path` bỏ đi tên thư mục `data` và phần định dạng của tệp cần truy vấn.

`Url:` `https://thinhtranhnvn.github.io/topic-id/series-id/post-slug`

Danh sách các bài viết và `metadata` của tất cả đều được nhóm trong một tệp khai báo `post-list.json` ở cùng cấp thư mục với các tệp nội dung bài, tức là một thư mục tượng trưng cho một `Series` sẽ có một tệp `post-list.json` và các tệp nội dung bài viết `.txt`.

`Post-List:` `/data/topic-id/series-id/post-list.json`

Và liên kết trỏ tới trang xem đề mục của `Series` có dạng là:

`Url:` `https://thinhtranhnvn.github.io/topic-id/series-id`

Tương tự thì mỗi thư mục tương trưng cho một `Topic` sẽ có một tệp `series-list.json` chứa `metadata` của các `Series` và các thư mục tượng trưng cho các `Series` thuộc `Topic` đó. Tuy nhiên thì thiết kế blog này luôn luôn có một thanh điều hướng phụ để hiện danh sách các `Series` thuộc `Topic` đang xem, vì vậy nên khi người dùng nhấn vào tên của một `Topic` thì mình chọn hiển thị một bài viết tổng quan `Overview` để giới thiệu khái quát nội dung. Tệp lưu bài viết `Overview` này được đặt riêng biệt ngay trong cấp đầu tiên của thư mục `Topic` đó và bên cạnh tệp `series-list.json`.

`Series-List:` `/data/topic-id/series-list.json`

`Topic-Overview:` `/data/topic-id/overview.txt`

Và liên kết trỏ tới trang giới thiệu tổng quan của mỗi `Topic` sẽ có dạng như sau:

`Url:` `https://thinhtranhnvn.github.io/topic-id`

Riêng liên kết trỏ tới trang chủ, được ngầm định là trỏ tới một `Topic` mặc định có tên là `Origin`, và tương đương với liên kết trỏ tới trang `Topic` ở trên với `topic-id` là `origin`.

`Url:` [`https://thinhtranhnvn.github.io/origin`](https://thinhtranhnvn.github.io/origin)

## Routing

Với định hướng thiết kế đường dẫn và hiển thị nội dung như trên thì chúng ta có các tuyến yêu cầu được định nghĩa như sau:

```/src/Route.elm
module Route exposing (..)

import Url exposing (Url)
import Url.Parser as UrlParser exposing (Parser, parse, oneOf, string, top, (</>))


-- Route - - - - - - - - - - - - - - - - - - - - - - - - - - -


type Route = HomePage
           | TopicPage  (TopicId)
           | SeriesPage (TopicId) (SeriesId)
           | PostPage   (TopicId) (SeriesId) (PostSlug)


type alias TopicId  = String
type alias SeriesId = String
type alias PostSlug = String


-- parser - - - - - - - - - - - - - - - - - - - - - - - - - - -


parser : Parser (Route -> a) a
parser =
   oneOf [ UrlParser.map (HomePage)   (top)
         , UrlParser.map (TopicPage)  (string)
         , UrlParser.map (SeriesPage) (string </> string)
         , UrlParser.map (PostPage)   (string </> string </> string)
         ]


-- Url Example:
-- https://thinhtranhnvn.github.io/origin/heart-sutra/00-the-first-preface
-- topicId  = origin
-- seriesId = heart-sutra
-- postSlug = 00-the-first-preface
```

## Code Management

Việc tổ chức sắp xếp code ở đây được thực hiện thuận theo tiến trình code của mình và được chia làm hai giai đoạn là:

- `mockup` - tạo ra các tệp `Layout.html` để mô phỏng bố cục các trang tĩnh và viết code CSS.
- `src` - viết code xử lý logic bằng `Elm` và `JavaScript` để triển khai các bố cục `Layout` dựa theo các tuyến yêu cầu ở trên.

Và vì vậy nên tại thư mục gốc của `project` bạn có thể thấy hai thư mục với tên như trên được đặt bên cạnh các tệp thực thi `index.html` và `404.html`. Các tệp thực thi này là kết quả sau khi biên dịch code `Elm` và `copy/paste` một số nội dung ở thẻ `head` của tệp `blank.html` để gắn kèm code `CSS` trong thư mục `mockup`. Khi người dùng trỏ tới tên miền của blog thì `GitHub Page` gửi tới trình duyệt một trong hai tệp thực thi trên có chứa toàn bộ code xử lý logic của ứng dụng `SPA` đã xây dựng.

Đây là cấu trúc thư mục `/mockup`:

```/mockup.folder
/mockup
├── Element
│   ├── Base
│   │   └── style.css
│   ├── Indexer
│   │   ├── ...
│   │   └── style.css
│   ├── Navigator
│   │   ├── ..
│   │   └── style.css
│   ├── Overview
│   │   ├── ..
│   │   └── style.css
│   └── Reader
│       ├── ..
│       └── style.css
├── Layout
│   ├── Home.html
│   └── Series.html
|
├── master.css
├── jquery.min.js
└── main.js
```

Ở đây tệp code `CSS` được viết tản ra các tệp thành phần và `@import` tổ hợp lại tại các tệp `/mockup/Element/.../style.css`. Sau đó các tệp này tiếp tục được `@import` tổ hợp lại tại một tệp `/mockup/master.css` duy nhất để nhúng vào các tệp `Layout.html` và các tệp thực thi sau khi biên dịch code `Elm`. Mình có sử dụng thêm một chút `jQuery` trong code ở phần `/src`, còn tệp `/mockup/main.js` ở đây thì chỉ là nháp tạm trong giai đoạn làm `mockup`.

Và đây là cấu trúc thư mục `/src`:

```/src.folder
/src
├── App.elm
├── Context.elm
├── Data
│   ├── Post.elm
│   ├── Series.elm
│   └── Topic.elm
├── Element
│   ├── Indexer.elm
│   ├── Metadata.elm
│   ├── metadata.js
│   ├── Navigator.elm
│   ├── navigator.js
│   ├── Overview.elm
│   └── Reader.elm
├── Extension
│   └── Http
│       └── Error.elm
└── Route.elm
```

Tệp đại diện với hàm `main` để bắt đầu chương trình là `App.elm` mô phỏng ứng dụng ở cấp độ tổng quan và điều hành việc hiển thị các `Element` phù hợp tùy vào `Route` mà người dùng yêu cầu. Và đây là các đoạn code ngắn về `App.Model`, `Msg`, `init`, `view`, và `update`:

```/src/App.elm
type alias Model =
   { url : Url
   , key : Key
     --
   , route : Route
   , context : Context.Model
     --
   , metadata  : Metadata.Model
   , navigator : Navigator.Model
   , overview  : Overview.Model
   , reader    : Reader.Model
   , indexer   : Indexer.Model
   }
```

Ở đây chúng ta có các `Element` với các chức năng cụ thể là:

- `Context` - Gửi yêu cầu truy vấn dữ liệu để mô phỏng bối cảnh hoạt động hiện thời của toàn bộ `App` dựa trên tuyến yêu cầu `Route` mà người dùng chọn.
- Các thành phần sử dụng dữ liệu từ `Context.Model` và định tuyến `Route` để tạo ra code `HTML` hiển thị nội dung:
    - `Metadata` - cập nhật các thẻ `<meta />` trong `<head>`.
    - `Navigator` - hiển thị thanh điều hướng chính với danh sách liên kết trỏ tới các `Topic`.
    - `Overview` - hiển thị thanh điều hướng phụ với danh sách các liên kết trỏ tới các `Series` bài viết thuộc `Topic` đang xem.
    - `Reader` - hiển thị nội dung bài viết nếu người dùng đang xem trang đại diện của một `Topic` hoặc một trang bài viết cụ thể.
    - `Indexer` - hiển thị khối nội dung liệt kê danh sách liên kết trỏ tới các bài viết của `Series` hiện tại nếu người dùng đang chọn xem trang đại diện của một `Series`.

```/src/App.elm
type Msg = GotUrlRequest (UrlRequest)
         | UrlChanged (Url)
           --
         | CtxMsg (Context.Msg)
           --
         | MtdMsg (Metadata.Msg)
         | NavMsg (Navigator.Msg)
         | OvrMsg (Overview.Msg)
         | RdrMsg (Reader.Msg)
         | IdxMsg (Indexer.Msg)
```

Khi sử dụng `view` của các `module Element` để tổ hợp tại `App.view` thì chúng ta sẽ cần thực hiện thao tác `Html.map` để chuyển đổi các `node` thuộc các kiểu `Html Metadata.Msg`, `Html Navigator.Msg`, v.v.. .về kiểu `Html App.Msg`. Vì vậy nên trong định nghĩa của `App.Msg` sẽ cần có các kiểu vỏ bọc `Wrapper` để bọc lấy các tin nhắn `Msg` tạo ra từ các `module Element`.

```/src/App.elm
init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
   let
      route = Route.fromUrl (url)
      ( ctxModel, ctxCmd ) = Context.init (Url.toString url)
      --
      ( mtdModel, _ ) = Metadata.init  (ctxModel)
      ( navModel, _ ) = Navigator.init (ctxModel)
      ( ovrModel, _ ) = Overview.init  (ctxModel)
      ( rdrModel, _ ) = Reader.init    (ctxModel)
      ( idxModel, _ ) = Indexer.init   (ctxModel)
      --
      model =
         { url = url
         , key = key
           --
         , route = route
         , context = ctxModel
           --
         , metadata  = mtdModel
         , navigator = navModel
         , overview  = ovrModel
         , reader    = rdrModel
         , indexer   = idxModel
         }
      cmd = Cmd.map (CtxMsg) (ctxCmd)
   --
   in
      ( model, cmd )
```

Ở trình `App.view` thì dựa vào `Route` cụ thể, chúng ta sẽ chỉ hiển thị các `Element` phù hợp. Và với thiết kế như đã nói trên thì `Metadata`, và hai thanh điều hướng `Navigator + Overview` sẽ luôn có mặt. `Reader` thì sẽ xuất hiện ở các trang đại diện `Topic` bao gồm cả trang chủ, và các trang bài viết cụ thể. Và như vậy chỉ có duy nhất trang đại diện cho `Series` sẽ có phần `Reader` được thay bằng `Indexer` để hiện danh sách liên kết trỏ tới các bài viết thuộc `Series` đó.

```/src/App.elm
view : Model -> Document Msg
view model =
   let
      mtdHtml = Metadata.view  (model.metadata)
      navHtml = Navigator.view (model.navigator)
      ovrHtml = Overview.view  (model.overview)
      rdrHtml = Reader.view    (model.reader)
      idxHtml = Indexer.view   (model.indexer)
      --
      pageHtml = case (model.route) of
         --
         SeriesPage _ _ ->
            [ Html.map (MtdMsg) (mtdHtml)
            , Html.map (NavMsg) (navHtml)
            , Html.map (OvrMsg) (ovrHtml)
            , Html.map (IdxMsg) (idxHtml)
            ]
         --
         _ -> [ Html.map (MtdMsg) (mtdHtml)
              , Html.map (NavMsg) (navHtml)
              , Html.map (OvrMsg) (ovrHtml)
              , Html.map (RdrMsg) (rdrHtml)
              ]
   --
   in
      { title = "Semi Dev_ ''s Blog"
      , body = pageHtml
      }
```

Trình cập nhật `App.update` cũng sẽ ủy thác việc xử lý các `Element.Msg` tới cho các trình cập nhật `Element.update` khi người dùng chọn xem một liên kết mới và bối cảnh `Context` có sự thay đổi. Vì vậy nên các `Element` sẽ phải cung cấp ra các kiểu `Msg` để `App` điều hành nếu cần thiết.

Ở đây ngoài các tin nhắn `Context.Msg` thì chúng ta chỉ có duy nhất thao tác đóng/mở và thu gọn thanh điều hướng chính `Navigator` cần xử lý; Và vì vậy nên hầu hết các tin nhắn thuộc các kiểu `Element.Msg` đều không có ý nghĩa đối với trình điều khiển chính.

```/src/App.elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case (msg) of
   --
   GotUrlRequest req -> ...
   --
   UrlChanged newUrl -> ...
   --
   CtxMsg ctxMsg -> ...
   --
   NavMsg navMsg -> ...
   --
   _ -> ( model, Cmd.none )
```

Khi người dùng click vào một liên kết thì trình điều khiển sẽ nhận được một `UrlRequest` và các trường hợp xử lý căn bản vẫn là:

- `Browser.External` - liên kết trỏ tới trang web khác tên miền ở bên ngoài. Lúc này chúng ta chỉ cần gửi lệnh để trình duyệt tải trang web đó.
- `Browser.Internal` - liên kết trỏ tới một trang đơn khác cùng tên miền. Lúc này chúng ta cần thực hiện hai thao tác đó là:
    - Đảm bảo rằng thanh điều hướng chính sẽ được thu hẹp lại nếu như đang ở trạng thái mở rộng. Đây chính là vị trí mà chúng ta sẽ sử dụng tin nhắn mà `Navigator` thiết kế để mở cho code bên ngoài điều hành. Thao tác xử lý cần thực hiện là bọc tin nhắn `Navigator.Collapse` trong một `appMsg` và gửi đệ quy lại vào chính hàm `App.update`.
    - Sau đó gửi lệnh để trình duyệt thay đổi `Url` hiện hành bằng cách đẩy `Url` mới vào vị trí đầu tiên của danh sách `Browser.History`.

```
   --
   GotUrlRequest req -> case (req) of
      --
      Browser.External href ->
         let
            cmd = Browser.load (href)
         in
            ( model, cmd )
      --
      Browser.Internal newUrl ->
         let
            appMsg = NavMsg (Navigator.CollapseFolder)
            ( updatedModel, _ ) = update (appMsg) (model)
            --
            urlStr = Url.toString (newUrl)
            cmd = Browser.pushUrl (model.key) (urlStr)
         in
            ( updatedModel, cmd )
```

Sau đó trình `App.update` sẽ tiếp tục nhận được hai tin nhắn là `NavMsg (Navigator.CollapseFolder)` được gửi đệ quy trực tiếp từ chính `App.update`, và `UrlChanged` được gửi từ trình điều khiển `Program` sau khi `Browser.History` đã được cập nhật xong. Lúc này chúng ta có tin nhắn yêu cầu thu hẹp thanh điều hướng chính `Navigator` sẽ được ủy thác lại cho `Navigator.update` xử lý:

```/src/App.elm
   --
   NavMsg navMsg ->
      let
         ( navModel, _ ) = Navigator.update (navMsg) (model.navigator)
         --
         updatedAppModel = { model | navigator = navModel }
      in
         ( updatedAppModel, Cmd.none )
```

Còn tin nhắn `UrlChanged` sẽ được xử lý ở cấp độ điều hành của `App` là cập nhật `Context`, sau đó sử dụng `Context` mới để cập nhật các `Element` giao diện. Tuy nhiên, thao tác cập nhật `Context` thường sẽ phải gửi yêu cầu truy vấn dữ liệu và chúng ta không biết rằng khi nào thì trình duyệt web mới thực sự nhận được dữ liệu mới và bản ghi `Context.Model` mới được tạo ra. Vì vậy nên ở đây chúng ta chỉ gọi `Context.update` với `Url` mới và chờ đợi để bắt lại các tin nhắn `Context.Msg` tại cấp độ điều hành của `App.update` để xử lý tiếp.

```/src/App.elm
   --
   UrlChanged newUrl ->
      let
         newRoute = Route.fromUrl (newUrl)
         --
         newUrlStr = Url.toString (newUrl)
         ( ctxModel, ctxCmd ) = Context.update (Context.UrlChanged newUrlStr) (model.context)
         --
         updatedModel = { model | url = newUrl
                          --
                        , route = newRoute
                        , context = ctxModel
                        }
         cmd = Cmd.map (CtxMsg) (ctxCmd)
      --
      in
         ( updatedModel, cmd )
```

Trình `update` của `Context` có thể gửi đi nhiều yêu cầu truy vấn dữ liệu bởi vì chúng ta đang có các thành phần sử dụng tới danh sách các chủ đề `Topic`, danh sách các `Series`, và một bản nội dung bài viết mã `markdown` hoặc danh sách các bài viết `Post`. Các yêu cầu này sẽ được phản hồi vào những thời điểm rời rạc vì vậy nên chúng ta không cần phải quan tâm tới việc gom dữ liệu phản hồi mà thay vào đó thì cứ bất kỳ khi nào `App.update` thấy có `CtxMsg` được gửi tới là sẽ sử dụng ngay bản ghi `Context.Model` mới để cập nhật các `Element` đồ họa.

```/src/App.elm
   --
   CtxMsg ctxMsg ->
      let
         ( ctxModel, ctxCmd ) = Context.update (ctxMsg) (model.context)
         --
         ( mtdModel, _ ) = Metadata.update  (Metadata.ContextChanged  ctxModel) (model.metadata)
         ( navModel, _ ) = Navigator.update (Navigator.ContextChanged ctxModel) (model.navigator)
         ( ovrModel, _ ) = Overview.update  (Overview.ContextChanged  ctxModel) (model.overview)
         ( rdrModel, _ ) = Reader.update    (Reader.ContextChanged    ctxModel) (model.reader)
         ( idxModel, _ ) = Indexer.update   (Indexer.ContextChanged   ctxModel) (model.indexer)
         --
         updatedAppModel = { model | context = ctxModel
                             --
                           , metadata  = mtdModel
                           , navigator = navModel
                           , overview  = ovrModel
                           , reader    = rdrModel
                           , indexer   = idxModel
                           }
         cmd = Cmd.map (CtxMsg) (ctxCmd)
      in
         ( updatedAppModel, cmd )
```

Và đó là logic điều hành một `SPA` đơn giản được hỗ trợ bởi kiến trúc `Elm Architecture`. Những chi tiết khác về việc viết code triển khai thực sự không có gì đáng kể và đều tương đương với các ví dụ đơn giản mà chúng ta đã thực hiện trong những bài viết học lý thuyết về ngôn ngữ và kiến trúc của `Elm`.

## Functional Programming + Haskell

Trong khuôn khổ giới hạn của một `mini project` nghiệm thu kiến thức của Sub-Series giới thiệu mô hình lập trình `Declarative Programming`, có lẽ điều đáng kể nhất mà mình học được đó là kiến trúc phần mềm mà `Elm` cung cấp sẵn. Và bởi vì đây đã là `mini project` thứ ba trong hành trình tự học code mà mình chia sẻ ở đây, nên việc viết lại code triển khai chi tiết trong các bài viết diễn giải lại `source code` trong liên kết ở đầu bài viết có lẽ không hẳn cần thiết nếu như bạn đã đồng hành cùng từ Series Tự Học Lập Trình Web đầu tiên.

Tại thời điểm này thì chúng ta vẫn chưa có các Sub-Series dành cho hai mô hình lập trình `Functional` và `Object-Oriented`, mặc dù đã điểm danh sơ lược qua một số yếu tố liên quan khi học `Ada` và `Elm`; Vì vậy nên ở đây mình sẽ tiếp tục đặt một điểm nối tiếp tới Sub-Series mới `Functional Programming + Haskell`, và chúng ta sẽ để dành điểm chuyển tiếp này cho đến khi thực hiện xong Sub-Series `Object-Oriented + Java` đã dự định từ khi kết thúc Sub-Series học `Ada` trước đó.

(chưa đăng tải) [[Functional Programming + Haskell] - ...](#)', 'r1QLxQ92VAw', '4', '', 'Đây là mini project thứ ba trên hành trình tự học code mà mình chia sẻ tại nền tảng blog Viblo ở đây và mình hy vọng rằng vẫn còn nhiều người quan tâm tới Sub-Series này. Lý do là mình đã phải bỏ quãng khá lâu không thể đăng bài viết theo kiểu vừa code vừa chia sẻ kiến thức, bởi các công cụ được Elm cung cấp mặc định vẫn có phần rất mới mẻ đối với mình. Việc vừa code một mini project và vừa đăn...', '2023-02-26T09:05:26.000000Z', '2023-02-27T01:57:03.000000Z'),
	('[Research Paper GPT-3] Large Language Models are Zero-Shot Reasoners', 'Bạn có thể download Research Paper ở cuối bài viết.

### Large Language Models are Zero-Shot Reasoners ?
"Large Language Models are Zero-Shot Reasoners" là một khái niệm chỉ tính năng mới của các mô hình ngôn ngữ lớn như GPT-3, cho phép chúng có khả năng thực hiện những tác vụ mà chúng không được huấn luyện trực tiếp để thực hiện.

Trong trường hợp của Zero-Shot Reasoning, mô hình ngôn ngữ có thể giải quyết các tác vụ mới mà không cần huấn luyện trước về cách thực hiện các tác vụ đó. Thay vào đó, mô hình được cung cấp với thông tin về tác vụ và một số thông tin khác, ví dụ như một tập từ vựng hoặc một số ví dụ mẫu, và từ đó mô hình sẽ tìm cách giải quyết tác vụ mới dựa trên kiến thức đã học được từ việc huấn luyện trên các tác vụ khác.

Với tính năng này, mô hình ngôn ngữ lớn có thể được sử dụng để thực hiện nhiều tác vụ khác nhau mà không cần phải huấn luyện trực tiếp cho từng tác vụ riêng lẻ. Tuy nhiên, mức độ chính xác của các kết quả thực hiện tác vụ mới sẽ phụ thuộc vào số lượng thông tin được cung cấp cho mô hình và độ tương đồng giữa tác vụ mới và các tác vụ mà mô hình đã được huấn luyện.

Hãy nhìn vào ví dụ sau:
![](https://images.viblo.asia/fcb745d5-d1da-47f0-80dd-046f37488664.png)


Few-shot và Few-shot-CoT đều là các phương pháp học máy được sử dụng để giải quyết các vấn đề liên quan đến việc huấn luyện mô hình trên số lượng dữ liệu nhỏ.

Few-shot là một phương pháp học máy cho phép mô hình học từ một lượng nhỏ các mẫu dữ liệu huấn luyện, thường chỉ từ vài đến vài chục mẫu. Thay vì huấn luyện trên một lượng lớn dữ liệu, mô hình được huấn luyện để có khả năng tổng quát hóa trên nhiều tác vụ khác nhau. Few-shot giúp cho việc xây dựng và huấn luyện các mô hình học máy trở nên dễ dàng hơn đối với các tác vụ có số lượng dữ liệu huấn luyện nhỏ.

Few-shot-CoT (Few-shot Co-training) là một phương pháp học máy dựa trên ý tưởng của Few-shot, nhưng nó sử dụng kỹ thuật đồng huấn luyện để cải thiện độ chính xác của mô hình. Kỹ thuật đồng huấn luyện cho phép mô hình học từ nhiều nguồn dữ liệu khác nhau, tạo ra một mô hình tổng quát hơn và có khả năng tự động cải thiện khi có thêm dữ liệu mới. Few-shot-CoT đặc biệt phù hợp cho các tác vụ cần độ chính xác cao và số lượng dữ liệu huấn luyện nhỏ.

Câu promt để bạn có thể thực thi trong ChatGPT: ": Let’s think step by step" hoặc "Hãy suy nghĩ từng bước một"
![](https://images.viblo.asia/9f8c886a-f2b4-4c72-ae07-43d0b1f711bc.png)


![](https://images.viblo.asia/4ccde55b-3d6d-4192-8b69-91c66100b241.png)


Điều này có nghĩa trong tương lai GPT-4 ... (Hiện tại Bing đang áp dụng) có khả năng suy luận ... theo mô hình ngôn ngữ lớn LMM Zero-Shot Reasoners.

Đây là một trong những số cách viết promt 1 cách hiệu quả. Hãy chia sẽ các kết quả mà bạn ứng dụng câu promt này, để chúng ta có bài thảo luận thú vị:

> Let’s think step by step" hoặc "Hãy suy nghĩ từng bước một"


Research Paper: [https://arxiv.org/pdf/2205.11916.pdf](https://arxiv.org/pdf/2205.11916.pdf)

Community Global ChatGPT Topic: [https://community.openai.com/t/zero-shot-perfection-with-prompt-let-s-think-step-by-step/18609](https://community.openai.com/t/zero-shot-perfection-with-prompt-let-s-think-step-by-step/18609)

Cộng đồng ChatGPT Vietnam Topic: [https://congdongchatgpt.com/d/33-research-paper-gpt-3-large-language-models-are-zero-shot-reasoners](https://congdongchatgpt.com/d/33-research-paper-gpt-3-large-language-models-are-zero-shot-reasoners)', 'obA4663X4Kv', '5', 'https://images.viblo.asia/fcb745d5-d1da-47f0-80dd-046f37488664.png', 'Bạn có thể download Research Paper ở cuối bài viết.

Large Language Models are Zero-Shot Reasoners ?
"Large Language Models are Zero-Shot Reasoners" là một khái niệm chỉ tính năng mới của các mô hình ngôn ngữ lớn như GPT-3, cho phép chúng có khả năng thực hiện những tác vụ mà chúng không được huấn luyện trực tiếp để thực hiện.

Trong trường hợp của Zero-Shot Reasoning, mô hình ngôn ngữ có thể g...', '2023-02-26T05:50:52.000000Z', '2023-02-27T04:16:03.000000Z'),
	('[Go] Goroutine Prevent Leak', 'Goroutine Leak, và debug resource: https://viblo.asia/p/golang-leaks-in-goroutine-and-debug-resource-3kY4g5q0LAe
## prevent-leak
- Trong ví dụ trước đã nói về leak cũng như debug resource bằng `pprof`
- Thì bài viết này hỗ trợ làm sao để không bị leak khi sử dụng `goroutine` trong `golang`

### Ví dụ 1;
- Để thành công trong việc giảm thiểu leak trong goroutine thì dùng `channel` giữa các `goroutine cha và con`. Bởi theo quy định, signal luôn luôn chỉ đọc, và `goroutine` cha pass `channel` đến goroutine con. Khi `channel` close, nó sẽ close cả goroutine con.
- Code example:
```go
func Preven() {
	doWork := func(done <-chan interface{}, strings <-chan string) <-chan interface{} { // (1)
		terminated := make(chan interface{})
		go func() {
			defer fmt.Println("doWork exited.")
			defer close(terminated)
			for {
				select {
				case s := <-strings:
					// Do something interesting
					fmt.Println(s)
				case <-done: // (2)
					fmt.Println("done in work")
					return
				}
			}
		}()
		return terminated
	}
	done := make(chan interface{})
	terminated := doWork(done, nil)
	go func() { // (3)
		// Cancel the operation after 1 second.
		time.Sleep(1 * time.Second)
		fmt.Println("Canceling doWork goroutine...")
		close(done)
	}()
	<-terminated // (4)
	fmt.Println("Done.")
}
```
- Ghi chú:
  - (1) `doWork()` là một function bình thường, khai báo trong func `Prevent()`. Nhận vào 2 parameter và return 1 parameter
  - (2) Trong line này, dùng `for-select` pattern, trong case `<-done` là kiểm tra `channel` có được báo tín hiệu chưa, nếu có thì sẽ return `goroutine`
  - (3) Tạo một `goroutine` khác, mục đích để cancel `doWork` sau thời gian 1 giây
  - (4) Để merge 2 goroutine lại với nhau, tiếp tục process những phần khác.
- Kêt quả:
```
Canceling doWork goroutine...
done in work
doWork exited.
Done.
```
- Như kết quả, mặc dù trong function `doWork()` truyền `string=nil` nhưng goroutine vẫn có thể exit, và clean-up resource.
- Để có thể join 2 `goroutine` lại với nhau, tạo thêm 1 `goroutine` thứ 3, mục đích để `cancel` func `doWork()` sau 1 giây.

### Ví dụ 2:
- Trong ví dụ này, thử nghiệm thêm trường hợp đó là nhận `value` từ `channel`
- Code example:
```go
func LeakReceive() {
	newRandStream := func() <-chan int {
		randStream := make(chan int)
		go func() {
			defer fmt.Println("newRandStream closure exited.") // (1)
			defer close(randStream)
			for {
				randStream <- rand.Int()
			}
		}()
		return randStream
	}
	randStream := newRandStream()
	fmt.Println("3 random ints:")
	for i := 1; i <= 3; i++ {
		fmt.Printf("%d: %d\n", i, <-randStream)
	}
}
```

- Ghi chú:
  - (1) khi dòng này xuất hiện thì `goroutine` đã được remove thành công.
- Kêt quả:
```
3 random ints:
1: 5577006791947779410
2: 8674665223082153551
3: 6129484611666145821
```
  - Trong print out, không có hàm `defer fmt.Println`, điều này đồng nghĩa nó không được thực thi => `leak`.
  - Sau khi 3 lần lặp, `goroutine` đã bị block và cố gắng send `random number` ra bên ngoài, nhưng có có `channel` read. Có nghĩa không có cách nào để `stop goroutine` đang chạy `random-number`

- Giải pháp, code:
```go
func PreventLeakReceive() {
	newRandStream := func(done <-chan interface{}) <-chan int {
		randStream := make(chan int)
		go func() {
			defer fmt.Println("newRandStream closure exited.")
			defer close(randStream)
			for {
				select {
				case randStream <- rand.Int():
				case <-done:
					return
				}
			}
		}()
		return randStream
	}
	done := make(chan interface{})

	randStream := newRandStream(done)
	fmt.Println("3 random ints:")
	for i := 1; i <= 3; i++ {
		fmt.Printf("%d: %d\n", i, <-randStream)
	}
	close(done)
	// Simulate ongoing work
	time.Sleep(1 * time.Second)
}
```
- Ghi Chú:
  - Như ví dụ trước, cũng tạo thêm 1 `channle`, 1 `goroutine` thứ 3 => `terminates goroutine` thành công
- Kết quả:
```
3 random ints:
1: 5577006791947779410
2: 8674665223082153551
3: 6129484611666145821
newRandStream closure exited.
```
- Như đã nhìn thấy, goroutine thực sữ đã được clean-up.', 'aNj4vQq0V6r', '6', '', 'Goroutine Leak, và debug resource: https://viblo.asia/p/golang-leaks-in-goroutine-and-debug-resource-3kY4g5q0LAe
prevent-leak
- Trong ví dụ trước đã nói về leak cũng như debug resource bằng pprof
- Thì bài viết này hỗ trợ làm sao để không bị leak khi sử dụng goroutine trong golang

Ví dụ 1;
- Để thành công trong việc giảm thiểu leak trong goroutine thì dùng channel giữa các goroutine cha và con...', '2023-02-26T04:44:50.000000Z', '2023-02-27T04:02:04.000000Z'),
	('9 Logging best practices', 'Bài viết được dịch từ [nguồn](https://medium.com/gitconnected/9-logging-best-practices-da9457e33305)

Logging là một công cụ hữu hiệu trong việc debug cũng như monitoring error.

Thế nhưng nội dung log cũng rất quan trọng, nếu log ra những thông tin không hữu ích thì chỉ tốn bộ nhớ cũng như chi phí duy trì log mà thôi.

Theo ý kiến của cá nhân tôi, logging nên được nhìn nhận với tư cách là "công dân hạng một" trong hệ thống. Đề từ đó, ta sẽ coi log như một "chức năng" trong hệ thống, áp dụng những best practice cho nó để đạt được mục đích của chúng ta.

Khi bắt đầu với logging, tôi khuyên rằng bạn KHÔNG NÊN sử dụng các thư việc logging của ngôn ngữ lập trình mà bạn đang sử dụng. Chúng thường thiếu đi các tính năng mà một logging system cần phải có và mục đích chính của các thư viện này chỉ là debug dưới môi trường local mà thôi.

Dưới đây là một vài thư viện log tiêu biểu:

- [Winston](https://github.com/winstonjs/winston) của NodeJS.
- [Log4J](https://logging.apache.org/log4j/2.x/) của Java.
- [Zap](https://pkg.go.dev/go.uber.org/zap) của Go.

## Best practices

### 1. Kiểm tra logs của bạn

Ý tôi ở đây không phải là unit test, mà là sau khi viết logs bạn nên xem xem:

- Nội dung log có đúng như kì vọng hay không ?
- Có dễ hiểu hay không ?
- Có thiếu sót gì hay không ?
- Liệu có cần bổ sung thêm thông tin hay ngữ cảnh (context) gì nữa hay không ?

Hãy chia sẻ với các thành viên trong team của bạn, hỏi họ xem họ có hiểu nội dung của log hay không ?

### 2. Đừng log ra những thông tin nhạy cảm

Đừng bao giờ log ra những thông tin nhạy cảm như `API keys`, `Password`, ... Việc log ra những thông tin như vậy sẽ làm tăng nguy cơ về bảo mật cho hệ thống.

```TS
// Wrong
logger.error("Unable to login", request);

// Correct
logger.error("Unable to login", {
  userName: request.user,
  password: request.pass ? "[HIDDEN]" : null,
  // additonal information4
});
```

### 3. Hãy đưa ra những message cụ thể

Logging chỉ có giá trị nếu message cung cấp các thông tin hữu ích, do đó hãy cung cấp một message với nội dung cụ thể, chi tiết.

```TS
// Wrong
logger.info("We''re starting !");
// Task processing logic
logger.info("Task completed !");

// Correct
logger.info("Starting task", {
  name: taskName,
  params: params,
  startTime: startTime,
});
// Task processing logic
logger.info("Task Completed", {
  response: output.response,
  event: {
    action: taskName,
    duration: currentTime - startTime,
  },
});
```

### 4. Đừng log ra những messages quá cồng kềnh

Logging cũng tốn chi phí để duy trì, thông thường log sẽ được lưu trong một file và sau đó sẽ được upload lên một storage để từ đó nó được phân tích. Nếu hệ thống của bạn đáp ứng cả triệu requests thì đồng nghĩa với đó là việc sẽ có cả triệu triệu log được đưa ra và lưu vào trong file.

Do đó chỉ nên log ra "vừa đủ" những thông tin hữu ích để tiết kiệm chi phí bảo trì log nhất có thể.

### 5. Log ra mọi lỗi

Log là một công cụ hỗ trợ rất đắc lực cho dev trong quá trình debug, nếu bạn đang cần phải viết các đoạn code đảm nhận chức năng xử lí lỗi, hãy đảm bảo rằng bạn luôn luôn log ra lỗi trước khi đưa ra một lỗi khác cho phía user. Ví dụ:

```TS
try {

} catch (err) {
  logger.error(''An errror occured'', { error: err, args: args });
  throw new SystemError(''Unable to procress request'');
}
```

Nếu chúng ta không log ra lỗi thì sau này sẽ rất khó để hiểu tại sao ở đây ta lại "ném" ra `SystemError`.

### 6. Tận dụng các tính năng sẵn có của logger

Các thư viện logger đều hỗ trợ rất nhiều tính năng hữu ích, ví dụ như `Log Level`. Việc đưa ra log level giúp ta dễ dàng phân biệt được:

- Loại lỗi.
- Ngữ cảnh xảy ra lỗi.

Với môi trường production ta chỉ đưa ra `Info`, `Error` log, còn với môi trường dev ta sẽ đưa ra mọi loại log. Và đồng thời sử dụng log với đúng mục đích, đừng dùng `Info` log cho lỗi.

### 7. Đừng sử dụng debug level cho system monitoring data

Với việc theo dõi hệ thống (system monitoring) ta chỉ cần các thông tin ở múc độ **Info** & **Error** là đủ, chứ không cần các thông tin ở mức độ **Debug**.

### 8. Đảm bảo rằng ta lưu trace Ids trong log

Việc thêm trace Ids thường dùng cho các hệ thống phân tán. Hãy log chúng ra, việc debug trong một hệ thống phân tán mà không có trace Ids là một việc vô cùng vất vả.

### 9. Thiết lập các quy chuẩn tối thiểu cho hệ thống

Thiết lập một số lượng nhất định các trường dữ liệu cần phải log ra bên trong hệ thống của bạn. Nó sẽ bao gồm:

- Độ trễ.
- Khoảng thời gian request.
- Trace Ids.

Việc có một quy chuẩn như vậy sẽ giúp cho việc phát hiện ra các lỗi tiềm tàng về hiệu năng của hệ thống trở nên dễ dàng hơn. Chúng ta từ đó có thể "chủ động" hơn trong việc nắm bắt các lỗi có trong hệ thống.', 'MkNLrOklVgA', '7', '', 'Bài viết được dịch từ nguồn

Logging là một công cụ hữu hiệu trong việc debug cũng như monitoring error.

Thế nhưng nội dung log cũng rất quan trọng, nếu log ra những thông tin không hữu ích thì chỉ tốn bộ nhớ cũng như chi phí duy trì log mà thôi.

Theo ý kiến của cá nhân tôi, logging nên được nhìn nhận với tư cách là "công dân hạng một" trong hệ thống. Đề từ đó, ta sẽ coi log như một "chức năn...', '2023-02-26T04:10:08.000000Z', '2023-02-27T04:23:03.000000Z'),
	('Thích học ReactJS - Pure React', '# Giới thiệu
Ở bài trước, chúng ta đã cùng tìm hiểu về ReactJS là gì, tại sao nên sử dụng ReactJS và khởi tạo đơn giản một dự án ReactJS. Hôm nay chúng ta sẽ đi sâu hơn vào việc tạo một component trong ReactJS như thế nào nhé.
# Tạo project với ReactJS thuần
Bài trước, chúng ta đã tạo một project ReactJS với Vite. Vậy muốn dùng ReactJS là phải sử dụng Vite phải không? Câu trả lời là không. ReactJS và Vite là hai công cụ với 2 mục đích khác nhau. ReactJS thì tập trung vào xây dựng giao diện người dùng là chính. Vite thì là một công cụ hỗ trợ build, hot reload, tích hợp những công nghệ khác vào một cách dễ dàng,... Giờ chúng ta sẽ cùng tìm hiểu việc tạo một project với chỉ có ReactJS thôi nhé. Không có quản lí package, không có babel, không có webpack hay vite. Đầu tiên, các bạn tạo một file html theo chuẩn html5 như thế này:
![image.png](https://images.viblo.asia/d18eefc6-1444-493d-b703-01ab9cfb816d.png)

Tiếp theo, chúng ta sẽ thêm script của ReactJS vào phía dưới cùng của body. Đồng thời, thêm một thẻ tag với id là root, đây là thẻ tag sau này chúng ta dùng để render những component trong thẻ tag này. Cuối cùng là thêm một script rỗng để implement script của riêng mình. Thì trong cái script rỗng này, chúng ta sẽ dùng những hàm được viết sẵn từ thư viện ReactJS.

![image.png](https://images.viblo.asia/dba0f89a-6aac-4365-8df2-bc95ac49f88a.png)

Bây giờ chúng ta sẽ tạo một component có tên là App, trong component thì nội dung đơn giản thôi, mình sẽ để là `Hello React from www.thichhoc.com`.
![image.png](https://images.viblo.asia/c8fd9243-b744-4e46-9f6e-4c52cd2ea5f8.png)

Bây giờ chúng ta sẽ tạo một component có tên là App, trong component thì nội dung đơn giản thôi, mình sẽ để là `Hello React from thichhoc.com`. Để tạo một component, chúng ta sẽ tạo một hàm và trả về một React Element. Trong component App này mình tạo một element của ReactJS. Tham số đầu tiên là thẻ tag, tham số thứ hai là những thuộc tính của thẻ tag đó và tham số thứ 3 là nội dung, nội dung có thể chỉ là một chuỗi đơn giản hoặc có thể là một ReactJS element khác. Component App này có nghĩa là render ra một thẻ h1 có id và class là greeting và nội dung là `Hello React from www.thichhoc.com`. Mở index.html bằng browser lên, các bạn sẽ chưa thấy gì thay đổi vì chúng ta chỉ mới tạo một cái component thôi, chúng ta chưa đưa nó vào cây DOM. Bật Console của browser lên và các bạn thử gõ App() các bạn sẽ thấy component của chúng ta vừa mới tạo. Chúng ta chỉ cần dùng API của React, còn việc tạo những cái này thì ReactJS sẽ handle và tạo cho chúng ta. Tiếp theo, mình sẽ hướng dẫn các bạn đưa component mới tạo này vào cây DOM để render.

![image.png](https://images.viblo.asia/9c00ad3c-d7ee-4d4c-83da-fdbf40c2c9ac.png)

Các bạn viết tiếp đoạn code sau vào bên dưới. Ở đây, mình gán vào biến container là element mình lấy được có id là root, tức là cái thẻ div mà mình tạo với id là root ban đầu đấy. Sau đó, mình sử dụng hành createRoot từ ReactDOM để dùng element này là root, thì những component được render sau này, mặc định sẽ nằm trong component này. Sau đó dòng tiếp theo mình sẽ chỉ định là render ra component App mình mới tạo khi nãy.

![image.png](https://images.viblo.asia/98f4e9da-7c27-443f-8a91-3eac190f63b0.png)

Full script không che thì sẽ như thế này:

![image.png](https://images.viblo.asia/646728c1-027e-4e0e-a447-5bb7926d10b8.png)

Bật browser lên và xem kết quả:

![image.png](https://images.viblo.asia/46088bad-1d83-42cc-a1db-8912990b0e13.png)
# React.createElement mở rộng
## Nested Element
Quay lại phương thức createElement, để render element trong element greeting chúng ta sẽ làm như thế nào? Chỉnh sửa component App lại như sau. Như mình nói ở trên, tham số thứ ba của createElement có thể là chuỗi hoặc là một element khác. Như vậy để render thẻ h1 trong thẻ div thì đơn giản là tạo elemnt với thẻ div xong truyền vào tham số thứ ba là thẻ h1 và content của element đó là xong.
![image.png](https://images.viblo.asia/24e91bd2-e850-4c58-a740-6c51458ffec8.png)

Mở Inspector lên và xem cấu trúc của file html. Ở đây, các bạn sẽ thấy chúng ta có element với id là root. Xong rồi trong root thì mình có element với id là class là greeting và nội dung là `Hello React from www.thichhoc.com`. Như vậy, chúng chỉ cần sử dụng createElement của ReactJS, ReactJS sẽ có cách để handle và render nó ra thành `<h1 id="greeting" class="greeting">Hello React from www.thichhoc.com</h1>` cho mình.

![image.png](https://images.viblo.asia/17a106d7-1822-4f5e-b467-6f7075b2a7a1.png)

## Element cùng level
Giờ mình muốn tạo thẻ p làm description cùng level với h1 thì mình làm như thế nào? Tham số thứ ba của createElement còn nhận vào một mảng danh sách các element. ReactJS sẽ render những element này theo thứ tự đã được sắp xếp trong code. Vậy nếu mình muốn render thẻ h1 rồi đến thẻ p thì mình sẽ bỏ vào một mảng, h1 là phần tử thứ nhất và p là phần tử thứ hai.

![image.png](https://images.viblo.asia/10d7e47d-98fb-4b3c-873e-d4edfa0ac3d9.png)

Kết quả và cấu trúc HTML mình thư được:

![image.png](https://images.viblo.asia/a23debf2-2635-43c5-9edc-d2f5ad35085b.png)

Và đây là kết quả

![image.png](https://images.viblo.asia/293df743-203b-493c-8a5d-2ee7cd5235e0.png)

## Nested Component
Đến lúc này, mình thấy cái component App nó hơi phức tạp rồi đấy và nếu mình có chỗ khác cần greeting thì cũng không dùng lại được. May thay, với ReactJS, mình chỉ cần khai báo greeting như một component và tái sử dụng nó trong component App. Code bên dưới mình chỉ việc di chuyển element nằm trong mảng vào trong component mới và mình đặt tên component này là Greeting. Thay đổi một ít về tên class và id. Sau đó trong component App, mình gọi ra component Greeting trong tham số thứ ba. Như vậy, component Greeting sẽ được render như là một nested component trong component App.

![image.png](https://images.viblo.asia/5428e4ca-d7a5-44d5-920b-8dd3ae51671c.png)

Có một vấn đề bất cập là trong Greeting component, mình phải dùng thẻ tag, nếu để mảng rỗng sẽ báo lỗi. Thành ra cấu trúc file HTML nhìn hơi ứa gan.

![image.png](https://images.viblo.asia/3e7dde14-726b-4b6f-8c2d-9b9e7b633845.png)

Có cái thẻ div rỗng, nó không làm gì cả, nó chỉ nằm đó, làm sao để bỏ nó đây? Trong React, có một component là React Fragment mà chúng ta có thể sử dụng để nó không render ra thêm thẻ tag mà có thể nested nhiều element khác ở bên trong nó.

![image.png](https://images.viblo.asia/91ce7f74-20a0-48a8-b3eb-cb8486b5dee8.png)

Và đây là kết quả

![image.png](https://images.viblo.asia/644ab7cb-4747-4e60-a122-84991b5127db.png)

# Lỗi keyword
```
Warning: Each child in a list should have a unique "key" prop.

Check the render method of `App`. See https://reactjs.org/link/warning-keys for more information.
h1
App react.development.js:199:32
```
```
Warning: Invalid DOM property `class`. Did you mean `className`?
h1
div
App
```
Chúng ta có hai lỗi, một là thiếu key và hai là dùng class mà không dùng className. Lỗi thiếu key, mình sẽ giải thích kĩ hơn ở những bài sau, hiện tại để fix lỗi này, các bạn chỉ cần thêm thuộc tính key vào element nằm trong mảng và key là unique nhé, không được trùng. Còn về lỗi className thì do class trùng với keyword class trong Javascript nên ReactJS prefer là dùng className để ám chỉ thuộc tính class trong HTML. Cùng sửa class lại thành className. Sau khi sửa xong, refresh lại và lỗi sẽ biến mất.

![image.png](https://images.viblo.asia/24957c0f-7b5d-40d2-96ae-16fc48266713.png)

# React Component và React Element
Mỗi component có nhiều element và mỗi element thì nằm trong một component. Kiểu component sẽ lớn hơn, như một cái bọc ở bên ngoài, bên trong là nhiều element.
# Tổng kết
Qua bài này, mình đã giới thiệu cho các bạn về cách viết Pure React. Cách tạo element rồi render dùng thư viện React. Tuy nhiên, có một bất cập là viết vậy khá là cực và nó không được trơn tru lắm. Nó làm mình liên tưởng tới cách tạo element trong javascript nhưng mà dễ dàng hơn một xíu, cấu trúc ok hơn một xíu. Mình tự hỏi có cách nào đơn giản hơn, như kiểu mình viết html thông thường vậy thì sẽ dễ hình dung, luồng nó cũng tự nhiên hơn. Thì đó là lí do ReactJS có JSX, đây là một cách để mà chúng ta tạo cấu trúc HTML cũng như những component dễ dàng hơn sử dụng ReactJS. Cùng tìm hiểu ở bài sau nhé.', '7ymJXXxrJkq', '8', 'https://images.viblo.asia/80d93764-0ba0-4b5e-bbe7-fa93f04e1e76.png', 'Giới thiệu
Ở bài trước, chúng ta đã cùng tìm hiểu về ReactJS là gì, tại sao nên sử dụng ReactJS và khởi tạo đơn giản một dự án ReactJS. Hôm nay chúng ta sẽ đi sâu hơn vào việc tạo một component trong ReactJS như thế nào nhé.
Tạo project với ReactJS thuần
Bài trước, chúng ta đã tạo một project ReactJS với Vite. Vậy muốn dùng ReactJS là phải sử dụng Vite phải không? Câu trả lời là không. ReactJS ...', '2023-02-26T04:04:31.000000Z', '2023-02-27T04:15:05.000000Z'),
	('Xây dựng hệ thống xử lí lỗi bằng NodeJS', 'Dịch từ [nguồn](https://www.toptal.com/nodejs/node-js-error-handling)

> Xử lí lỗi không chỉ đơn thuần là giảm thời gian tìm bug cho dev mà còn là xây dựng một codebase với quy mô tương xứng với hệ thống của bạn

## Các loại lỗi trong NodeJS

Trong Node.js có 2 loại errors chính:

- **Operational errors**: runtime error, một số ví dụ: "Out of memory", "An invalid input for an API endpoint"
- **Programmer errors**: unexpected bugs, bản thân code có những vấn đề cần phải giải quyết. Ví dụ tiêu biểu: đọc property của "undefined" object. Các bug này thường do dev tạo nên chứ không liên quan đến operation.

## Xử lí lỗi

Với các lỗi đã được định nghĩa sẵn bởi Node.js, ta sẽ dễ dàng theo dõi thông tin xung quanh nó nhờ `Stacktrace` → từ đó ta có thể tìm ra nguyên nhân gốc rễ của lỗi.

Ngoài ra việc extends từ `Error class` cũng như bổ sung các thuộc tính khác như `HTTP status code` cũng sẽ giúp cho thông tin về lỗi trở nên chi tiết hơn

```TS
class BaseError extends Error {
  public readonly name: string;
  public readonly httpCode: HttpStatusCode;
  public readonly isOperational: boolean;

  constructor(
    name: string,
    httpCode: HttpStatusCode,
    description: string,
    isOperational: boolean,
  ) {
    super(description);
    Object.setPrototypeOf(this, new.target.prototype);

    this.name = name;
    this.httpCode = httpCode;
    this.isOperational = isOperational;

    Error.captureStackTrace(this);
  }
}

// free to extend from BaseError
class APIError extends BaseError {
  constructor(name, httpCode = HttpStatusCode.INTERNAL_SERVER, isOperational = true, description = ''Internal Server Error'') {
    super(name, httpCode, isOperational, descritpion);
  }
}
```

Một vài `httpStatusCode` cơ bản có thể thêm ở đây:

```TS
export enum HttpStatusCode {
  OK = 200,
  BAD_REQUEST = 400,
  NOT_FOUND = 404,
  INTERNAL_SERVER = 500,
}
```

Cách sử dụng như sau:

```TS
const user = await User.getById(1);

if (!user) {
  throw new APIError(
    ''NOT FOUND'',
    HttpStatusCode.NOT_FOUND,
    true,
    ''detailed explanation''
  );
}
```

## Xử lí lỗi bằng NodeJS một cách tập trung

Việc xây dụng một component với chức năng để xử lí lỗi sẽ giúp giảm thiểu đi việc trùng lặp code xử lí lỗi trong project. Component này chịu trách nhiệm cho việc **giúp cho lỗi bắt được trở nên dễ hiểu hơn** ví dụ như:

- Gửi thông báo đến system admin
- Chuyển event error đến monitoring service như Sentry.io và log chúng ra

![File_000](https://user-images.githubusercontent.com/15076665/179694787-49e0f4fc-fcbd-46e7-a2b5-721d2152da90.png)

Trước khi được gửi đến error-handling centralized thì lỗi sẽ được gửi đến error-handling middleware để tiến hành `phân biệt giữa các error types`.

```TS
try {
  userSerivce.addNewUser(req.body).then((newUser: User) => {
    res.status(200).json(newUser);
  }).catch ((error: Error) => {
    next(error);
  });
}
```

Và Error-handling centralized sẽ trông như sau:

```TS
export class ErrorHandler {
  public async handleError(err: Error): Promise<void> {
    await logger.error(
      ''Error message from the centralized error-handling component'',
      err,
    );
    await sendToSlack();
    await sendEventsToSentry();
  }

  public isTrustedError(error: Error) {
    if (error instanceOf BaseError) {
      return error.isOperational;
    }
    return false;
  }
}
```

Để dev có thể theo dõi bug một cách dễ dàng hơn, hãy tiến hành log error ra theo một format dễ nhìn nhất.

Một vài logger formatter tiêu biểu như:

- <https://github.com/expressjs/morgan>
- <https://github.com/winstonjs/winston>

Hai thư viện này sẽ giúp cung cấp log ở các format level khác nhau tuỳ theo level của error.

Với các `Programmer errors`, cách giải quyết tốt nhất đó là
B1. Crash app ngay lập tức
B2. Restart lại app với các tool như pm2

Nguyên nhân là bởi `Programmer errors` thường sẽ làm cho app kết thúc với một state không như mong muốn.

```TS
process.on(''uncaughtException'', (error: Error) => {
  errorHandler.handleError(error);
  if (!errorHandler.isTrustedError(error)) {
    process.exit(1);
  }
});
```

Với promies rejection ta có thể làm như sau:

```TS
// get the unhandled rejection and throw it to another fallback handler we already have.
process.on(''unhandledRejection'', (reason: Error, promise: Promise<any>) => {
  throw reason;
});

process.on(''uncaughtException'', (error: Error) => {
  errorHandler.handleError(error);
  if (!errorHandler.isTrustedError(error)) {
    process.exit(1);
  }
});
```', '5pPLkPxnVRZ', '9', 'https://user-images.githubusercontent.com/15076665/179694787-49e0f4fc-fcbd-46e7-a2b5-721d2152da90.png', 'Dịch từ nguồn

Xử lí lỗi không chỉ đơn thuần là giảm thời gian tìm bug cho dev mà còn là xây dựng một codebase với quy mô tương xứng với hệ thống của bạn

Các loại lỗi trong NodeJS

Trong Node.js có 2 loại errors chính:

- Operational errors: runtime error, một số ví dụ: "Out of memory", "An invalid input for an API endpoint"
- Programmer errors: unexpected bugs, bản thân code có những vấn đề c...', '2023-02-26T03:32:32.000000Z', '2023-02-27T04:17:03.000000Z'),
	('[Machine Learning] Một số nguồn hay cho việc tìm hiểu cơ chế "Attention"', '## head-attention-mechanism
https://data-science-blog.com/blog/2021/04/07/multi-head-attention-mechanism/

Giải thích về mặt toán học cơ chế head attention.
![](https://images.viblo.asia/ede2cd63-948b-4d7e-b4d0-c9bf50fab0fb.png)

## The Illustrated Transformer
http://jalammar.github.io/illustrated-transformer/

Giải thích khá hay, có ví dụ minh hoạ trực quan cho cơ chế xác xuất của Transformer
![](https://images.viblo.asia/18243c68-77dc-40a0-ae76-9d398254d069.png)


## The Attention Mechanism from Scratch
https://machinelearningmastery.com/the-attention-mechanism-from-scratch/

Giải thích sơ về mặt toán học, có code ví dụ về python, khá sát với thực tiễn, xong khi đọc cũng khó hiểu cho các bạn mới

![](https://images.viblo.asia/8aec0098-da17-414e-8446-7793a14a563d.png)

## Getting meaning from text: self-attention step-by-step video
https://peltarion.com/blog/data-science/self-attention-video

Giải thích cũng khá dễ hiểu, có video hướng dẫn từng step, và mô hình visual nhìn cũng khá ổn

![](https://images.viblo.asia/f6f57dd7-3c61-4733-a358-5da9132495a9.png)

## How Attention works in Deep Learning: understanding the attention mechanism in sequence models
Giải thích từng bước sự tiến hoá của các mô hình để đạt tới Attention method, qua đó chúng ta dễ có cách nhìn sâu sắc hơn về căn nguyên và các bước phát triển

https://theaisummer.com/attention/

![](https://images.viblo.asia/d570e3bb-019e-44f4-92d4-5653a951ddc6.png)', 'aNj4vQzdV6r', '10', 'https://images.viblo.asia/ede2cd63-948b-4d7e-b4d0-c9bf50fab0fb.png', 'head-attention-mechanism
https://data-science-blog.com/blog/2021/04/07/multi-head-attention-mechanism/

Giải thích về mặt toán học cơ chế head attention.

The Illustrated Transformer
http://jalammar.github.io/illustrated-transformer/

Giải thích khá hay, có ví dụ minh hoạ trực quan cho cơ chế xác xuất của Transformer

The Attention Mechanism from Scratch
https://machinelearningmastery.com/the-a...', '2023-02-26T03:21:52.000000Z', '2023-02-27T04:02:09.000000Z');

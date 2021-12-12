<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>oEmbed</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>
	<div class="main">
		<div class="input">
			<h3 class="title">oEmbed Test 박동현</h3>
			"https://www.youtube.com/watch?v=dBD54EZIrZo";
//		"https://www.instagram.com/p/BUawPlPF_Rx/";
//		"https://twitter.com/hellopolicy/status/867177144815804416";
//		"https://vimeo.com/20097015"
			
				<input id="url" name="url" class="url" type="text"/>
				<input type="submit" value="확인" id="checkBtn" class="checkBtn" />
			
		</div>
		<div class="contents">
			<ul>
				
			</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
var nullCheck =0;
function nullChk(){
	if($('#url').val()!=null&&$('#url').val()!=''){
		nullCheck = 1;
	}else{
		alert('url주소를 입력해주세요');
		nullCheck = 0;
	};
};	
$(()=>{
	$('#checkBtn').click(()=>{
		nullChk();
		if(nullCheck==1){
			var url = "url="+$("#url").val().trim();
			$.ajax({
                url:"/codingTest/checkUrl",
                data: url,
                success:function(result){
                   console.log(result);
                }
            });
  		};
	});
});
</script>
</html>

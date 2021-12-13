<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>oEmbed</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style>
ul,li{list-style-type: none;padding:0;margin:0;}
.input{
	width: 500px;
	height: 44px;
	border-radius: 30px;
	box-shadow: 0px 0px 10px -5px black;
	margin: 0 auto;
}
#url{
	width:400px;
	height: 42px;
	border: none;
	margin-left: 20px;
}
#checkBtn{
	background-color: white;
    border: none;
    border-radius: 10px;
    box-shadow: 0px 0px 12px -5px green;
    width: 60px;
    height: 34px;
    margin-top: 5px;
    font-weight: bold;
}
.title{
	margin:30px auto;
	width: 315px;
}
input:focus { outline: none; }
#list>li{float:left;border-bottom:1px solid gray;}
#list>li:nth-child(2n){width:65%;}
#list>li:nth-child(2n-1){width:30%;}
</style>
</head>
<body>
	<div class="main">
		<div>
			<h1 class="title">oEmbed Test 박동현</h3>
<!-- 			<h2 class="test">https://www.youtube.com/watch?v=dBD54EZIrZo</h2><br/> -->
<!-- 			<h2 class="test">https://www.instagram.com/p/BUawPlPF_Rx/</h2><br/> -->
<!-- 			<h2 class="test">https://twitter.com/hellopolicy/status/867177144815804416</h2><br/> -->
<!-- 			<h2 class="test">https://vimeo.com/20097015</h2><br/> -->
		</div>			
		<div class="input">
			<input id="url" name="url" class="url" type="text"/>
			<input type="submit" value="확인" id="checkBtn" class="checkBtn" />
		</div>
		<div id="contents">
			<ul id="list">
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
		$('#list').html("");
		if(nullCheck==1){
			var url = "url="+$("#url").val().trim();
			$.ajax({
                url:"/codingTest/checkUrl",
                data: url,
                
                success:function(res){
                	let result = JSON.parse(res);
	                let data = "";
	                if(result.title != null) data += "<li>Title</li><li>" + result.title + "</li>";

	                Object.keys(result).forEach(function(k){
                		switch(k){
	                		case 'error':
	                			data += "<li>권한을 가지고 있지 않습니다.</li>";
	                			break;
	                		case 'provider_url':
	                		case 'author_url':
	                		case 'thumbnail_url_with_play_button':
								data += "<li>"+k+"</li><li><a href='"+ result[k] + "'>" + result[k] + "</a></li>";
								break;
	                		case 'html':
								data += "<li>"+k+"<br/>(" + result.width + "/" + result.height + ")</li><li><xmp>" + result[k] + "</xmp>"+ result[k] + "</li>";
								break;
	                		case 'thumbnail_url':
	                			data += "<li>"+k+"<br/>(" + result.thumbnail_width + "/" + result.thumbnail_height + ")</li><li><a href='" +result[k]+"'>" + result[k] + "</a><br/><br/><img src='"+result[k]+"'/></li>";
								break;
	                		case 'title':
	                			break;
	                		default:
	                			data += "<li>"+k+"</li><li>" + result[k] + "</li>";
                		};
	                });
	                $('#list').append(data);
	                $('#url').val("");
                }
            });
  		};
	});
});

</script>
</html>

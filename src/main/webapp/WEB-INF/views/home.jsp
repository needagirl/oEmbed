<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>oEmbed Test 박동현</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style>
ul,li{list-style-type: none;padding:0;margin:0;}
ul{
	overflow:auto;
	width: 90%;
	margin: 7% 5% 7% 8%;
	font-weight: bold;
}
a:link,a:visited {
  color: rgb(184,151,125);
}

.input{
	width: 500px;
	height: 44px;
	border-radius: 30px;
	box-shadow: 0px 0px 10px -5px black;
	margin: 0 auto 30px;
}
#url{
	width:400px;
	height: 40px;
	border: none;
	margin-left: 20px;
}
#checkBtn{
	background-color: white;
    border: none;
    border-radius: 10px;
    box-shadow: 0px 0px 12px -5px rgb(184,151,125);
    width: 60px;
    height: 34px;
    margin-top: 5px;
    font-weight: bold;
}
.title{
	margin:30px auto;
	width: 315px;
}
.testUrl{
	width: 500px;
	margin: 0 auto; 
}
.tile{
	width: 20%;
	height: 60px;
	background:white;
	margin: 0px 10px;
	border-radius: 10px;
	border: none;
	box-shadow: 0px 0px 12px -5px red;
	font-size: 1rem;
}
#contents{
    width: 80%;
    margin: 30px auto;
    overflow: auto;
    border: none;
    border-radius: 5px;
    box-shadow: 0px 0px 12px -5px green;
}
input:focus { outline: none; }
#list>li{float:left;border-top:1px solid gray;padding:13px;}
#list>li:nth-child(2n){width:60%;}
#list>li:nth-child(2n-1){width:30%;}
xmp{
	width:100%;
	white-space: normal;
    color: rgb(184,151,125);
    font-size: 1rem;
    font-weight: bold;
}
</style>
</head>
<body>
	<div class="main">
		<div>
			<h1 class="title">oEmbed Test 박동현</h3>
		</div>			
		<div class="input">
			<input id="url" name="url" class="url" type="text"/>
			<input type="submit" value="확인" id="checkBtn" class="checkBtn" />
		</div>
		<div class="testUrl">
			<button class="tile" title="youtube" value="https://www.youtube.com/watch?v=dBD54EZIrZo">youtube</button> 
			<button class="tile" title="instagram" value="https://www.instagram.com/p/BUawPlPF_Rx/">instagram</button> 
			<button class="tile" title="twitter" value="https://twitter.com/hellopolicy/status/867177144815804416">twitter</button> 
			<button class="tile" title="vimeo" value="https://vimeo.com/20097015">vimeo</button> 
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
$(()=>{
	$('.tile').click(getVal);
});
function getVal() {
	$('#url').val($(this).val());
};
</script>
</html>

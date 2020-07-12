<%@page import="com.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%	
// MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
// String userName=memberVO.getMem_name();
// request.setAttribute("userName", userName);
	request.setAttribute("userName", "十八禁銅人");
%>

	
	<div id="body">
		<div id="close" onclick="dbclick()">close</div>
		<h3 id="statusOutput" class="statusOutput alert alert-primary"></h3>
		<div id="row"></div>
		<div id="messagesArea" class="panel message-area"></div>
		<div class="panel input-area">
			<input id="message" class="text-field" type="text"
				placeholder="Message"
				onkeydown="if (event.keyCode == 13) sendMessage();" /> <input
				type="submit" id="sendMessage" class="button" value="Send"
				onclick="sendMessage();" />
		</div>
	</div>

<script>
	var MyPoint = "/FriendWS/${userName}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

	var statusOutput = document.getElementById("statusOutput");
	var messagesArea = document.getElementById("messagesArea");
	var self = '${userName}';
	var webSocket;

	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			document.getElementById('sendMessage').disabled = false;

		};

		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			if ("open" === jsonObj.type) {
				console.log(jsonObj);
				refreshFriendList(jsonObj);

			} else if ("history" === jsonObj.type) {
				messagesArea.innerHTML = '';
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var showMsg = historyData.message;
					var li = document.createElement('li');
					// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
					historyData.sender === self ? li.className += 'me'
							: li.className += 'friend';
					li.innerHTML = showMsg;
					ul.appendChild(li);
				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("chat" === jsonObj.type) {
				var li = document.createElement('li');
				jsonObj.sender === self ? li.className += 'me'
						: li.className += 'friend';
				li.innerHTML = jsonObj.message;
				console.log(li);
				document.getElementById("area").appendChild(li);
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("close" === jsonObj.type) {
				refreshFriendList(jsonObj);
			}

		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}

	function sendMessage() {
		var inputMessage = document.getElementById("message");
		var friend = statusOutput.textContent;
		var message = inputMessage.value.trim();

		if (message === "") {
			alert("Input a message");
			inputMessage.focus();
		} else if (friend === "") {
			alert("Choose a friend");
		} else {
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"receiver" : friend,
				"message" : message
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}

	// 有好友上線或離線就更新列表
	function refreshFriendList(jsonObj) {
		var online = jsonObj.users;
		var friends = jsonObj.friends;
		var me = jsonObj.user;

		var row = document.getElementById("row");
		var stat = jsonObj.isonline;
		console.log(jsonObj);

		if (row.innerHTML === '') {
			for (var i = 0; i < friends.length; i++) {
				row.innerHTML += '<div id=' + i + ' class="column" style="background-color: gray; padding:10px;text-align: center; color: white;" name="friendName" value=' 
				+ friends[i] + ' ><div>'
						+ friends[i]
						+ '</div><div id='+friends[i]+'></div></div>';

				for (var j = 0; j < online.length; j++) {

					if (friends[i] === online[j]) {
						var friend = document.getElementById(friends[i]).parentNode;
						friend.style.background = 'blue';
						console.log(friend);

					}
				}
			}

			addListener();
		} else if (jsonObj.type === "open") {

			var friend = document.getElementById(me).parentNode;
			friend.style.background = 'blue';

		} else if (jsonObj.type === "close") {
			var friend = document.getElementById(me).parentNode;
			friend.style.background = 'gray';

		}

	}
	// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
	function addListener() {
		var container = document.getElementById("row");
		container.addEventListener("click", function(e) {
			var friend = e.srcElement.textContent;
			updateFriendName(friend);
			var jsonObj = {
				"type" : "history",
				"sender" : self,
				"receiver" : friend,
				"message" : ""
			};
			webSocket.send(JSON.stringify(jsonObj));
		});
	}

	function disconnect() {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;

	}

	function updateFriendName(name) {
		statusOutput.innerHTML = name;
	}
	function on(){
		document.getElementById("body").style.display = "block";
		connect();
	}
	function dbclick(){
		document.getElementById("body").style.display = "none";
		disconnect();
	}
	
</script>
</html>
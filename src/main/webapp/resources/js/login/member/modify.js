    $(document).ready(function(){
    var memberID = sessionStorage.getItem("memberID");
    var memdata = {"id":memberID};

    memberService.get(memdata,function(data){
    if(data){
        //회원 탈퇴할때 사용하려고 세션에 저장함
    sessionStorage.setItem("password",data.password);
    console.log(data);
    console.log(data.name);
    $("input[name='id']").val(data.id);
    $("input[name='name']").val(data.name);
    $("input[name='password']").val(data.password);
    $("input[name='address1']").val(data.address1);
    $("input[name='address2']").val(data.address2);
    $("input[name='email1']").val(data.email1);
    $("input[name='email2']").val(data.email2);
    $("input[name='phonenumber']").val(data.phonenumber);
}else{
    console.log("data address 가 없습니다");
}

});

    //비밀번호 중복 확인하기 위한 스크립트
    $("#checkpw2").change(function(e){
    var checkpw1= $("input[id='checkpw1']").val();
    var checkpw2 = $("input[id='checkpw2']").val();
    e.preventDefault();
    console.log("비밀번호 중복확인중")

    if(checkpw1 != checkpw2){
    console.log("비밀번호중복확인 실패");

    $(".checkPw").html("비밀번호 중복 확인 실패");
    $(".checkPw").css("color","red");
}else{
    $(".checkPw").html("");
}
});

    //회원가입 눌렀을시 발생하는 이벤트 스크립트
    $("#insert").on("click",function(e){
    var checkpw1= $("input[id='checkpw1']").val();
    var checkpw2 = $("input[id='checkpw2']").val();

    if(checkpw1 != checkpw2){
    alert("비밀번호 중복확인 실패했습니다.");
    return;
}

    var formObj = $(".actionForm");
    e.preventDefault();
    formObj.submit();
});
        var modal = $("#myModal");
        var removeForm = $("#reMemberForm");

        $("#remove").on("click",function(){
            console.log("회원탈퇴 버튼 클릭");
            $('#myModal').modal('show');

        });

        $("#resubmit").on("click",function (e){
            e.preventDefault();
            var realpassword = sessionStorage.getItem("password");
            console.log("세션에 저장된 비밀번호 :"+realpassword);
            var password = $("input[name='repassword']").val();
            console.log("입력한 비밀번호 : " + password);

            if(realpassword != password){
                alert("입력하신 비밀번호와 회원 비밀번호가 다릅니다.");
                return;
            }
            var memberID = sessionStorage.getItem("memberID");
            var str = str += "<input type='hidden' name='id' value='"+memberID+"'>";
            removeForm.append(str);
            removeForm.submit();
            sessionStorage.removeItem("password");
            sessionStorage.removeItem("memberID");
        });

    });

    function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;

            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}



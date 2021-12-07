    $(document).ready(function(){

        //이름 정규표현식 스크립트
        $("#name").change(function(){
            var namereg = /^[가-힣]{2,5}$/;
            if(!namereg.test($("input[name='name']").val())){
                $(".checkName").html("이름은 한글로 2~5글자로 입력해야합니다.");
                $(".checkName").css("color","red");
                $("input[name='name']").val("");
            }else{
                $(".checkName").html("");
            }
        });


    //아이디 정규표현식 스크립트
        $("#checkId").change(function(){
            var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
        if( !idReg.test( $("input[name=id]").val())) {
            $(".checkId").html("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.")
            $(".checkId").css("color","red");
            $("input[name='id']").val("");
        }else{
            $(".checkId").html("");
        }
        });


       //아이디 중복검사 스크립트
        $(".IDCheck").on("click",function(){
            var id = $("input[name='id']").val();
            var checkId = {"id":id};
            $.ajax({
                type:'post',
                url:"/member/checkId",
                data:checkId,
                success:function(result,status){
                        if(result ==="success"){
                            alert("사용가능한 아이디 입니다.");
                            $("input[id='IDCheck2']").val("");
                        }else{
                            alert("사용중인 아이디 입니다.");
                            $("input[id='IDCheck2']").val("false");
                        }
                }
            });
        });

        //비밀번호 유효성검사
        //최소 8 자, 최소 하나의 문자, 하나의 숫자 및 하나의 특수 문자 :
        $("#checkpw1").change(function(){
            var passwordreg =/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
            if(!passwordreg.test($("input[name='password']").val())){
                $(".checkPw").html("비밀번호는 8자이상이고 영문,숫자 및 특수문자를 포함해야합니다.");
                $(".checkPw").css("color","red");
                $("input[name='password']").val("");
            }else{
                $(".checkPw").html("");
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
            $("input[id='checkpw2']").val("");
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
    var checkid = $("input[id='IDCheck2']").val();
    console.log("아이디중복확인 값 : "+ checkid);
    if(checkid =="false"){
        alert("아이디 중복확인에 실패했습니다");
        return;
    }
    if($("input[type='text']").val()==""){
        alert("모든 선택지들을 채워주세요.")
           return;
    }

    var formObj = $(".actionForm");
    e.preventDefault();
    formObj.submit();
});

});

/*우편번호 찾기 api*/
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
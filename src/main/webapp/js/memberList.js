$(() => {
    // subject 값 유지
    const selectId = $("select option[name=optionId]");
    const selectName = $("select option[name=optionName]");
    let subject = "<%=subject%>";

    if (selectId.val() == subject) selectId.attr("selected", "selected");
    else if (selectName.val() == subject) selectName.attr("selected", "selected");

    // 비밀번호 변경 버튼 누르면 input 태그(비밀번호 치는 란) 생기고 옆에 변경 버튼
    // 변경 버튼 누르면 변경 되도록
    const pwChangeBtn = $("button[name=pwChange]"); // 계정 변경 버튼
    for (let i = 0; i < pwChangeBtn.length; i++) {
        $(pwChangeBtn.eq(i)).click(() => {
            if (pwChangeBtn.eq(i).text() == "비밀번호 변경") {
                // input 태그 생성 + 단추 변경
                pwChangeBtn.eq(i).before("<input class=\"me-1\" type=\"text\">");
                pwChangeBtn.eq(i).text("변경");
                pwChangeBtn.eq(i).prev().focus(); // input 태그로 커서 보내기
            }
            else {
                const idVal = pwChangeBtn.eq(i).parent().parent().children().first().text();
                const newPasswordVal = pwChangeBtn.eq(i).prev().val();
                // 비밀번호 변경 기능
                $.ajax({
                    type: "post",
                    url: "/member/ajaxAdminChangePassword.jsp",
                    dataType: "json",
                    data: {
                        idVal : idVal,
                        pwVal : newPasswordVal
                    },
                    success: (res) => {
                        if (res)
                            pwChangeBtn.eq(i).parent().prev().text(newPasswordVal);
                        else
                            alert("비밀번호 변경에 실패했습니다.");
                    }
                });

                // 단추 되돌리기
                pwChangeBtn.eq(i).prev().remove();
                pwChangeBtn.eq(i).text("비밀번호 변경");
            }
        });
    }

    // 계정 삭제 버튼 누르면 계정 삭제 되도록
    const deleteMemberBtn = $("button[name=deleteMember]"); // 계정 삭제 버튼
    for (let i = 0; i < deleteMemberBtn.length; i++) {
        $(deleteMemberBtn.eq(i)).click(() => {
            const isDelete = confirm("정말 삭제하시겠습니까?");
            if (isDelete) {
                // ajax로 계정 삭제
                const idVal = deleteMemberBtn.eq(i).parent().parent().children().first().text();
                const passwordVal = deleteMemberBtn.eq(i).parent().parent().children().first().next().next().text();

                $.ajax({
                    type: "post",
                    url: "/member/ajaxAdminDelete.jsp",
                    dataType: "json",
                    data: {
                        idVal : idVal,
                        pwVal : passwordVal
                    },
                    success: () => {
                        // 새로고침
                        location.reload();
                    },
                    error: () => {
                        alert("계정 삭제에 실패했습니다.");
                    }
                });
            }
        });
    }
});
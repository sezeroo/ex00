package com.zerock.security;

import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTest {

    @Autowired
    private PasswordEncoder pwencoder;

    @Autowired
    private DataSource ds;

    @Test
    public void testInsertMember(){

        String sql = "insert into tbl_member_auth(userid,auth) values" +
                "(?,?)";

        for(int i = 0; i<100; i++){

            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                con = ds.getConnection();
                pstmt=con.prepareStatement(sql);

                /*userpw 에 저장할것, pwencoder 를 이용해 패스워드 인코더 해줘야 합니다.*/

                if(i < 70){

                    pstmt.setString(1,"user"+i);
                    pstmt.setString(2,"ROLE_USER");

                }else if (i < 80){

                    pstmt.setString(1,"manager"+i);
                    pstmt.setString(2,"ROLE_MEMBER");

                }else if (i < 90){

                    pstmt.setString(1,"admin"+i);
                    pstmt.setString(2,"ROLE_ADMIN");

                }
                pstmt.execute();


            }catch (Exception e){
                e.printStackTrace();

            }finally {
                if(pstmt!=null){ try { pstmt.close(); }catch (Exception e){} }

                if(con!=null){try{con.close();} catch(Exception e){}}
            }

        }
    }

}

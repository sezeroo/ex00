package com.zerock.security;

import com.zerock.domain.CustomUser;
import com.zerock.domain.MemberVO;
import com.zerock.mapper.MemberMapper;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Log4j
public class CustomUserDetailService implements UserDetailsService {

    @Autowired
   private MemberMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        log.warn("Load User By UserName : " + username);

        //userName means  userid
        MemberVO vo = mapper.read(username);

        log.warn("required by member mapper : " + vo);

        return vo == null ? null : new CustomUser(vo);
    }
}

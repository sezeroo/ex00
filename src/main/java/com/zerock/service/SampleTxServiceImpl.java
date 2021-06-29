package com.zerock.service;

import com.zerock.mapper.Sample1Mapper;
import com.zerock.mapper.Sample2Mapeer;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Log4j
@Service
public class SampleTxServiceImpl implements SampleTxService{

    @Autowired
    private Sample1Mapper mapper1;

    @Autowired
    private Sample2Mapeer mapper2;

    @Transactional
    @Override
    public void addData(String value) {

        log.info("mapper1...............");
        mapper1.insertcol1(value);

        log.info("mapper2.................");
        mapper2.insertCol2(value);

        log.info("end...................");
    }
}

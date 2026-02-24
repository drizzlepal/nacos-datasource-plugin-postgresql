package com.drizzlepal.nacos.plugin.datasource.impl.postgresql;

import com.alibaba.nacos.plugin.datasource.mapper.ConfigInfoGrayMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.Collections;

/**
 * 灰度配置信息 Mapper PostgreSQL 实现
 * 对应数据库表: config_info_gray
 */
public class ConfigInfoGrayMapperByPostgresql extends AbstractMapperByPostgresql implements ConfigInfoGrayMapper {

    @Override
    public MapperResult findAllConfigInfoGrayForDumpAllFetchRows(MapperContext context) {
        String sql = " SELECT id,data_id,group_id,tenant_id,gray_name,gray_rule,app_name,content,md5,gmt_modified "
                + " FROM  config_info_gray  ORDER BY id LIMIT " + context.getPageSize() + " OFFSET "
                + context.getStartRow();
        return new MapperResult(sql, Collections.emptyList());
    }
    
}

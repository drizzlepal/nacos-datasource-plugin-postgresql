package com.drizzlepal.nacos.plugin.datasource.impl.postgresql;

import com.alibaba.nacos.plugin.datasource.mapper.ConfigInfoTagMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.Collections;

/**
 * 标签配置信息 Mapper PostgreSQL 实现
 * 对应数据库表: config_info_tag
 */
public class ConfigInfoTagMapperByPostgresql extends AbstractMapperByPostgresql implements ConfigInfoTagMapper {
    
    @Override
    public MapperResult findAllConfigInfoTagForDumpAllFetchRows(MapperContext context) {
        String sql = " SELECT t.id,data_id,group_id,tenant_id,tag_id,app_name,content,md5,gmt_modified "
                + " FROM (  SELECT id FROM config_info_tag  ORDER BY id OFFSET " + context.getStartRow() + " LIMIT "
                + context.getPageSize() + " ) " + "g, config_info_tag t  WHERE g.id = t.id  ";
        return new MapperResult(sql, Collections.emptyList());
    }
    
}

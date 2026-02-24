package com.drizzlepal.nacos.plugin.datasource.impl.postgresql;

import com.alibaba.nacos.plugin.datasource.mapper.ConfigInfoBetaMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

import java.util.Collections;

/**
 * Beta 配置信息 Mapper PostgreSQL 实现
 * 对应数据库表: config_info_beta
 */
public class ConfigInfoBetaMapperByPostgresql extends AbstractMapperByPostgresql implements ConfigInfoBetaMapper {

    @Override
    public MapperResult findAllConfigInfoBetaForDumpAllFetchRows(MapperContext context) {
        String sql = " SELECT t.id,data_id,group_id,tenant_id,app_name,content,md5,gmt_modified "
                + " FROM (  SELECT id FROM config_info_beta  ORDER BY id OFFSET " + context.getStartRow() + " LIMIT "
                + context.getPageSize() + " ) " + "g, config_info_beta t  WHERE g.id = t.id  ";
        return new MapperResult(sql, Collections.emptyList());
    }

}

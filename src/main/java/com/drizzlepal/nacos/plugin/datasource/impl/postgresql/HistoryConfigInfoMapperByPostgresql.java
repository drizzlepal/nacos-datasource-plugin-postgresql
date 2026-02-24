package com.drizzlepal.nacos.plugin.datasource.impl.postgresql;

import com.alibaba.nacos.common.utils.CollectionUtils;
import com.alibaba.nacos.plugin.datasource.constants.FieldConstant;
import com.alibaba.nacos.plugin.datasource.mapper.HistoryConfigInfoMapper;
import com.alibaba.nacos.plugin.datasource.model.MapperContext;
import com.alibaba.nacos.plugin.datasource.model.MapperResult;

/**
 * 配置历史信息 Mapper PostgreSQL 实现
 * 对应数据库表: his_config_info
 */
public class HistoryConfigInfoMapperByPostgresql extends AbstractMapperByPostgresql implements HistoryConfigInfoMapper {
    
    @Override
    public MapperResult removeConfigHistory(MapperContext context) {
        String sql = "DELETE FROM his_config_info WHERE gmt_modified < ? OFFSET 0 LIMIT ?";
        return new MapperResult(sql, CollectionUtils.list(context.getWhereParameter(FieldConstant.START_TIME),
                context.getWhereParameter(FieldConstant.LIMIT_SIZE)));
    }

    @Override
    public MapperResult findDeletedConfig(MapperContext context) {
        return new MapperResult(
                "SELECT data_id, group_id, tenant_id,gmt_modified,nid FROM his_config_info WHERE op_type = 'D' AND "
                        + "gmt_modified >= ? and nid > ? ORDER BY nid OFFSET 0 LIMIT ? ",
                CollectionUtils.list(context.getWhereParameter(FieldConstant.START_TIME),
                        context.getWhereParameter(FieldConstant.LAST_MAX_ID),
                        context.getWhereParameter(FieldConstant.PAGE_SIZE)));
    }

    @Override
    public MapperResult pageFindConfigHistoryFetchRows(MapperContext context) {
        String sql =
                "SELECT nid,data_id,group_id,tenant_id,app_name,src_ip,src_user,op_type,gmt_create,gmt_modified FROM his_config_info "
                        + "WHERE data_id = ? AND group_id = ? AND tenant_id = ? ORDER BY nid DESC  OFFSET "
                        + context.getStartRow() + " LIMIT " + context.getPageSize();
        return new MapperResult(sql, CollectionUtils.list(context.getWhereParameter(FieldConstant.DATA_ID),
                context.getWhereParameter(FieldConstant.GROUP_ID), context.getWhereParameter(FieldConstant.TENANT_ID)));
    }

}

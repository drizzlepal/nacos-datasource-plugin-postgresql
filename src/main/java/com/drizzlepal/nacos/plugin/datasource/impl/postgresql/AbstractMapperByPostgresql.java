package com.drizzlepal.nacos.plugin.datasource.impl.postgresql;

import com.alibaba.nacos.plugin.datasource.mapper.AbstractMapper;
import com.drizzlepal.nacos.plugin.datasource.constant.DataSourceConstant;

/**
 * PostgreSQL Mapper 抽象基类
 * 提供 PostgreSQL 数据库特有的函数转换和数据源类型标识
 */
public abstract class AbstractMapperByPostgresql extends AbstractMapper {

    @Override
    public String getFunction(String functionName) {
        switch (functionName) {
            case "NOW()":
                return "NOW()";
            default:
                break;
        }
        throw new NotFoundException("functionName " + functionName + " not found");
    }
    @Override
    public String getDataSource() {
        return DataSourceConstant.POSTGRESQL;
    }

}

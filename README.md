# Nacos PostgreSQL DataSource Plugin

## Overview

Nacos PostgreSQL 数据源插件，允许 Nacos 使用 PostgreSQL 作为后端存储。

## Compatibility

**本插件适配 Nacos 3.1.0 版本**

| Nacos Version | Plugin Version |
|--------------|----------------|
| 3.1.0        | 1.0.0-SNAPSHOT |

## Features

支持以下数据库表的 Mapper 实现：

- `ConfigInfoMapper` - 配置信息表
- `ConfigInfoBetaMapper` - Beta 配置表
- `ConfigInfoTagMapper` - 标签配置表
- `ConfigTagsRelationMapper` - 配置标签关联表
- `HistoryConfigInfoMapper` - 配置历史表
- `ConfigInfoGrayMapper` - 灰度配置表
- `ConfigMigrateMapper` - 配置迁移表
- `GroupCapacityMapper` - 分组容量表
- `TenantInfoMapper` - 租户信息表
- `TenantCapacityMapper` - 租户容量表

## Usage

### 1. 添加依赖

```xml
<dependency>
    <groupId>com.drizzlepal.nacos</groupId>
    <artifactId>nacos-datasource-plugin-postgresql</artifactId>
    <version>1.0.0-SNAPSHOT</version>
</dependency>
```

### 2. 配置 PostgreSQL 数据源

在 Nacos 的 `application.properties` 文件中添加：

```properties
spring.datasource.platform=postgresql
spring.datasource.url=jdbc:postgresql://localhost:5432/nacos
spring.datasource.username=nacos
spring.datasource.password=nacos
```

### 3. 初始化数据库

执行 PostgreSQL 建表 SQL 脚本（参考 Nacos 官方提供的 schema-postgresql.sql）

## Build

```bash
mvn clean package
```

## License

Apache License 2.0

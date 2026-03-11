

/******************************************/
/*   表名称 = config_info                  */
/******************************************/
CREATE TABLE nacos.public.config_info (
    id bigserial PRIMARY KEY,
    data_id varchar(255) NOT NULL,
    group_id varchar(128),
    content text NOT NULL,
    md5 varchar(32),
    gmt_create timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    src_user text,
    src_ip varchar(50),
    app_name varchar(128),
    tenant_id varchar(128) DEFAULT '',
    c_desc varchar(256),
    c_use varchar(64),
    effect varchar(64),
    type varchar(64),
    c_schema text,
    encrypted_data_key varchar(1024) NOT NULL DEFAULT '',
    CONSTRAINT uk_configinfo_datagrouptenant UNIQUE (data_id, group_id, tenant_id)
);

COMMENT ON TABLE nacos.public.config_info IS 'config_info';

COMMENT ON COLUMN nacos.public.config_info.id IS 'id';
COMMENT ON COLUMN nacos.public.config_info.data_id IS 'data_id';
COMMENT ON COLUMN nacos.public.config_info.group_id IS 'group_id';
COMMENT ON COLUMN nacos.public.config_info.content IS 'content';
COMMENT ON COLUMN nacos.public.config_info.md5 IS 'md5';
COMMENT ON COLUMN nacos.public.config_info.gmt_create IS '创建时间';
COMMENT ON COLUMN nacos.public.config_info.gmt_modified IS '修改时间';
COMMENT ON COLUMN nacos.public.config_info.src_user IS 'source user';
COMMENT ON COLUMN nacos.public.config_info.src_ip IS 'source ip';
COMMENT ON COLUMN nacos.public.config_info.app_name IS 'app_name';
COMMENT ON COLUMN nacos.public.config_info.tenant_id IS '租户字段';
COMMENT ON COLUMN nacos.public.config_info.c_desc IS 'configuration description';
COMMENT ON COLUMN nacos.public.config_info.c_use IS 'configuration usage';
COMMENT ON COLUMN nacos.public.config_info.effect IS '配置生效的描述';
COMMENT ON COLUMN nacos.public.config_info.type IS '配置的类型';
COMMENT ON COLUMN nacos.public.config_info.c_schema IS '配置的模式';
COMMENT ON COLUMN nacos.public.config_info.encrypted_data_key IS '密钥';


/******************************************/
/*   表名称 = config_info_gray             */
/******************************************/
CREATE TABLE nacos.public.config_info_gray (
    id bigserial PRIMARY KEY,
    data_id varchar(255) NOT NULL,
    group_id varchar(128) NOT NULL,
    content text NOT NULL,
    md5 varchar(32),
    src_user text,
    src_ip varchar(100),
    gmt_create timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    app_name varchar(128),
    tenant_id varchar(128) DEFAULT '',
    gray_name varchar(128) NOT NULL,
    gray_rule text NOT NULL,
    encrypted_data_key varchar(256) NOT NULL DEFAULT '',
    CONSTRAINT uk_configinfogray_datagrouptenantgray
        UNIQUE (data_id, group_id, tenant_id, gray_name)
);

COMMENT ON TABLE nacos.public.config_info_gray IS 'config_info_gray';

COMMENT ON COLUMN nacos.public.config_info_gray.id IS 'id';
COMMENT ON COLUMN nacos.public.config_info_gray.data_id IS 'data_id';
COMMENT ON COLUMN nacos.public.config_info_gray.group_id IS 'group_id';
COMMENT ON COLUMN nacos.public.config_info_gray.content IS 'content';
COMMENT ON COLUMN nacos.public.config_info_gray.md5 IS 'md5';
COMMENT ON COLUMN nacos.public.config_info_gray.src_user IS 'src_user';
COMMENT ON COLUMN nacos.public.config_info_gray.src_ip IS 'src_ip';
COMMENT ON COLUMN nacos.public.config_info_gray.gmt_create IS 'gmt_create';
COMMENT ON COLUMN nacos.public.config_info_gray.gmt_modified IS 'gmt_modified';
COMMENT ON COLUMN nacos.public.config_info_gray.app_name IS 'app_name';
COMMENT ON COLUMN nacos.public.config_info_gray.tenant_id IS 'tenant_id';
COMMENT ON COLUMN nacos.public.config_info_gray.gray_name IS 'gray_name';
COMMENT ON COLUMN nacos.public.config_info_gray.gray_rule IS 'gray_rule';
COMMENT ON COLUMN nacos.public.config_info_gray.encrypted_data_key IS 'encrypted_data_key';

CREATE INDEX idx_dataid_gmt_modified
ON nacos.public.config_info_gray(data_id, gmt_modified);

CREATE INDEX idx_gmt_modified
ON nacos.public.config_info_gray(gmt_modified);


/******************************************/
/*   表名称 = config_tags_relation         */
/******************************************/
CREATE TABLE nacos.public.config_tags_relation (
    nid bigserial PRIMARY KEY,
    id bigint NOT NULL,
    tag_name varchar(128) NOT NULL,
    tag_type varchar(64),
    data_id varchar(255) NOT NULL,
    group_id varchar(128) NOT NULL,
    tenant_id varchar(128) DEFAULT '',
    CONSTRAINT uk_configtagrelation_configidtag
        UNIQUE (id, tag_name, tag_type)
);

COMMENT ON TABLE nacos.public.config_tags_relation IS 'config_tag_relation';

COMMENT ON COLUMN nacos.public.config_tags_relation.id IS 'id';
COMMENT ON COLUMN nacos.public.config_tags_relation.tag_name IS 'tag_name';
COMMENT ON COLUMN nacos.public.config_tags_relation.tag_type IS 'tag_type';
COMMENT ON COLUMN nacos.public.config_tags_relation.data_id IS 'data_id';
COMMENT ON COLUMN nacos.public.config_tags_relation.group_id IS 'group_id';
COMMENT ON COLUMN nacos.public.config_tags_relation.tenant_id IS 'tenant_id';
COMMENT ON COLUMN nacos.public.config_tags_relation.nid IS 'nid, 自增长标识';

CREATE INDEX idx_config_tags_relation_tenant_id
ON nacos.public.config_tags_relation(tenant_id);


/******************************************/
/*   表名称 = group_capacity               */
/******************************************/
CREATE TABLE nacos.public.group_capacity (
    id bigserial PRIMARY KEY,
    group_id varchar(128) NOT NULL DEFAULT '',
    quota integer NOT NULL DEFAULT 0,
    usage integer NOT NULL DEFAULT 0,
    max_size integer NOT NULL DEFAULT 0,
    max_aggr_count integer NOT NULL DEFAULT 0,
    max_aggr_size integer NOT NULL DEFAULT 0,
    max_history_count integer NOT NULL DEFAULT 0,
    gmt_create timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_group_id UNIQUE (group_id)
);

COMMENT ON TABLE nacos.public.group_capacity IS '集群、各Group容量信息表';


/******************************************/
/*   表名称 = his_config_info              */
/******************************************/
CREATE TABLE nacos.public.his_config_info (
    nid bigserial PRIMARY KEY,
    id bigint NOT NULL,
    data_id varchar(255) NOT NULL,
    group_id varchar(128) NOT NULL,
    app_name varchar(128),
    content text NOT NULL,
    md5 varchar(32),
    gmt_create timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    src_user text,
    src_ip varchar(50),
    op_type char(10),
    tenant_id varchar(128) DEFAULT '',
    encrypted_data_key varchar(1024) NOT NULL DEFAULT '',
    publish_type varchar(50) DEFAULT 'formal',
    gray_name varchar(128),
    ext_info text
);

COMMENT ON TABLE nacos.public.his_config_info IS '多租户改造';

CREATE INDEX idx_his_config_info_gmt_create
ON nacos.public.his_config_info(gmt_create);

CREATE INDEX idx_his_config_info_gmt_modified
ON nacos.public.his_config_info(gmt_modified);

CREATE INDEX idx_his_config_info_data_id
ON nacos.public.his_config_info(data_id);


/******************************************/
/*   表名称 = tenant_capacity              */
/******************************************/
CREATE TABLE nacos.public.tenant_capacity (
    id bigserial PRIMARY KEY,
    tenant_id varchar(128) NOT NULL DEFAULT '',
    quota integer NOT NULL DEFAULT 0,
    usage integer NOT NULL DEFAULT 0,
    max_size integer NOT NULL DEFAULT 0,
    max_aggr_count integer NOT NULL DEFAULT 0,
    max_aggr_size integer NOT NULL DEFAULT 0,
    max_history_count integer NOT NULL DEFAULT 0,
    gmt_create timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gmt_modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_tenant_id UNIQUE (tenant_id)
);

COMMENT ON TABLE nacos.public.tenant_capacity IS '租户容量信息表';


/******************************************/
/*   表名称 = tenant_info                  */
/******************************************/
CREATE TABLE nacos.public.tenant_info (
    id bigserial PRIMARY KEY,
    kp varchar(128) NOT NULL,
    tenant_id varchar(128) DEFAULT '',
    tenant_name varchar(128) DEFAULT '',
    tenant_desc varchar(256),
    create_source varchar(32),
    gmt_create bigint NOT NULL,
    gmt_modified bigint NOT NULL,
    CONSTRAINT uk_tenant_info_kptenantid UNIQUE (kp, tenant_id)
);

COMMENT ON TABLE nacos.public.tenant_info IS 'tenant_info';

CREATE INDEX idx_tenant_info_tenant_id
ON nacos.public.tenant_info(tenant_id);


/******************************************/
/*   表名称 = users                        */
/******************************************/
CREATE TABLE nacos.public.users (
    username varchar(50) PRIMARY KEY,
    password varchar(500) NOT NULL,
    enabled boolean NOT NULL
);


/******************************************/
/*   表名称 = roles                        */
/******************************************/
CREATE TABLE nacos.public.roles (
    username varchar(50) NOT NULL,
    role varchar(50) NOT NULL,
    CONSTRAINT idx_user_role UNIQUE (username, role)
);


/******************************************/
/*   表名称 = permissions                  */
/******************************************/
CREATE TABLE nacos.public.permissions (
    role varchar(50) NOT NULL,
    resource varchar(128) NOT NULL,
    action varchar(8) NOT NULL,
    CONSTRAINT uk_role_permission UNIQUE (role, resource, action)
);
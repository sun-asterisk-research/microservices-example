package config

import (
	"github.com/spf13/viper"
)

type AccountServiceConfig struct {
	Host          string `mapstructure:"HOST"`
	Port          int    `mapstructure:"PORT"`
	ReflectServer bool   `mapstructure:"REFLECT_SERVER"`

	DBHost     string `mapstructure:"DB_HOST"`
	DBPort     int    `mapstructure:"DB_PORT"`
	DBUser     string `mapstructure:"DB_USER"`
	DBPassword string `mapstructure:"DB_PASSWORD"`
	DBDatabase string `mapstructure:"DB_NAME"`

	JWTCertPath string `mapstructure:"JWT_CERT_PATH"`
	JWTAudience string `mapstructure:"JWT_AUDIENCE"`

	Tracing TracingConfig `mapstructure:",squash"`
}

type TracingConfig struct {
	Enable bool         `mapstructure:"TRACING_ENABLE"`
	Jaeger JaegerConfig `mapstructure:",squash"`
}

type JaegerConfig struct {
	URL string `mapstructure:"JAEGER_URL"`
}

var Values *AccountServiceConfig

func Tracing() TracingConfig {
	return Values.Tracing
}

func ReadEnv() {
	viper.SetConfigFile(".env")

	viper.SetDefault("HOST", "127.0.0.1")
	viper.SetDefault("PORT", 50051)
	viper.SetDefault("REFLECT_SERVER", false)

	viper.SetDefault("DB_HOST", "postgres")
	viper.SetDefault("DB_PORT", 5432)
	viper.SetDefault("DB_USER", "hasura")
	viper.SetDefault("DB_PASSWORD", "secret")
	viper.SetDefault("DB_NAME", "accounts")

	viper.SetDefault("JWT_CERT_PATH", "/jwt-cert")
	viper.SetDefault("JWT_AUDIENCE", "blog")
	viper.SetDefault("TRACING_ENABLE", false)

	viper.ReadInConfig()
	viper.AutomaticEnv()
	viper.Unmarshal(&Values)
}

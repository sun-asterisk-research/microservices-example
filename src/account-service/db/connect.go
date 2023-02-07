package db

import (
	"account/config"
	"fmt"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func Connect() (*gorm.DB, error) {
	dsn := fmt.Sprintf("host=%s port=%d user=%s dbname=%s password=%s sslmode=disable",
		config.Values.DBHost,
		config.Values.DBPort,
		config.Values.DBUser,
		config.Values.DBDatabase,
		config.Values.DBPassword,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err == nil {
		db.AutoMigrate(&Account{})
	}

	return db, err
}

package db

import (
	"time"
)

type Account struct {
	ID              int    `gorm:"not null;primaryKey;autoIncrement"`
	Fullname        string `gorm:"not null;size:255"`
	Username        string `gorm:"not null;unique;size:30"`
	Email           string `gorm:"not null;unique;size:255"`
	PasswordHash    string `gorm:"size:72"`
	Avatar          string `gorm:"size:41"`
	Birthday        time.Time
	EmailVerifiedAt time.Time `gorm:"index"`
	CreatedAt       time.Time `gorm:"not null;default:NOW();autoCreateTime:true"`
	UpdatedAt       time.Time `gorm:"not null;default:NOW();autoUpdateTime:true"`
}

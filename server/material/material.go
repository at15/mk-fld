package material

// Material represents a material properties
type Material struct {
	Name   string             `json:"name"`
	R      map[string]float64 `json:"r"` // NOTE: {"number":1.123} NOT {"number":"123"}, later will result in 0
	Source string             `json:"source"`
}

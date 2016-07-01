package material

// Material represents a material properties
type Material struct {
	Name      string             `json:"name"`
	R         map[string]float64 `json:"r"` // NOTE: {"number":1.123} NOT {"number":"123"}, later will result in 0
	Source    string             `json:"source"`
	Hardening []string           `json:"hardening"`
	Yield     []string           `json:"yield"`
	Swift     map[string]float64 `json:"swift"`
	Voce      map[string]float64 `json:"voce"`
}

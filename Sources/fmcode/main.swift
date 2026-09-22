import FoundationModels

let model = SystemLanguageModel.default

switch model.availability {
  case .available:
    print("Model is available.")
  case .unavailable(.deviceNotEligible):
    print("This device doesn't support Apple Intelligence.")
  case .unavailable(.appleIntelligenceNotEnabled):
    print("Apple Intelligence is not enabled.")
  case .unavailable(.modelNotReady):
    print("Model assets are still downloading.")
  case .unavailable(let other):
    print("Model Unavailable: \(other)")
}

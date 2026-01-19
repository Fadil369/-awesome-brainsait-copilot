# Contributing to BrainSAIT Awesome Copilot

Thank you for your interest in contributing to the BrainSAIT Copilot Enterprise ecosystem! We welcome contributions from healthcare developers, clinicians, and AI enthusiasts.

## 🏥 Healthcare-First Approach

All contributions must prioritize:
- Patient safety and data privacy
- Healthcare compliance (HIPAA, Saudi regulations)
- Medical accuracy and clinical validation
- NPHIES and FHIR standards compliance

## 🤝 How to Contribute

### 1. Types of Contributions

We welcome:
- **New Agents**: Specialized healthcare AI agents
- **Prompts**: Healthcare-specific prompt templates
- **Instructions**: Medical coding and NPHIES guidelines
- **Bug Fixes**: Corrections to existing content
- **Documentation**: Improved healthcare guidance
- **Use Cases**: Real-world healthcare scenarios (de-identified)

### 2. Healthcare Data Guidelines

**CRITICAL**: Never include:
- ❌ Real patient data (PHI/PII)
- ❌ Actual policy numbers or identifiers
- ❌ Real medical record numbers
- ❌ Identifiable healthcare provider information

**Always use**:
- ✅ De-identified sample data
- ✅ Fictional patient examples
- ✅ Generic policy numbers (POL-XXXX-XXXX format)
- ✅ Standard medical terminology

### 3. Contribution Process

1. **Fork the Repository**
   ```bash
   git clone https://github.com/brainsait/awesome-brainsait-copilot.git
   cd awesome-brainsait-copilot
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-healthcare-contribution
   ```

3. **Make Changes**
   - Follow file naming conventions (lowercase-with-hyphens)
   - Include proper markdown frontmatter
   - Add healthcare-specific tags
   - Test with de-identified data

4. **Submit Pull Request**
   - Describe the healthcare use case
   - Explain medical context if applicable
   - Reference NPHIES/FHIR standards if relevant
   - Confirm data is de-identified

### 4. Agent Contribution Guidelines

When creating a new agent (`.agent.md`):

```markdown
---
description: 'Clear description of healthcare agent purpose'
tools: ['relevant-medical-tools']
model: 'gpt-4'
tags: ['healthcare', 'specialty', 'saudi-arabia']
---

# Agent Name

Clear explanation of medical/healthcare functionality

## Capabilities
- Specific healthcare tasks
- Clinical decision support features
- NPHIES/FHIR integration points

## Example Usage
[Include de-identified examples]
```

### 5. Prompt Contribution Guidelines

Healthcare prompts (`.prompt.md`) should:
- Focus on specific medical tasks
- Include proper medical terminology
- Reference coding standards (ICD-10, CPT)
- Provide NPHIES-compliant examples
- Support Arabic/English as needed

### 6. Code of Conduct

We follow the [Contributor Covenant](CODE_OF_CONDUCT.md) with additional healthcare-specific guidelines:

- Respect patient confidentiality
- Maintain medical professionalism
- Verify clinical accuracy
- Acknowledge medical uncertainty
- Defer to healthcare professionals for clinical decisions

### 7. Quality Standards

All contributions must:
- Be clinically accurate (review by healthcare professional recommended)
- Follow NPHIES technical specifications
- Comply with FHIR R4 standards
- Include appropriate error handling
- Have clear documentation

### 8. Testing Requirements

- Test with de-identified data only
- Validate FHIR resource structure
- Check NPHIES API compliance
- Verify medical code accuracy
- Ensure Arabic/English support (where applicable)

### 9. Documentation Standards

- Use clear, medical-appropriate language
- Include clinical context
- Reference authoritative sources (NPHIES docs, FHIR specs)
- Provide usage examples
- Explain healthcare workflows

### 10. Review Process

Pull requests will be reviewed for:
1. **Healthcare Compliance**: HIPAA, Saudi regulations, data privacy
2. **Medical Accuracy**: Clinical validity, coding correctness
3. **Technical Quality**: Code quality, FHIR compliance
4. **Documentation**: Clear explanations, proper formatting
5. **Security**: No PHI/PII, proper authentication patterns

## 📋 Frontmatter Requirements

### For Agents (*.agent.md)
```yaml
---
description: 'Healthcare agent description'
tools: ['medical-tools']
model: 'gpt-4'
tags: ['healthcare', 'nphies', 'saudi-arabia']
---
```

### For Prompts (*.prompt.md)
```yaml
---
agent: 'agent'
description: 'Healthcare prompt description'
tools: ['relevant-tools']
model: 'gpt-4'
tags: ['medical', 'coding', 'clinical']
---
```

### For Instructions (*.instructions.md)
```yaml
---
description: 'Coding standards description'
applyTo: '**.js, **.ts, **.py'
tags: ['fhir', 'nphies', 'healthcare']
---
```

## 🎯 Priority Areas

We especially welcome contributions in:
- NPHIES integration patterns
- FHIR R4 Saudi extensions
- Arabic language medical NLP
- Denial prevention strategies
- Clinical documentation improvement
- Medical image analysis
- Voice-to-clinical-notes accuracy

## 📞 Getting Help

- Email: docs@brainsait.com
- GitHub Issues: Report bugs or request features
- Documentation: See BRAINSAIT-AGENTS.md for technical details

## 🏆 Recognition

Contributors will be recognized in:
- Repository contributors list
- Release notes for significant contributions
- BrainSAIT website (with permission)

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License with healthcare compliance notices.

---

## Healthcare Disclaimer

All AI-generated content must be reviewed by qualified healthcare professionals before use in clinical settings. Contributors are not liable for clinical decisions made using this software. Always prioritize patient safety and follow institutional protocols.

---

**Thank you for helping transform Saudi healthcare through AI!**

*BrainSAIT Healthcare AI Team*
*Website: brainsait.com | Email: docs@brainsait.com*

package sms.swp391.services;

import sms.swp391.models.dtos.requests.*;
import sms.swp391.models.dtos.respones.*;
import java.util.List;

public interface HealthCheckService {

    // Campaign Management
    HealthCheckCampaignResponse createCampaign(HealthCheckCampaignRequestDTO request, Long createdById);

    HealthCheckCampaignResponse updateCampaign(Long id, HealthCheckCampaignRequestDTO request);

    void startCampaign(Long campaignId);

    HealthCheckCampaignResponse getCampaignById(Long id);

    List<HealthCheckCampaignResponse> getAllCampaigns();

    // Consent Management
    HealthCheckConsentResponse updateConsent(Long consentId, HealthCheckConsentRequestDTO request, Long parentId);

    List<HealthCheckConsentResponse> getConsentsByCampaign(Long campaignId);

    HealthCheckConsentResponse getConsentById(Long consentId);

    List<HealthCheckConsentResponse> getPendingConsentsByParent(Long parentId);

    // Result Management
    HealthCheckResultResponse saveResult(HealthCheckResultRequestDTO request, Long checkedById);

    HealthCheckResultResponse getResultById(Long resultId);

    List<HealthCheckResultResponse> getResultsByCampaign(Long campaignId);

    List<HealthCheckResultResponse> getResultsByStudent(Long studentId);

    List<HealthCheckResultResponse> getResultsRequiringFollowUp();
}
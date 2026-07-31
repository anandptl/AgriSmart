<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="crop-cards-container">
    <c:forEach var="crop" items="${cropList}">

        <div class="crop-card">
            <div class="card-image-wrapper">
                <c:if test="${not empty crop.cropImage}">
                    <img src="/admin/crop/image/${crop.id}" alt="${crop.cropName}">
                </c:if>
                <span class="crop-tag ">
                    ${crop.season}
                </span>

                <div class="rating">
                    <i class="fa-solid fa-star"></i>
                </div>
            </div>

            <div class="card-content">
                <h3>${crop.cropName}</h3>

                <div class="details-row">
                    <div class="detail-item water-need">
                        <i class="fa-solid fa-droplet"></i>${crop.waterNeed}
                    </div>

                    <div class="detail-item duration">
                        <i class="fa-regular fa-clock"></i>
                        ${crop.growthDuration}
                    </div>
                </div>

                <div class="details-row">
                    <div class="detail-item yield">
                        <i class="fa-solid fa-indian-rupee-sign"></i>
                        ${crop.minPrice} - ${crop.maxPrice}
                    </div>
                </div>
                <c:choose>

                    <c:when test="${appliedIds.contains(crop.id)}">
                        <a href="/farmer/crop/unapply/${crop.id}"
                           class="apply-btn btn-unapply">
                            Unapply
                        </a>
                    </c:when>

                    <c:otherwise>
                        <a href="/farmer/crop/apply/${crop.id}"
                           class="apply-btn btn-apply">
                            Apply
                        </a>
                    </c:otherwise>

                </c:choose>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty cropList}">
        <p>No crops found.</p>
    </c:if>
</div>


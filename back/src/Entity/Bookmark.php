<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\BookmarkRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

use ApiPlatform\Metadata\Get;
use ApiPlatform\Metadata\Put;



#[Get(
    security: "is_granted('ROLE_USER') or is_granted('IS_AUTHENTICATED_FULLY')",
    securityMessage: "You are not authentificated",
)]
#[Put(
    security: "is_granted('IS_AUTHENTICATED_FULLY')",
    securityMessage: "You are not authentificated",
)]

#[ORM\Entity(repositoryClass: BookmarkRepository::class)]
#[ApiResource]
class Bookmark
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?int $userID = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $comicsId = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserID(): ?int
    {
        return $this->userID;
    }

    public function setUserID(int $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getComicsId(): ?string
    {
        return $this->comicsId;
    }

    public function setComicsId(?string $comicsId): self
    {
        $this->comicsId = $comicsId;

        return $this;
    }
}

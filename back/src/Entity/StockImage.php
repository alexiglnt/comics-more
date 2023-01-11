<?php

namespace App\Entity;

use App\Repository\StockImageRepository;
use Doctrine\ORM\Mapping as ORM;

use ApiPlatform\Metadata\ApiResource;

#[ORM\Entity(repositoryClass: StockImageRepository::class)]
#[ApiResource(paginationEnabled: false)]
class StockImage            // ANCIENNE ENTITY (ON NE VA SUREMENT PLUS S'EN SERVIR)
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $link = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLink(): ?string
    {
        return $this->link;
    }

    public function setLink(string $link): self
    {
        $this->link = $link;

        return $this;
    }
}
